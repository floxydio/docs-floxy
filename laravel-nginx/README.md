
## Documentation Nginx - Laravel

// docker for nginx
```docker
services:
  nginx:
    image: nginx:latest
    container_name: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /root/docker/nginx.conf:/etc/nginx/nginx.conf
      - /root/docker/html:/usr/share/nginx/html
      - /etc/certs:/etc/certs
      - /root/docker/snippets:/etc/nginx/snippets
      - /root/dashboard-laravel:/var/www
    networks:
      - laravel-network
    restart: always

networks:
  laravel-network:
    external: true
```

//docker for database
```docker
services:
  # Database
  db:
    image: mysql:5.7
    container_name: db_mysql
    command: --innodb-buffer-pool-size=50M --innodb-log-buffer-size=8M --innodb-flush-log-at-trx-commit=2 --innodb-file-per-table=1 --max-connections=25
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_PASSWORD: root
      MYSQL_USER: root
      MYSQL_MAX_CONNECTIONS: 25
    deploy:
      resources:
        limits:
          memory: 512M
    networks:
      - mysql-phpmyadmin

  # phpmyadmin
  phpmyadmin:
    depends_on:
      - db
    image: phpmyadmin
    restart: always
    ports:
      - "8090:80"
    environment:
      PMA_HOST: db
      MYSQL_ROOT_PASSWORD: root
      UPLOAD_LIMIT: 1000000000
    networks:
      - mysql-phpmyadmin

networks:
  mysql-phpmyadmin:
   external: true

volumes:
  db_data:
```

// docker for laravel
```docker
services:
  app:
    build: .
    container_name: laravel_app
    working_dir: /var/www
    volumes:
      - .:/var/www
      - ./docker/php/local.ini:/usr/local/etc/php/conf.d/local.ini
      - ./public:/var/www/public
    networks:
      - laravel-network
      - mysql-phpmyadmin
    command: php-fpm

networks:
  laravel-network:
    external: true
  mysql-phpmyadmin:
    external: true
```

inside directory laravel-dashboard / create folder docker / inside docker create directory php and create file local.ini

// local.ini

```ini
upload_max_filesize=40M
post_max_size=40M
```

for nginx, mysql create folder docker and create nginx.conf

this config used in nginx docker compose 

- /root/docker/nginx.conf:/etc/nginx/nginx.conf


// nginx.conf

```conf
events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        server_name yourdomain.com;

        # Redirect HTTP to HTTPS
        location / {
            return 301 https://$host$request_uri;
        }
    }

    server {
        listen 443 ssl;
        server_name yourdomain.com;

        ssl_certificate /etc/certs/fullchain.pem;
        ssl_certificate_key /etc/certs/privkey.pem;

        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_prefer_server_ciphers on;

        root /var/www/public;
        index index.php index.html;

        location / {
           try_files $uri $uri/ /index.php?$query_string;
        }

        location /api {
            proxy_pass http://your_up; # Change this to your backend service
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        location ~ \.php$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            include /etc/nginx/snippets/fastcgi-php.conf;
            fastcgi_pass laravel_app:9000;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include fastcgi_params;
        }

        location ~* \.(css|js|jpg|jpeg|png|gif|ico|svg|woff|woff2|ttf|eot)$ {
            expires 1y;
            access_log off;
            add_header Cache-Control "public, must-revalidate, proxy-revalidate";
        }
        location ~ /\.ht {
            deny all;
        }
     }
}
```

Create directory inside 'docker' called snippets and inside snippets create this file 

this config used in nginx docker in here 

- /root/docker/snippets:/etc/nginx/snippets

// fastcgi-php.conf

```conf
fastcgi_param QUERY_STRING       $query_string;
fastcgi_param REQUEST_METHOD     $request_method;
fastcgi_param CONTENT_TYPE       $content_type;
fastcgi_param CONTENT_LENGTH     $content_length;

fastcgi_param SCRIPT_FILENAME    $document_root$fastcgi_script_name;
fastcgi_param SCRIPT_NAME        $fastcgi_script_name;
fastcgi_param PATH_INFO          $fastcgi_path_info;
fastcgi_param PATH_TRANSLATED    $document_root$fastcgi_path_info;
fastcgi_param REQUEST_URI        $request_uri;
fastcgi_param DOCUMENT_URI       $document_uri;
fastcgi_param DOCUMENT_ROOT      $document_root;
fastcgi_param SERVER_PROTOCOL    $server_protocol;

fastcgi_param GATEWAY_INTERFACE  CGI/1.1;
fastcgi_param SERVER_SOFTWARE    nginx/$nginx_version;

fastcgi_param REMOTE_ADDR        $remote_addr;
fastcgi_param REMOTE_PORT        $remote_port;
fastcgi_param SERVER_ADDR        $server_addr;
fastcgi_param SERVER_PORT        $server_port;
fastcgi_param SERVER_NAME        $server_name;

fastcgi_param HTTPS              $https if_not_empty;

# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param REDIRECT_STATUS    200;
```

FYI :

laravel-network : for bridge laravel to nginx <br>
mysql-phpmyadmin : for bridge mysql & phpmyadmin to laravel for running read database <br>
<br>
external-true : for bridge network
Ya, fungsi load balancing dan replikasi juga ada di Kubernetes. Kubernetes dan Docker Swarm memiliki tujuan yang serupa dalam mengelola kontainer, tetapi mereka memiliki perbedaan mendasar:

### Kesamaan
1. **Orkestrasi Kontainer**: Keduanya mengatur dan mengelola kontainer dalam skala besar.
2. **Load Balancing**: Keduanya mendistribusikan lalu lintas ke beberapa replika untuk memastikan stabilitas dan ketersediaan.
3. **Skalabilitas**: Memungkinkan penskalaan horizontal dengan menambah atau mengurangi replika kontainer.
4. **Penyembuhan Diri (Self-Healing)**: Mengganti kontainer yang gagal secara otomatis.

### Perbedaan
1. **Kompleksitas**:
   - **Docker Swarm**: Lebih sederhana dan lebih mudah diatur, cocok untuk pemula dan proyek yang lebih kecil.
   - **Kubernetes**: Lebih kompleks dengan fitur yang lebih kaya, cocok untuk aplikasi besar dan kompleks.

2. **Ekosistem dan Dukungan**:
   - **Docker Swarm**: Terintegrasi langsung dengan Docker, lebih mudah bagi pengguna Docker.
   - **Kubernetes**: Didukung oleh komunitas yang besar dan memiliki ekosistem yang luas, termasuk banyak alat bantu dan integrasi.

3. **Fitur Lain**:
   - **Docker Swarm**: Fokus pada kesederhanaan dan integrasi dengan Docker.
   - **Kubernetes**: Menyediakan fitur-fitur canggih seperti autoscaling, namespaces, dan network policies.

### Singkatnya
Kubernetes dan Docker Swarm keduanya mendukung load balancing dan replikasi untuk meningkatkan stabilitas dan ketersediaan layanan. Kubernetes lebih kompleks dan kaya fitur, sementara Docker Swarm lebih sederhana dan mudah diatur.



DOCS : 
https://medium.com/@nidhinbabukuttan/docker-swarm-basics-a-step-by-step-guide-for-beginners-e3e1fed9e9fe

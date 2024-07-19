** Work for Centos 7 **

mkdir /etc/yum.repos.d/old

mv /etc/yum.repos.d/CentOS*.repo /etc/yum.repos.d/old/

mv /etc/yum.repos.d/epel*.repo /etc/yum.repos.d/old/

nano /etc/yum.repos.d/CentOS.repo

```bash
[base]
name=CentOS-7.9.2009 - Base
baseurl=http://vault.centos.org/7.9.2009/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
metadata_expire=never
 
#released updates
[updates]
name=CentOS-7.9.2009 - Updates
baseurl=http://vault.centos.org/7.9.2009/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
metadata_expire=never
 
# additional packages that may be useful
[extras]
name=CentOS-7.9.2009 - Extras
baseurl=http://vault.centos.org/7.9.2009/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
metadata_expire=never
 
# additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-7.9.2009 - CentOSPlus
baseurl=http://vault.centos.org/7.9.2009/centosplus/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=0
metadata_expire=never
 
#fasttrack - packages by Centos Users
[fasttrack]
name=CentOS-7.9.2009 - Contrib
baseurl=http://vault.centos.org/7.9.2009/fasttrack/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=0
metadata_expire=never
```

nano /etc/yum.repos.d/epel.repo

``` bash
[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
baseurl=https://archives.fedoraproject.org/pub/archive/epel/7/$basearch
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
metadata_expire=never
 
[epel-debuginfo]
name=Extra Packages for Enterprise Linux 7 - $basearch - Debug
baseurl=https://archives.fedoraproject.org/pub/archive/epel/7/$basearch/debug
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
gpgcheck=1
metadata_expire=never
 
[epel-source]
name=Extra Packages for Enterprise Linux 7 - $basearch - Source
baseurl=https://archives.fedoraproject.org/pub/archive/epel/7/SRPMS
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
gpgcheck=1
metadata_expire=never
```
yum clean all
yum check-update
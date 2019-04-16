# Create a YUM Local Repository for Centos7 - build 1810

#### Source: https://www.tecmint.com/setup-local-http-yum-repository-on-centos-7/

## Requiriments
1. Internet access
2. Install packages via yum or rpm: reposync, libxml2-python, deltarpm, python-deltarpm
3. Root access to edit repofiles
4. An installation of the same SO's distribution, version and build
5. Aboout 5-7 GB of free space on disk 

## Steps

Download all the packages for your platform

```bash
cd ~
mkdir ~/localrepo
for x in base centosplus extras updates; do 
  reposync -g -l -d -m --repoid=$x --newest-only --download-metadata --download_path=localrepo/; 
done
```

After that, create a file in *_/etc/yum.repos.d/_* using this model

```
[local-base]
name=CentOS Base
baseurl=file:///path/to/local/repo
gpgcheck=0
enabled=1

[local-centosplus]
name=CentOS CentOSPlus
baseurl=file:///path/to/local/repo
gpgcheck=0
enabled=1

[local-extras]
name=CentOS Extras
baseurl=file:///path/to/local/repo
gpgcheck=0
enabled=1

[local-updates]
name=CentOS Updates
baseurl=file:///path/to/local/repo
gpgcheck=0
enabled=1
```

# PHP FPM 7.2.34 based on Alpine Linux 3.12

## PHP Extensions Included -

### Core Extensions :

* bcmath
* bz2
* calendar
* curl
* exif
* fileinfo
* ftp
* gd
* gettext
* imap
* intl
* ldap
* mbstring
* mysqli
* opcache
* pdo
* pdo_mysql
* redis
* soap
* sysvsem
* sysvshm
* xmlrpc
* xsl
* zip

### Additional Extensions :

* imagick
* mcrypt
* mongodb
* sodium
* Zend Optimizer Plus (Opcache)
* Uploadprogress
* Memcached

### Other Tools :
* composer
* wp-cli

<em>(composer and wp-cli can be used from within the container)</em>


### Extension for sending email :

* msmtp

  To build this image, just run
```docker image build -t  image_name .```

  To build multi-arch image, run
```docker buildx build --push  --platform linux/amd64,linux/arm64 --tag your_docker_username/multi_arch_image_name:tag-latest .```

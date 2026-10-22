# PHP FPM 8.4 based on Alpine Linux 3.21

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
* openssl
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
* mongodb
* sodium
* Zend Optimizer Plus (Opcache)
* Xdebug
* XHProf
* Uploadprogress
* Memcached

<em>(mcrypt is no longer supported for PHP 8.4 and is excluded)</em>

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


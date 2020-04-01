# PHP FPM 7.3 based on Alpine Linux 3.11

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
* Xdebug
* [Tideways PHP Profiler](https://github.com/tideways/php-profiler-extension.git)
* Uploadprogress
* Memcached

### Extension for sending email :

* msmtp

  To build this image, just run  
```docker image build -t  imagename .```
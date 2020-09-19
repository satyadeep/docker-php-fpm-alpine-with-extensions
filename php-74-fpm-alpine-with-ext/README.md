# PHP FPM 7.4 based on Alpine Linux 3.12

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
* Uploadprogress Modfied Version from [here](https://github.com/Jan-E/uploadprogress)
* Memcached

### Other Tools :
* composer
* wp-cli

<em>(These can be used from within the container)</em>


### Extension for sending email :

* msmtp

  To build this image, just run  
```docker image build -t  imagename .```

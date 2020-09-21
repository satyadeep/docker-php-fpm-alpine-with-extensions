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
* XHProf
* Uploadprogress
* Memcached

### Other Tools :
* composer
* wp-cli

<em>(composer and wp-cli can be used from within the container)</em>


### Extension for sending email :

* msmtp

  To build this image, just run  
```docker image build -t  imagename .```

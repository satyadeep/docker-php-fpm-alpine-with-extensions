# PHP FPM 5.3 based on Alpine Linux 3.4.6

## PHP Extensions Included -

### Core Extensions:

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
* mcrypt
* mysql
* mysqli
* pdo
* pdo_mysql
* soap
* sysvsem
* sysvshm
* xmlrpc
* xsl
* zip

### Additional Extensions :

* mongo Version 1.6.16 (As this is the last verison compatible with PHP 5)
* Zend Optimizer Plus (Opcache)
* Xdebug Version 2.2 (As this is the last version compatible with PHP 5.3)
* Twig Version 1.36 (As this is the last version compatible with PHP 5)
* XHProf
* Uploadprogress
* Memcache 2.2.7 (As this is the last version compatible with PHP 5)

  To build this image, just run  
```docker image build -t  imagename .```
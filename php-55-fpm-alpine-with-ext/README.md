# PHP FPM 5.5 based on Alpine Linux 3.8.4

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
* mcrypt
* mysql
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
* mongo Version 1.6.16 (As this is the last version compatible with PHP 5.X)
* Zend Optimizer Plus (Opcache)
* Xdebug Version 2.5.5 (As this is the last version compatible with PHP 5.X)
* Twig 1.36 (As this is the last version compatible with PHP 5.X)
* XHProf (Using Xhprof 0.9.4 as support for PHP 5.X has been dropped in later versions)
* Uploadprogress
* Memcache 2.2.7 (Using memcache 2.2.7 as 3.0.8 won't load even though it installs and support for PHP 5.X has been dropped in later versions)

### Extension for sending email :

* msmtp

  To build this image, just run  
```docker image build -t  imagename .```
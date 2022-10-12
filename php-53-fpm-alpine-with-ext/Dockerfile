FROM satyadeep/php-53-fpm-alpine:latest

LABEL MAINTAINER="SATYADEEP G" \
      "GitHub Link"="https://github.com/satyadeep" \
      "PHP Version"="5.3.29" \
      "Alpine Linux Version"="3.4.6"

RUN apk add --no-cache --virtual .build-deps \
        # for all
        git \
        #for bzip
        bzip2-dev \
        #for curl
        curl-dev \
        # for intl extension
        gettext-dev \
        zlib-dev \
        fcgi \
        # dev deps for gd
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        # for intl
        icu-dev \
        #for imap
        imap-dev \
        #for mysql
        mariadb-dev \
        # for mcrypt
        libmcrypt-dev \
        # for memcache
        libmemcached-dev \
        # for soap
        libxml2-dev \
        # for gd
        libxpm-dev \
        # for xsl
        libxslt-dev \
        libgcrypt-dev \
        # for ldap
        openldap-dev \
        pcre-dev\
        # to build xdebug from PECL
        $PHPIZE_DEPS \
    && apk add libbz2 freetype libjpeg-turbo libpng libxpm libintl icu-libs libldap libmcrypt libxslt \
    && docker-php-ext-configure gd --with-gd --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --enable-gd-native-ttf \
    && docker-php-ext-install \
            bcmath \
            bz2 \
            calendar \
            curl \
            exif \
            fileinfo \
            ftp \
            gd \
            gettext \
            imap \
            intl \
            ldap \
            mbstring \
            mcrypt \
            mysql \
            mysqli \
            pdo \
            pdo_mysql \
            soap \
            sysvsem \
            sysvshm \
            xmlrpc \
            xsl \
            zip \
    && git clone https://github.com/zendtech/ZendOptimizerPlus.git /tmp/ZendOptimizerPlus \
        && ( \
            cd /tmp/ZendOptimizerPlus \
            && phpize \
            && ./configure \
            && make -j$(nproc) \
            && make install \
            && cd .. \
        ) \
        && git clone --branch 1.x https://github.com/satyadeep/Twig.git /tmp/twig \
	&& cd /tmp/twig \
	&& git checkout 0fc3341a398171c6bab43b277caecfaa1ef4e026 \
        && ( \
            cd /tmp/twig/ext/twig \
            && phpize \
            && ./configure \
            && make -j$(nproc) \
            && make install \
            && cd .. \
        ) \
        && rm -r /tmp/ZendOptimizerPlus  \
        && rm -r /tmp/twig \
        && pecl install uploadprogress \
        # && pecl install imagick \  #requires PHP (version >= 5.4.0)       
        && pecl install mongo \
        #####   Using memcache 2.2.7 as 3.0.8 won't load even though it installs 
        # and support for PHP 5.X has been dropped in later versions   #####
        && pecl install memcache-2.2.7 \
        && docker-php-ext-enable opcache \
            # imagick \ #requires PHP (version >= 5.4.0)
            mongo \
            memcache \
            twig \
            uploadprogress \
        &&  echo -e "\n opcache.enable=1 \n opcache.enable_cli=1 \n opcache.memory_consumption=128 \n opcache.interned_strings_buffer=8 \n opcache.max_accelerated_files=4000 \n opcache.revalidate_freq=60 \n opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
        &&  echo -e "\n xdebug.remote_enable=1 \n xdebug.remote_host=localhost \n xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        &&  echo -e "\n xhprof.output_dir='/var/tmp/xhprof'" >> /usr/local/etc/php/conf.d/docker-php-ext-xhprof.ini \
    # next will add runtime deps for php extensions
    # what this does is checks the necessary packages for php extensions Shared Objects
    # and adds those (won't be removed when .build-deps are)
    && runDeps="$( \
            scanelf --needed --nobanner --recursive \
                /usr/local/lib/php/extensions \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
        )" \
# Install composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "copy('https://composer.github.io/installer.sig', 'signature');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('signature'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
# Install msmtp - To Send Mails on Production & Development
    && wget https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
    && chmod +x mhsendmail_linux_amd64 \
    && mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail \
    \
    && apk add --virtual .phpexts-rundeps $runDeps \
    && apk del .build-deps

# modify www-data user to have id 1000
RUN apk add \
        --no-cache \
        --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
        --virtual .shadow-deps \
        shadow \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && apk del .shadow-deps
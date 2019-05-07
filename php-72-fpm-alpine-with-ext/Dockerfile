FROM php:7.2-fpm-alpine

LABEL MAINTAINER="SATYADEEP G" \
      "GitHub Link"="https://github.com/satyadeep" \
      "PHP Version"="7.2.18" \
      "Alpine Linux Version"="3.9.3"

# RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

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
            # for imagick
            autoconf \
            imagemagick-dev\
            libtool\
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
            # for xsl
            libxslt-dev \
            libzip-dev \
            # for ldap
            openldap-dev \
            # to build xdebug from PECL
            $PHPIZE_DEPS \

    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
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
         mysqli \
         opcache \
         pdo \
         pdo_mysql \
         soap \
         sysvsem \
         sysvshm \
         xmlrpc \
         xsl \
         zip \

        && git clone https://github.com/tideways/php-profiler-extension.git /tmp/php-profiler-extension \
        && ( \
                cd /tmp/php-profiler-extension \
                && phpize \
                && ./configure \
                && make -j$(nproc) \
                && make install \
                && cd .. \
        ) \
        # Only this version of uploadprogress supports PHP 7
        # && git clone https://github.com/phoenixleonardo/uploadprogress.git /tmp/uploadprogress \
        && git clone https://github.com/php/pecl-php-uploadprogress /tmp/uploadprogress \
        && ( \
                cd /tmp/uploadprogress \
                && phpize \
                && ./configure \
                && make -j$(nproc) \
                && make install \
                && cd .. \
        ) \

        #### Only  mcrypt 1.0.1 supports PHP 7.3
        && git clone https://github.com/php/pecl-encryption-mcrypt.git /tmp/mcrypt \
        && ( \
                cd /tmp/mcrypt \
                && phpize \
                && ./configure \
                && make -j$(nproc) \
                && make install \
                && cd .. \
        ) \

        && rm -r /tmp/php-profiler-extension \
        && rm -r /tmp/uploadprogress \
        && rm -r /tmp/mcrypt \

        # Only the latest beta version supports PHP7.3
        && pecl install xdebug-beta \
        #  UploadProgress is not being developed anymore
        && printf "\n" | pecl install imagick \
        && pecl install mongodb \
        && pecl install memcached \
        && docker-php-ext-enable opcache \
        xdebug \
        # xhprof \
        imagick \
        mcrypt \
        mongodb \
        memcached \
        sodium \
        tideways_xhprof \
        # twig \
        uploadprogress \

        &&  echo -e "\n opcache.enable=1 \n opcache.enable_cli=1 \n opcache.memory_consumption=128 \n opcache.interned_strings_buffer=8 \n opcache.max_accelerated_files=4000 \n opcache.revalidate_freq=60 \n opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
        &&  echo -e "\n xdebug.remote_enable=1 \n xdebug.remote_host=localhost \n xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        &&  echo -e "\n xhprof.output_dir='/var/tmp/xhprof'" >> /usr/local/etc/php/conf.d/docker-php-ext-xhprof.ini \

        # && pecl install intl\
        # && docker-php-ext-enable intl \
     
    # next will add runtime deps for php extensions
    # what this does is checks the necessary packages for php extensions Shared Objects
    # and adds those (won't be removed when .build-deps are)
    # && docker-php-ext-enable \
        #  xdebug\
     #    uploadprogress\
       
    && runDeps="$( \
            scanelf --needed --nobanner --recursive \
                /usr/local/lib/php/extensions \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
        )" \
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
    && apk del .shadow-deps \
# Install composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "copy('https://composer.github.io/installer.sig', 'signature');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('signature'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"
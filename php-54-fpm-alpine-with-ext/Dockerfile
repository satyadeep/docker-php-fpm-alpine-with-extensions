FROM satyadeep/php-54-fpm-alpine:latest

LABEL MAINTAINER="SATYADEEP G" \
      "GitHub Link"="https://github.com/satyadeep" \
      "PHP Version"="5.4.45" \
      "Alpine Linux Version"="3.7.3"

COPY  xhprof-0.9.4.tgz /tmp/
COPY  install.sh /tmp/

ARG TARGETARCH
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
        # for ldap
        openldap-dev \
        pcre-dev \
        # for gd
        libxpm-dev \
        # libvpx-dev \
        # for xsl
        libgcrypt-dev \
        # to build xdebug from PECL
        $PHPIZE_DEPS \
        wget \
    && apk add libbz2 freetype libjpeg-turbo libpng libxpm libintl icu-libs libldap libmcrypt libxslt imagemagick \
    # Run the following for ARM64 only 
    &&  ( \
            if [ "arm64" = "${TARGETARCH}" ]; then \
                 docker-php-ext-configure gd --with-gd --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --enable-gd-native-ttf --build=aarch64-unknown-linux-gnu  \
                 && docker-php-ext-configure bcmath --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure bz2 --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure calendar --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure curl --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure exif --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure fileinfo --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure ftp --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure gettext --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure imap --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure intl --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure ldap --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure mbstring --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure mcrypt --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure mysql --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure mysqli --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure pdo --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure pdo_mysql --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure soap --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure sysvsem --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure sysvshm --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure xmlrpc --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure xsl --build=aarch64-unknown-linux-gnu \
                 && docker-php-ext-configure zip --build=aarch64-unknown-linux-gnu; \
            fi; \
        ) \
   # Run the following for AMD64 only
    && ( \ 
                if [ "amd64" = "${TARGETARCH}" ]; then \
                    docker-php-ext-configure gd --with-gd --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --enable-gd-native-ttf; \
                fi; \
        ) \
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
    && git clone --branch 1.x https://github.com/satyadeep/Twig.git /tmp/twig \
    && cd /tmp/twig \
	&& git checkout 0fc3341a398171c6bab43b277caecfaa1ef4e026 \
    && cd /tmp \
    # Run the following for ARM64 only
    && ( \
            if [ "arm64" = "${TARGETARCH}" ]; then \
                chmod +x /tmp/install.sh && \
                cd /tmp && \
                ./install.sh xhprof-0.9.4.tgz xhprof-0.9.4/xhprof-0.9.4/extension xhprof /tmp/xhprof-0.9.4/ && \
                cd /tmp && \
                # Downloading the extensions manually and using custom script to build and install mongo /imagick / xdebug / memcache / uploadprogress / opcache and twig installations (as they require the --build=aarch64-unknown-linux-gnu while configuring and pecl install won't allow that)
                wget 'https://pecl.php.net/get/mongo' -O '/tmp/mongo-1.6.16.tgz' &&\
                wget 'https://pecl.php.net/get/imagick-3.7.0.tgz' -O '/tmp/imagick-3.7.0.tgz' && \
                wget 'https://pecl.php.net/get/xdebug-2.2.7.tgz' -O '/tmp/xdebug-2.2.7.tgz' && \
                wget 'https://pecl.php.net/get/memcache-2.2.7.tgz' -O '/tmp/memcache-2.2.7.tgz' && \
                wget 'https://pecl.php.net/get/uploadprogress-1.1.4.tgz' -O '/tmp/uploadprogress-1.1.4.tgz' && \
                ./install.sh mongo-1.6.16.tgz mongo-1.6.16/mongo-1.6.16 mongo /tmp/mongo-1.6.16/ arm64 && \
                ./install.sh imagick-3.7.0.tgz imagick-3.7.0/imagick-3.7.0 imagick /tmp/imagick-3.7.0/ arm64 && \
                ./install.sh xdebug-2.2.7.tgz xdebug-2.2.7/xdebug-2.2.7 xdebug /tmp/xdebug-2.2.7/ arm64 && \
                ./install.sh memcache-2.2.7.tgz memcache-2.2.7/memcache-2.2.7 memcache /tmp/memcache-2.2.7/ arm64 && \
                ./install.sh uploadprogress-1.1.4.tgz uploadprogress-1.1.4/uploadprogress-1.1.4 uploadprogress /tmp/uploadprogress-1.1.4/ arm64 && \
                ./install.sh ZendOptimizerPlus /tmp/ZendOptimizerPlus opcache /tmp/ZendOptimizerPlus/ arm64 && \
                ./install.sh twig /tmp/twig/ext/twig twig /tmp/twig/ arm64; \
            fi; \
        ) \
    # Run the following for AMD64 only
    && ( \ 
                if [ "amd64" = "${TARGETARCH}" ]; then \
                    chmod +x /tmp/install.sh && \
                    cd /tmp && \
                    ./install.sh ZendOptimizerPlus /tmp/ZendOptimizerPlus opcache /tmp/ZendOptimizerPlus/ amd64 && \
                    ./install.sh twig /tmp/twig/ext/twig twig /tmp/twig/ amd64 && \
                    #####   Using Xdebug 2.2.7 as support for PHP 5.4 has been dropped in later versions   #####
                    pecl install xdebug-2.2.7 \
                    #####   Using Xhprof 0.9.4 as support for PHP 5.X has been dropped in later versions   #####
                    && pecl install uploadprogress-1.1.4 \
                     # https://pecl.php.net/package-changelog.php?package=uploadprogress&release=1.0.3
                    && printf "\n" | pecl install imagick \
                    && pecl install mongo \
                    #####   Using memcache 2.2.7 as 3.0.8 won't load even though it installs 
                    # and support for PHP 5.X has been dropped in later versions   #####
                    && pecl install memcache-2.2.7 \
                    && rm /tmp/xhprof-0.9.4.tgz \
                    && pecl install xhprof-0.9.4  \
                    && docker-php-ext-enable opcache \
                    xdebug \
                    xhprof \
                    imagick \
                    # mongodb requires PHP version >= 5.6.0, so installing mongo
                    mongo \
                    memcache \
                    twig \
                    uploadprogress \
                    && rm -rf /tmp/xhprof-0.9.4/; \
                fi; \
            ) \
        && rm /tmp/install.sh \
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
    && cd ~ \
# Install composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "copy('https://composer.github.io/installer.sig', 'signature');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('signature'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
# Install WP-CLI
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
# Install msmtp - To Send Mails on Production & Development
    && apk add msmtp \
    && apk add --virtual .phpexts-rundeps $runDeps \
    && apk del .build-deps
# modify www-data user to have id 1000
RUN apk add \
        --no-cache \
        --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
        --virtual .shadow-deps \
        shadow \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && apk del .shadow-deps

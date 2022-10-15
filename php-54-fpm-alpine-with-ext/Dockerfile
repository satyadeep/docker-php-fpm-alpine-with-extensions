FROM satyadeep/php-54-fpm-alpine:latest

LABEL MAINTAINER="SATYADEEP G" \
      "GitHub Link"="https://github.com/satyadeep" \
      "PHP Version"="5.4.45" \
      "Alpine Linux Version"="3.7.3"

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
    && apk add libbz2 freetype libjpeg-turbo libpng libxpm libintl icu-libs libldap libmcrypt libxslt imagemagick \
    && wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' -O config.guess \
    && docker-php-ext-configure gd --with-gd --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --enable-gd-native-ttf  --build=aarch64-unknown-linux-gnu\
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
        #####   Using Xdebug 2.2.7 as support for PHP 5.4 has been dropped in later versions   #####
        && pecl install xdebug-2.2.7 \
        #####   Using Xhprof 0.9.4 as support for PHP 5.X has been dropped in later versions   #####
        && pecl install xhprof-0.9.4  \
        && pecl install uploadprogress-1.1.4 \
         # https://pecl.php.net/package-changelog.php?package=uploadprogress&release=1.0.3
        && printf "\n" | pecl install imagick \
        && pecl install mongo \
        #####   Using memcache 2.2.7 as 3.0.8 won't load even though it installs 
        # and support for PHP 5.X has been dropped in later versions   #####
        && pecl install memcache-2.2.7 \
        && docker-php-ext-enable opcache \
            xdebug \
            xhprof \
            imagick \
        # mongodb requires PHP version >= 5.6.0, so installing mongo
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

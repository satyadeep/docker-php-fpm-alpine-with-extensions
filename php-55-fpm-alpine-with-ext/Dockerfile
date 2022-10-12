FROM satyadeep/php-55-fpm-alpine:latest

LABEL MAINTAINER="SATYADEEP G" \
      "GitHub Link"="https://github.com/satyadeep" \
      "PHP Version"="5.5.38" \
      "Alpine Linux Version"="3.8.4"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN apk add --no-cache --virtual .build-deps git autoconf  $PHPIZE_DEPS \
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
    && rm -r /tmp/twig \
    && pecl install uploadprogress \
    && docker-php-ext-enable twig \
        uploadprogress \
    && apk del .build-deps git autoconf $PHPIZE_DEPS \
    && chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions bcmath \
            bz2 \
            calendar \
            curl \
            exif \
            fileinfo \
            ftp \
            gd \
            gettext \
            imagick \
            imap \
            intl \
            ldap \
            mbstring \
            mcrypt \
            memcache \
            mongo \
            mysql \
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
    #####   Using Xdebug 2.5.5 as support for PHP 5.5 has been dropped in newer versions   #####
    #####    Using shprof-0.9.4   #####
    #####   Using memcache 2.2.7 as 3.0.8 won't load even though it installs 
    # and support for PHP 5.X has been dropped in later versions   #####
    # mongodb requires PHP version >= 5.6.0, so installing mongo
    &&  echo -e "\n opcache.enable=1 \n opcache.enable_cli=1 \n opcache.memory_consumption=128 \n opcache.interned_strings_buffer=8 \n opcache.max_accelerated_files=4000 \n opcache.revalidate_freq=60 \n opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    &&  echo -e "\n xdebug.remote_enable=1 \n xdebug.remote_host=localhost \n xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    &&  echo -e "\n xhprof.output_dir='/var/tmp/xhprof'" >> /usr/local/etc/php/conf.d/docker-php-ext-xhprof.ini \
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
    && apk add msmtp
# modify www-data user to have id 1000
RUN apk add \
        --no-cache \
        --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
        --virtual .shadow-deps \
        shadow \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && apk del .shadow-deps
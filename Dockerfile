#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for webdevops/php:centos-7-php7
#    -- automatically generated  --
#+++++++++++++++++++++++++++++++++++++++
FROM webdevops/php:centos-7-php7 AS base


FROM webdevops/base-app:centos-7

ENV WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET="" \
    WEB_PHP_SOCKET=127.0.0.1:9000

COPY --from=base /opt/docker/ /opt/docker/

RUN set -x \
    && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
    && yum-install \
        ImageMagick \
        GraphicsMagick \
        ghostscript \
        jpegoptim \
        libjpeg-turbo-utils \
        optipng \
        pngcrush \
        pngnq \
        pngquant \
        # Install php (cli/fpm)
        php72w-cli \
        php72w-fpm \
        php72w-common \
        php72w-intl \
        php72w-imap \
        php72w-mysqlnd \
        php72w-pecl-memcached \
        php72w-mcrypt \
        php72w-gd \
        php72w-pgsql \
        php72w-mbstring \
        php72w-bcmath \
        php72w-soap \
        php72w-pecl-apcu \
        sqlite \
        php72w-xmlrpc \
        php72w-xml \
        geoip \
        php72w-ldap \
        ImageMagick-devel \
        ImageMagick-perl \
        php72w-pear \
        php72w-devel \
        gcc \
        make \
        php72w-opcache \
        php72w-pecl-imagick \
        php72w-pecl-mongodb \
    && pecl channel-update pecl.php.net \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && pecl install redis \
    && echo "extension=redis.so" > /etc/php.d/redis.ini \
    && yum remove -y ImageMagick-devel php72w-devel gcc make \
    # Enable php services
    && docker-service enable syslog \
    && docker-service enable cron \
    && docker-run-bootstrap \
    && docker-image-cleanup \
    && yum-install \
        nginx \
    && docker-run-bootstrap \
    && docker-image-cleanup

EXPOSE 9000 80 443

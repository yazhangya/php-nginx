FROM webdevops/php-nginx:centos-7-php7 AS base


FROM webdevops/base-app:centos-7

ENV WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET="" \
    WEB_PHP_SOCKET=127.0.0.1:9000

COPY --from=base /opt/docker/ /opt/docker/

RUN set -x \
    # Enable php/nginx services
    && docker-service enable syslog \
    && docker-service enable cron \
    && docker-run-bootstrap \
    && docker-image-cleanup

#!/bin/sh
set -ex

(
    cd /var/www

    composer install \
        --ignore-platform-reqs \
        --no-interaction \
        --no-scripts

    chown -R www-data:www-data vendor
)

exec php-fpm "$@"

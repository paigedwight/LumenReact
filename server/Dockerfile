# Prod packages
FROM composer:2.1.14 AS prod-composer

COPY composer.json composer.lock ./

RUN composer install \
    --ignore-platform-reqs \
    --no-ansi \
    --no-autoloader \
    --no-interaction \
    --no-scripts \
    --no-dev

COPY . .

RUN composer dump-autoload --optimize --classmap-authoritative

################################################################################
# Prod setup
FROM php:8.1-fpm-alpine AS prod

WORKDIR /var/www

RUN apk add --no-cache \
    oniguruma-dev \
    libpq-dev

RUN docker-php-ext-install mbstring pdo pdo_pgsql

RUN rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apk/*

COPY --chown=www-data:www-data --from=prod-composer /app/vendor /var/www/vendor
COPY --chown=www-data:www-data app bootstrap database public resources routes storage ./

# check if this is doing anything
WORKDIR /var/www/public

################################################################################
FROM prod AS dev

RUN apk update && apk add --no-cache \
    composer

ENTRYPOINT [ "/var/www/.docker/docker-php-entrypoint.sh" ]

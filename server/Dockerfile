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
FROM prod-composer AS dev-composer

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-scripts

################################################################################
FROM php:8.1-fpm-alpine AS dependencies

RUN apk add --no-cache \
    oniguruma-dev \
    libpq-dev
RUN docker-php-ext-install mbstring pdo pdo_pgsql
RUN rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apk/*

WORKDIR /var/www
COPY --chown=www-data:www-data app bootstrap database public resources routes storage ./
WORKDIR /var/www/public

# See if this can be more specific
FROM dependencies AS dev
RUN apk add --no-cache composer
COPY --chown=www-data:www-data --from=dev-composer /app/vendor /var/www/vendor

# Prod setup
FROM dependencies AS prod
COPY --chown=www-data:www-data --from=prod-composer /app/vendor /var/www/vendor

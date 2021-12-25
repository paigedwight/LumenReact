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

COPY app .
COPY bootstrap .
COPY database .
COPY public .
COPY resources .
COPY routes .
COPY storage .

RUN composer dump-autoload --optimize --classmap-authoritative

# Prod setup
FROM php:8.1-fpm-alpine AS prod

WORKDIR /var/www

RUN apk update && apk add --no-cache \
    libpng-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev

RUN rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apk/*
RUN docker-php-ext-configure gd --enable-gd --with-freetype
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY . .
COPY --from=prod-composer /app/vendor /var/www/vendor

RUN addgroup -g 1000 -S www && \
    adduser -u 1000 -S www -G www-data

COPY --chown=www:www-data . .

WORKDIR /var/www/public

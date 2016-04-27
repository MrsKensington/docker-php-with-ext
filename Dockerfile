FROM php:fpm
MAINTAINER docker@mikeditum.co.uk

RUN apt-get update && apt-get install -y libmagickwand-dev

RUN pecl install imagick && \
    docker-php-ext-enable imagick

RUN docker-php-ext-install -j$(nproc) mysqli
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) exif
RUN docker-php-ext-install -j$(nproc) zip

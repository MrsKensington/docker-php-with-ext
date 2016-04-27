FROM php:5-fpm

RUN docker-php-ext-install -j$(nproc) mysqli

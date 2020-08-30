FROM php:8.0.0beta2-apache-buster

RUN apt update
RUN apt install -y sed vim wget git
RUN cat /usr/local/etc/php/php.ini-development | sed -e "s/memory_limit = 128M/memory_limit = 256M/" > /usr/local/etc/php/php.ini

# MySQLi, Tidy, Intl
RUN docker-php-ext-install mysqli
RUN apt install -y libtidy-dev; docker-php-ext-install tidy
RUN apt install -y libicu-dev; docker-php-ext-install intl

# GD
RUN apt install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# XDebug
RUN git clone git://github.com/xdebug/xdebug.git /usr/src/php/ext/xdebug
RUN docker-php-ext-install xdebug

# Apache config
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
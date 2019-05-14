FROM php:7.0-cli

RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    wget git

RUN docker-php-ext-install zip
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN wget https://getcomposer.org/installer -O - -q | php -- --install-dir=/bin --filename=composer 

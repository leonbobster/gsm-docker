FROM php:7.0-cli

RUN apt-get update && apt-get install -y zlib1g-dev libmcrypt-dev wget git

RUN docker-php-ext-install zip
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install pdo_mysql

RUN wget https://getcomposer.org/installer -O - -q | php -- --install-dir=/bin --filename=composer 

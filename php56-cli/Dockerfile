FROM php:5.6-cli

RUN apt-get update && apt-get install -y zlib1g-dev libmcrypt-dev wget

RUN docker-php-ext-install zip
RUN docker-php-ext-install mcrypt

RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --install-dir=/bin --filename=composer 

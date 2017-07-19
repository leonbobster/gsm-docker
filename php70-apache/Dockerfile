FROM php:7.0-apache
RUN apt-get update && apt-get install -y \
    libpng12-dev \
    libjpeg62-turbo-dev

RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_mysql 

# xdebug
RUN pecl install xdebug-2.5.5
ENV XDEBUG_INI=/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey = PHPSTORM" >> ${XDEBUG_INI} && \
echo "xdebug.default_enable = 0" >>   ${XDEBUG_INI} && \
echo "xdebug.remote_enable = 1" >>   ${XDEBUG_INI} && \
echo "xdebug.remote_autostart = 0" >>   ${XDEBUG_INI} && \
echo "xdebug.remote_connect_back = 0" >> ${XDEBUG_INI} && \
echo "xdebug.profiler_enable = 0" >>   ${XDEBUG_INI}
RUN docker-php-ext-enable xdebug

# mod_rewrite
RUN a2enmod rewrite
RUN apachectl restart

ADD ./vhosts/000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD ./vhosts/test.conf /etc/apache2/sites-enabled/test.conf
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]


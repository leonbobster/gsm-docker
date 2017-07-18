FROM ubuntu:16.04
RUN apt-get update && apt-get -y install wget apache2 php7.0 libapache2-mod-php7.0 \
 php7.0-mysql php7.0-curl php-apcu php-xml php-mbstring php-xdebug
RUN echo "xdebug.idekey = PHPSTORM" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.default_enable = 0" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.remote_enable = 1" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.remote_autostart = 0" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.remote_connect_back = 0" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.profiler_enable = 0" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini 
RUN a2enmod rewrite
RUN apachectl restart
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]


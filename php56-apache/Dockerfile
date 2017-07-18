FROM debian:8
RUN apt-get update && apt-get -y install wget apache2 php5 libapache2-mod-php5 php5-mysql php5-apcu php5-curl php5-xdebug
RUN echo "xdebug.idekey = PHPSTORM" >> /etc/php5/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.default_enable = 0" >> /etc/php5/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.remote_enable = 1" >> /etc/php5/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.remote_autostart = 0" >> /etc/php5/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.remote_connect_back = 0" >> /etc/php5/apache2/conf.d/20-xdebug.ini && \
echo "xdebug.profiler_enable = 0" >> /etc/php5/apache2/conf.d/20-xdebug.ini
RUN a2enmod rewrite && service apache2 restart
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
#RUN wget https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/bin/phpunit
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]

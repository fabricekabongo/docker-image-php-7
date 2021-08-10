FROM ubuntu:xenial

RUN apt-get update && apt-get install -y unattended-upgrades \
    git \
    ntp \
    apache2 \
    libpcre3 \
    software-properties-common \
    make \
    unzip

RUN service ntp start
RUN a2enmod rewrite headers

RUN echo 'Europe/London' > /etc/timezone \
    && chmod -R 0644 /etc/timezone

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y --no-install-recommends php7.3 \
    php7.3-bcmath \
    php7.3-cli \
    php7.3-curl \
    php7.3-gd \
    php7.3-iconv \
    php7.3-intl \
    php7.3-json \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-xml \
    php7.3-zip \
    php7.3-dev \
    php7.3-apc \
    php-amqp

RUN apt-get install wget && wget http://pear.php.net/go-pear.phar \
    && php go-pear.phar

RUN pecl install opencensus-alpha apcu

COPY ./apache2/vhost.conf /etc/apache2/sites-enabled/000-default.conf

COPY php/custom.ini /etc/php/7.3/apache2/php.ini
COPY  php/custom.ini /etc/php/7.3/cli/php.ini

WORKDIR /var/www/html

RUN chown -R www-data:www-data .
RUN chmod -R 755 .

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
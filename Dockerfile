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

RUN echo 'Asia/Dubai' > /etc/timezone \
    && chmod -R 0644 /etc/timezone

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y --no-install-recommends php7.2 \
    php7.2-bcmath \
    php7.2-cli \
    php7.2-curl \
    php7.2-gd \
    php7.2-iconv \
    php7.2-intl \
    php7.2-json \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-xml \
    php7.2-zip \
    php7.2-dev \
    php7.2-apc

RUN apt-get install wget && wget http://pear.php.net/go-pear.phar \
    && php go-pear.phar

RUN pecl install opencensus-alpha apcu

COPY ./apache2/vhost.conf /etc/apache2/sites-enabled/000-default.conf

COPY php/custom.ini /etc/php/7.2/apache2/php.ini
COPY  php/custom.ini /etc/php/7.2/cli/php.ini
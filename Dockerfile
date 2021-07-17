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
    && apt-get install -y --no-install-recommends php7.4 \
    php7.4-bcmath \
    php7.4-cli \
    php7.4-curl \
    php7.4-gd \
    php7.4-iconv \
    php7.4-intl \
    php7.4-json \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-xml \
    php7.4-zip \
    php7.4-dev \
    php7.4-apc

RUN apt-get install wget && wget http://pear.php.net/go-pear.phar \
    && php go-pear.phar

RUN pecl install opencensus-alpha apcu

RUN wget http://in.archive.ubuntu.com/ubuntu/ubuntu/pool/universe/libr/librabbitmq/librabbitmq1_0.5.2-2_amd64.deb
RUN dpkg -i librabbitmq1_0.5.2-2_amd64.deb

RUN wget http://in.archive.ubuntu.com/ubuntu/ubuntu/pool/universe/libr/librabbitmq/librabbitmq-dev_0.5.2-2_amd64.deb
RUN dpkg -i librabbitmq-dev_0.5.2-2_amd64.deb

RUN apt-get install php7.0 php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-xml php7.0-dev

RUN pecl install amqp

RUN echo "extension=amqp.so" >> /etc/php/7.4/apache2/php.ini
RUN echo "extension=amqp.so" >> /etc/php/7.4/cli/php.ini

COPY ./apache2/vhost.conf /etc/apache2/sites-enabled/000-default.conf

COPY php/custom.ini /etc/php/7.4/apache2/php.ini
COPY  php/custom.ini /etc/php/7.4/cli/php.ini

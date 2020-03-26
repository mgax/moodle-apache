FROM php:7.4-apache-buster

# github.com/moodlehq/moodle-php-apache/blob/master/root/tmp/setup/php-extensions.sh

RUN apt-get update \
 && apt-get install -y --no-install-recommends apt-transport-https \
      libmariadb3 \
      ghostscript libaio1 libcurl4 libgss3 libicu63 \
      libxml2 libxslt1.1 locales sassc unixodbc unzip zip \
      zlib1g-dev libzip-dev libpng-dev libjpeg62-turbo-dev \
      libfreetype6-dev libicu63 libicu-dev libxml2-dev \
      sudo \
 && docker-php-ext-install -j$(nproc) mysqli zip gd intl xmlrpc soap opcache \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY moodle.ini $PHP_INI_DIR/conf.d/

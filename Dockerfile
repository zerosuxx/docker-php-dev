FROM php:7.3.1-apache

MAINTAINER Tamas 'ZerosuxX' Mohos <tomi@mohos.name>

ENV DEBIAN_FRONTEND "noninteractive"
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN set -xe; \
    apt-get update; \
    apt-get install -y \
            git \
            zlib1g-dev \
            libicu-dev \
            g++ \
            curl \
            nano \
            unzip \
            mysql-client \
            libsqlite3-dev \
            libsqlite3-0 \
            openssl \
            libssl-dev; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;
RUN set -xe; \
    pecl install xdebug-2.7.0beta1; \
    pecl download swoole-4.2.12 && tar xvzf swoole-4.2.12.tgz && cd swoole-4.2.12 && phpize && ./configure --enable-openssl --enable-mysqlnd && make && make install && cd .. && rm -Rf swoole*;
RUN set -xe; \
    docker-php-ext-install zip; \
    docker-php-ext-install pdo_mysql; \
    docker-php-ext-install pdo_sqlite; \
    docker-php-ext-install mysqli; \
    docker-php-ext-install opcache;
RUN set -xe; \
    docker-php-ext-enable opcache; \
    docker-php-ext-enable xdebug; \
    docker-php-ext-enable swoole;
RUN set -xe; \
    curl -o /usr/local/bin/composer -L https://github.com/composer/composer/releases/download/1.8.0/composer.phar; \
    curl -o /usr/local/bin/phpstan -L https://github.com/phpstan/phpstan/releases/download/0.11.1/phpstan.phar; \
    curl -o /usr/local/bin/phpunit -L https://phar.phpunit.de/phpunit-7.5.2.phar; \
    chmod +x /usr/local/bin/composer; \
    chmod +x /usr/local/bin/phpstan; \
    chmod +x /usr/local/bin/phpunit;

WORKDIR /var/www/html
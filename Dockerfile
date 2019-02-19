FROM php:7.3.2-cli

MAINTAINER Tamas 'ZerosuxX' Mohos <tomi@mohos.name>

ENV DEBIAN_FRONTEND "noninteractive"
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN set -xe; \
    apt-get update; \
    apt-get install -y \
            git \
            zlib1g-dev \
            libzip-dev \
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
    pecl install xdebug-2.7.0RC2; \
    pecl download swoole-4.2.13 && tar xvzf swoole-4.2.13.tgz && cd swoole-4.2.13 && phpize && ./configure --enable-openssl --enable-mysqlnd && make && make install && cd .. && rm -Rf swoole*;
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
    curl -o /usr/local/bin/composer -L https://github.com/composer/composer/releases/download/1.8.4/composer.phar; \
    curl -o /usr/local/bin/phpstan -L https://github.com/phpstan/phpstan/releases/download/0.11.2/phpstan.phar; \
    curl -o /usr/local/bin/phpunit -L https://phar.phpunit.de/phpunit-8.0.4.phar; \
    chmod +x /usr/local/bin/composer; \
    chmod +x /usr/local/bin/phpstan; \
    chmod +x /usr/local/bin/phpunit;

WORKDIR /opt/project
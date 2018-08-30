FROM php:7.2.9-cli
MAINTAINER Mohos Tamas <tomi@mohos.name>

ENV DEBIAN_FRONTEND "noninteractive"
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install packages
RUN set -xe; \
    apt-get update; \
    apt-get install -y \
            git \
            curl \
            nano \
            zlib1g-dev \
            libicu-dev \
            g++ \
            libsqlite3-dev \
            libsqlite3-0 \
            mysql-client; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

# Install extensions
RUN set -xe; \
    pecl install xdebug-2.6.1; \
    docker-php-ext-install zip; \
    docker-php-ext-install pdo_mysql; \
    docker-php-ext-install pdo_sqlite; \
    docker-php-ext-install mysqli; \
    docker-php-ext-install opcache; \
    docker-php-ext-enable opcache; \
    docker-php-ext-enable xdebug;

# Config
RUN set -xe; \
    curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \
    curl -o /usr/local/bin/phpstan -L https://github.com/phpstan/phpstan/releases/download/0.10.3/phpstan.phar; \
    curl -o /usr/local/bin/phpunit -L https://phar.phpunit.de/phpunit-7.phar; \
    chmod +x /usr/local/bin/phpstan; \
    chmod +x /usr/local/bin/phpunit;
    
# Define workspace
WORKDIR /opt/project


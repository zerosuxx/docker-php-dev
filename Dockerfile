FROM php:7.2.9-cli
MAINTAINER Mohos Tamas <tomi@mohos.name>

ENV DEBIAN_FRONTEND "noninteractive"
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install packages
RUN apt-get update \
    && apt-get install -y git curl nano zlib1g-dev libicu-dev g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install xdebug-2.6.0 \
    && docker-php-ext-install zip opcache \
    && docker-php-ext-enable opcache xdebug

# Config
RUN curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& curl -o /usr/local/bin/phpstan -L https://github.com/phpstan/phpstan/releases/download/0.10.3/phpstan.phar \
    && curl -o /usr/local/bin/phpunit -L https://phar.phpunit.de/phpunit-7.phar \
    && chmod +x /usr/local/bin/phpstan \
    && chmod +x /usr/local/bin/phpunit
    
# Define workspace
WORKDIR /opt/project


# syntax=docker/dockerfile:1
FROM php:8.1-apache

LABEL gr.gunet.e-class-docker.maintainer="eclass@gunet.gr"
LABEL org.opencontainers.image.source="https://github.com/gunet/eclass-docker"
LABEL org.opencontainers.image.description="Open e-Class Docker image"

RUN apt-get update && apt-get install -yq --no-install-recommends \
    default-libmysqlclient-dev \
    libbz2-dev \
    libmemcached-dev \
    libsasl2-dev \
    curl \
    git \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libldap2-dev \
    libmemcachedutil2 \
    libpng-dev \
    libpq-dev \
    libxml2-dev \
    libzip-dev \
    vim-tiny && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN docker-php-ext-install iconv intl mysqli opcache pdo_mysql pdo_pgsql zip gd ldap soap

RUN a2disconf charset localized-error-pages serve-cgi-bin && \
    a2dismod -f access_compat autoindex deflate negotiation status

COPY php/ ${PHP_INI_DIR}/


ARG REPO=https://github.com/gunet/openeclass.git
ARG VERSION=3.14.1
ARG INSTALL=/var/www/html

ADD --chown=www-data:www-data ${REPO}#Release_${VERSION} ${INSTALL}

COPY --from=composer /usr/bin/composer /usr/bin/composer
USER www-data
RUN cd /var/www/html && \
    COMPOSER_CACHE_DIR=/var/www/html/.cache composer update && \
    COMPOSER_CACHE_DIR=/var/www/html/.cache composer install && \
    rm -rf /var/www/html/.cache

RUN mkdir ${INSTALL}/courses && \
    mkdir ${INSTALL}/video
    # chown -R www-data:www-data ${INSTALL}/
USER root

HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 \
    CMD pgrep -u www-data -c apache2


WORKDIR ${INSTALL}

ENV TZ=Europe/Athens
ENV MYSQL_LOCATION=db
# DB user root
ENV MYSQL_ROOT_PASSWORD=secret
# DB database is eclass
ENV PHP_MAX_UPLOAD=256M

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
    wget \
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

ARG mversion=3.14
ARG version=3.14.1
ARG INSTALL=/var/www/html

RUN cd /var/tmp && \
    wget -q https://download.openeclass.org/files/${mversion}/openeclass-${version}.tar.gz && \
    tar xf /var/tmp/openeclass-${version}.tar.gz -C ${INSTALL} && \
    mv ${INSTALL}/openeclass-${version}/* ${INSTALL} && \
    rm -rf ${INSTALL}/openeclass-${version} && \
    rm /var/tmp/openeclass-${version}.tar.gz

RUN mkdir ${INSTALL}/courses && \
    mkdir ${INSTALL}/video && \
    chown -R www-data:www-data ${INSTALL}/

ENV TZ=Europe/Athens

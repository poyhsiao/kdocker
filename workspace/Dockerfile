# syntax = docker/dockerfile:experimental
ARG PHP_VERSION=8.1
FROM php:${PHP_VERSION}-cli-alpine

LABEL MAINTAINER "Kim Hsiao <white.shopping@gmail.com>"
LABEL PHP_VERSION=${PHP_VERSION}

####################################
# Update apk and install basic requirements
####################################
RUN apk update && \
  apk upgrade && \
  apk add ca-certificates \
  wget \
  curl \
  bash \
  bash-completion \
  openssl \
  coreutils

####################################
# Set global system environment:
####################################
USER root

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8

ENV TERM=xterm

####################################
# Add user:
####################################
USER root

# Add a non-root user:
ARG PUID=1000
ARG PGID=1000
ARG LINUX_USER=kim
ARG SSH_USER_PASSWORD=asdfasdf

RUN adduser -D -h /home/${LINUX_USER} -u ${PUID} -g ${PGID} ${LINUX_USER} ${LINUX_USER} && \
  echo -e "$SSH_USER_PASSWORD\n$SSH_USER_PASSWORD" | passwd ${LINUX_USER}

####################################
# Set Timezone
####################################
USER root

ENV TZ ${TZ:-UTC}

RUN apk add --no-cache tzdata && \
  ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

####################################
# Set global system libs
####################################
USER root

ARG NPROC=1
ENV NPROC ${NPROC:-1}

# Preparing the npcocessor
RUN apk add --no-cache --virtual .build-deps \
  build-base \
  g++ \
  make \
  autoconf \
  git \
  && \
  echo "$(nproc)" > /etc/nproc

####################################
# Prepare the PHP build environment
####################################
USER root

ARG INSTALL_PHP=false

RUN if [ ${INSTALL_PHP} = true ]; then \
  # Extract PHP source
  docker-php-source extract && \
  # Upadate pecl channel
  pecl channel-update pecl.php.net \
  ;fi

####################################
# Crontab:
####################################
USER root

COPY ./crontab /etc/cron.d

RUN chmod -R 644 /etc/cron.d

####################################
# MyCrypto
# only need to install mcrypt extension for php 7.0
####################################
USER root

ARG INSTALL_MCRYPT=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_MCRYPT} = true ] && [ `echo ${PHP_VERSION} | cut -c1-3` = 7.0 ]; then \
  apk add --no-cache --virtual .mycrypt \
  mcrypt \
  mcrypt-dev \
  && \
  docker-php-ext-install mcrypt && \
  apk del .mycrypt \
  ; fi

####################################
# PDO MySQL:
####################################
USER root

ARG INSTALL_PDO_MYSQL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_PDO_MYSQL} = true ]; then \
  apk add --no-cache --virtual .mysql \
  mysql-client && \
  docker-php-ext-install -j${NPROC} pdo pdo_mysql && \
  apk del .mysql \
  ;fi

####################################
# PDO PostgreSQL:
####################################
USER root

ARG INSTALL_PDO_PGSQL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_PDO_PGSQL} = true ]; then \
  apk add --no-cache \
  libpq-dev && \
  docker-php-ext-configure pgsql --with-pgsql=/user/local/pgsql && \
  docker-php-ext-install -j${NPROC} pdo pdo_pgsql pgsql \
  ;fi

####################################
# GD:
####################################
USER root

ARG INSTALL_GD=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_GD} = true ]; then \
  apk add --no-cache \
  libjpeg-turbo-dev \
  libpng-dev \
  libgd \
  libxpm-dev \
  zlib-dev \
  libwebp-dev \
  freetype-dev && \
  if [ "$(printf '%s\n' "7.4" "${PHP_VERSION}" | sort -V | head -n1)" = "7.4" ]; then \
  # greater equal 7.4
  docker-php-ext-configure gd \
  --with-jpeg \
  --with-freetype \
  --with-xpm \
  --with-webp \
  ;else \
  # less than 7.4
  docker-php-ext-configure gd \
  --with-jpeg-dir=/usr/lib \
  --freetype-dir=/usr/include \
  --with-xpm=/usr/lib \
  ;fi && \
  docker-php-ext-install -j${NPROC} gd \
  ;fi

####################################
# APC:
# only support under php 8.0
####################################
USER root

ARG INSTALL_APC=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_APC} = true ]; then \
  if [ "$(printf '%s\n' "8.0" "${PHP_VERSION}" | sort -V | head -n1)" = "8.0" ]; then \
  # greater equal 8.0
  echo "Do not support APCu feature in PHP 8.0 and above" \
  ;else \
  # less than 8.0
  pecl install apcu && \
  docker-php-ext-enable apcu \
  ;fi \
  ;fi

####################################
# XSL:
####################################
USER root

ARG INSTALL_XSL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_XSL} = true ]; then \
  apk add --no-cache \
  libxslt-dev \
  libxml2-dev \
  && \
  docker-php-ext-install -j${NPROC} xsl \
  ;fi

####################################
# Calendar:
####################################
USER root

ARG INSTALL_CALENDAR=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_CALENDAR} = true ]; then \
  docker-php-ext-install -j${NPROC} calendar \
  ;fi

####################################
# Ctype:
####################################
USER root

ARG INSTALL_CTYPE=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_CTYPE} = true ]; then \
  docker-php-ext-install -j${NPROC} ctype \
  ;fi

####################################
# DBA:
####################################
USER root

ARG INSTALL_DBA=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_DBA} = true ]; then \
  docker-php-ext-install -j${NPROC} dba \
  ;fi

####################################
# Hash:
####################################
USER root

ARG INSTALL_HASH=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_HASH} = true ]; then \
  docker-php-ext-install -j${NPROC} hash \
  ;fi

####################################
# IMAP:
####################################
USER root

ARG INSTALL_IMAP=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_IMAP} = true ]; then \
  apk add --no-cache \
  imap-dev && \
  docker-php-ext-install -j${NPROC} imap \
  ;fi

####################################
# Gettext:
####################################
USER root

ARG INSTALL_GETTEXT=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_GETTEXT} = true ]; then \
  apk add --no-cache \
  gettext-dev && \
  docker-php-ext-install -j${NPROC} gettext \
  ;fi

####################################
# pspell:
####################################
USER root

ARG INSTALL_PSPELL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_PSPELL} = true ]; then \
  apk add --no-cache \
  aspell-dev && \
  docker-php-ext-install -j${NPROC} pspell \
  ;fi

####################################
# shmop:
####################################
USER root

ARG INSTALL_SHMOP=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_SHMOP} = true ]; then \
  docker-php-ext-install -j${NPROC} shmop \
  ;fi

####################################
# SNMP:
####################################
USER root

ARG INSTALL_SNMP=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_SNMP} = true ]; then \
  apk add --no-cache \
  net-snmp-dev && \
  docker-php-ext-install -j${NPROC} snmp \
  ;fi

####################################
# sysvmsg:
####################################
USER root

ARG INSTALL_SYSVMSG=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_SYSVMSG} = true ]; then \
  docker-php-ext-install -j${NPROC} sysvmsg \
  ;fi

####################################
# sysvshm:
####################################
USER root

ARG INSTALL_SYSVSHM=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_SYSVSHM} = true ]; then \
  docker-php-ext-install -j${NPROC} sysvshm \
  ;fi

####################################
# Enchant:
####################################
USER root

ARG INSTALL_ENCHANT=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_ENCHANT} = true ]; then \
  apk add --no-cache \
  enchant2-dev && \
  docker-php-ext-install -j${NPROC} enchant \
  ;fi

####################################
# YAML:
####################################
USER root

ARG INSTALL_YAML=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_YAML} = true ]; then \
  apk add --no-cache \
  yaml-dev && \
  pecl install yaml && \
  docker-php-ext-enable yaml \
  ;fi

####################################
# Tidy:
####################################
USER root

ARG INSTALL_TIDY=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_TIDY} = true ]; then \
  apk add --no-cache \
  tidyhtml-dev && \
  docker-php-ext-install -j${NPROC} tidy \
  ;fi

####################################
# XML:
####################################
USER root

ARG INSTALL_XML=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_XML} = true ]; then \
  apk add --no-cache \
  libxml2-dev && \
  docker-php-ext-install -j${NPROC} xml \
  ;fi

####################################
# SOAP:
####################################
USER root

ARG INSTALL_SOAP=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_SOAP} = true ]; then \
  docker-php-ext-install -j${NPROC} soap \
  ;fi

####################################
# Pgsql:
####################################
USER root

ARG INSTALL_PGSQL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_PGSQL} = true ]; then \
  apk add --no-cache \
  libpq-dev && \
  docker-php-ext-configure pgsql --with-pgsql=/user/local/pgsql && \
  docker-php-ext-install -j${NPROC} pgsql \
  ;fi

####################################
# xDebug:
####################################
USER root

ARG INSTALL_XDEBUG=false

COPY ./xdebug.ini /tmp/xdebug.ini

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_XDEBUG} = true ]; then \
  pecl install xdebug && \
  docker-php-ext-enable xdebug && \
  cp /tmp/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini \
  ;fi

####################################
# Redis extension:
####################################
USER root

ARG INSTALL_PHPREDIS=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_PHPREDIS} = true ]; then \
  pecl install redis && \
  docker-php-ext-enable redis \
  ;fi

####################################
# Swoole extension:
# Should install greater than PHP 7.2
# The installation guide is here:
# https://wiki.swoole.com/#/environment
####################################
USER root

ARG INSTALL_SWOOLE=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_SWOOLE} = true ]; then \
  apk add --no-cache \
  curl-dev \
  c-ares-dev && \
  pecl install --configureoptions '\
  enable-openssl="yes" \
  enable-http2="yes" \
  enable-swoole-json="yes" \
  enable-swoole-curl="yes" \
  enable-cares="yes" \
  ' swoole && \
  docker-php-ext-enable swoole \
  ;fi

####################################
# MongoDB:
####################################
USER root

ARG INSTALL_MONGO=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_MONGO} = true ]; then \
  pecl install mongodb && \
  docker-php-ext-enable mongodb \
  ;fi

####################################
# AMQP:
####################################
USER root

ARG INSTALL_AMQP=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_AMQP} = true ]; then \
  apk add --no-cache \
  rabbitmq-c-dev && \
  pecl install amqp && \
  docker-php-ext-enable amqp \
  ;fi

####################################
# ZipArchive:
####################################
USER root

ARG INSTALL_ZIP_ARCHIVE=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_ZIP_ARCHIVE} = true ]; then \
  apk add --no-cache \
  libzip-dev && \
  docker-php-ext-install -j${NPROC} zip \
  ;fi

####################################
# bcmath:
####################################
USER root

ARG INSTALL_BCMATH=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_BCMATH} = true ]; then \
  docker-php-ext-install -j${NPROC} bcmath \
  ;fi

####################################
# GMP:
####################################
USER root

ARG INSTALL_GMP=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_GMP} = true ]; then \
  apk add --no-cache \
  gmp-dev && \
  docker-php-ext-install -j${NPROC} gmp \
  ;fi

####################################
# Memcached:
####################################
USER root

ARG INSTALL_MEMCACHED=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_MEMCACHED} = true ]; then \
  apk add --no-cache \
  libmemcached-dev && \
  pecl install memcached && \
  docker-php-ext-enable memcached \
  ;fi

####################################
# Exif:
####################################
USER root

ARG INSTALL_EXIF=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_EXIF} = true ]; then \
  docker-php-ext-install -j${NPROC} exif \
  ;fi

####################################
# Opcache:
####################################
USER root

ARG INSTALL_OPCACHE=false

COPY ./opcache.ini /tmp/opcache.ini

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_OPCACHE} = true ]; then \
  docker-php-ext-install -j${NPROC} opcache && \
  cp /tmp/opcache.ini /usr/local/etc/php/conf.d/opcache.ini \
  ;fi

####################################
# Mysqli:
####################################
USER root

ARG INSTALL_MYSQLI=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_MYSQLI} = true ]; then \
  docker-php-ext-install -j${NPROC} mysqli \
  ;fi


####################################
# pcntl:
####################################
USER root

ARG INSTALL_PCNTL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_PCNTL} = true ]; then \
  docker-php-ext-install -j${NPROC} pcntl \
  ;fi

####################################
# Inotify:
####################################
USER root

ARG INSTALL_INOTIFY=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_INOTIFY} = true ]; then \
  pecl install inotify && \
  docker-php-ext-enable inotify \
  ;fi

####################################
# OpenCC:
# Check the official github page for more information:
# https://github.com/nauxliu/opencc4php
####################################
USER root

ARG INSTALL_OPENCC=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_OPENCC} = true ]; then \
  # Preparing the compiler:
  apk add --no-cache --virtual .mods \
  cmake \
  doxygen && \
  # Install OpenCC package:
  cd /tmp && \
  mkdir opencc && \
  cd opencc && \
  git clone https://github.com/BYVoid/OpenCC.git --depth 1 && \
  cd OpenCC && \
  make && \
  make install && \
  # Install OpenCC4php extension:
  cd /tmp/opencc && \
  git clone https://github.com/NauxLiu/opencc4php.git --depth 1 && \
  cd opencc4php && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  # Enable opencc extension:
  docker-php-ext-enable opencc && \
  # Clean up:
  cd /tmp && \
  rm -rf opencc &&\
  apk del .mods \
  ;fi

####################################
# GRPC:
# Check the official github page for more information:
# url: https://cloud.google.com/php/grpc
#
# Will install protobuf extension as well
# url: https://github.com/protocolbuffers/protobuf/tree/master/php
####################################
USER root

ARG INSTALL_GRPC=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_GRPC} = true ]; then \
  pecl install grpc protobuf && \
  docker-php-ext-enable grpc protobuf \
  ;fi

####################################
# Intl:
# Human language and
# Character encoding support.
####################################
USER root

ARG INSTALL_INTL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_INTL} = true ]; then \
  apk add --no-cache \
  icu-dev && \
  docker-php-ext-install -j${NPROC} intl \
  ;fi

####################################
# wddx:
# only work under PHP 7.4
####################################
USER root

ARG INSTALL_WDDX=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_WDDX} = true ]; then \
  if [ "$(printf '%s\n' "7.4" "${PHP_VERSION}" | sort -V | head -n1)" = "7.4" ]; then \
  # greater equal 7.4
  echo "Wddx is only work under PHP 7.4" \
  ;else \
  # less than 7.4
  docker-php-ext-install -j${NPROC} wddx \
  ;fi \
  ;fi

####################################
# LDAP:
####################################
USER root

ARG INSTALL_LDAP=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_LDAP} = true ]; then \
  apk add --no-cache \
  openldap-dev && \
  docker-php-ext-install -j${NPROC} ldap \
  ;fi

####################################
# Imagmagick:
####################################
USER root

ARG INSTALL_IMAGEMAGICK=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_IMAGEMAGICK} = true ]; then \
  apk add --no-cache \
  imagemagick-dev && \
  pecl install imagick && \
  docker-php-ext-enable imagick \
  ;fi

####################################
# SQL server:
####################################
USER root

ARG INSTALL_MSSQL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_MSSQL} = true ]; then \
  #####################################
  # Ref from https://github.com/Microsoft/msphpsql/wiki/Dockerfile-for-adding-pdo_sqlsrv-and-sqlsrv-to-official-php-image
  #
  # But only ODBC is required.
  #####################################
  # Install requireddriver for Microsoft ODBC driver:
  apk add --no-cache \
  unixodbc-dev && \
  # Install sqlsrv extension:
  pecl install pdo_sqlsrv sqlsrv && \
  docker-php-ext-enable pdo_sqlsrv sqlsrv \
  ;fi

####################################
# OpenSwoole:
####################################
USER root

ARG INSTALL_OPENSWOOLE=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_OPENSWOOLE} = true ]; then \
  if [ "$(printf '%s\n' "7.3" "${PHP_VERSION}" | sort -V | head -n1)" = "7.3" ]; then \
  # greater equal 7.3
  pecl install openswoole && \
  docker-php-ext-enable openswoole \
  ;else \
  # less than 7.3
  echo "OpenSwoole is only work PHP 7.3 and later" \
  ;fi \
  ;fi

####################################
# ZMQ:
####################################
USER root

ARG INSTALL_ZMQ=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_ZMQ} = true ]; then \
  apk add --no-cache \
  czmq-dev && \
  # install the ZMQ from source:
  cd /tmp && \
  git clone https://github.com/zeromq/php-zmq.git && \
  cd php-zmq && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  # clean the source:
  cd /tmp && \
  rm -rf php-zmq && \
  # install the extension:
  docker-php-ext-enable zmq \
  ;fi

####################################
# Decimal:
####################################
USER root

ARG INSTALL_DECIMAL=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_DECIMAL} = true ]; then \
  apk add --no-cache \
  mpdecimal-dev && \
  pecl install decimal && \
  docker-php-ext-enable decimal \
  ;fi

####################################
# Trader:
####################################
USER root

ARG INSTALL_TRADER=false

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_TRADER} = true ]; then \
  pecl install trader && \
  docker-php-ext-enable trader \
  ;fi

####################################
# Gearman:
####################################
# USER root

# ARG INSTALL_GEARMAN=false

# RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_GEARMAN} = true ]; then \
#   # Prepar the extraction packages
#   apk add --no-cache --virtual .zip \
#   tar \
#   gzip \
#   zip && \
#   # Prepare the requirements:
#   apk add --no-cache --virtual .mods \
#   boost-dev \
#   gperf && \
#   # Install gearman:
#   cd /tmp && \
#   curl -L -o gearman.tar.gz https://github.com/gearman/gearmand/releases/download/1.1.19.1/gearmand-1.1.19.1.tar.gz && \
#   tar zxvf gearman.tar.gz && \
#   cd gearmand-1.1.19.1 && \
#   ./configure && \
#   make && \
#   make install && \
#   # Install gearman extension:
#   pecl install gearman && \
#   docker-php-ext-enable gearman && \
#   # Clean up:
#   cd /tmp && \
#   rm -rf gearmand-1.1.19.1 && \
#   apk del .zip && \
#   apk del .mods \
#   ;fi

####################################
# PHP Composer:
####################################
USER root

ARG INSTALL_COMPOSER=false

ARG INSTALL_PHP_CODE_QUALITY_TOOLS=false

RUN mkdir -p /usr/local/bin && \
  mkdir -p /root/.composer/vendor/bin

ENV PATH="$PATH:/usr/local/bin"

ADD ./composer.json /tmp/composer.json

RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_COMPOSER} = true ]; then \
  # Install composer:
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  ;fi


USER ${LINUX_USER}

# Install the pre-defined composer packages:
RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_COMPOSER} = true ]; then \
  mkdir -p /home/${LINUX_USER}/.composer && \
  cp /tmp/composer.json /home/${LINUX_USER}/.composer/composer.json && \
  cd /home/${LINUX_USER} && \
  composer global install \
  ;fi

USER ${LINUX_USER}

# Install global packages (GRPC):
RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_COMPOSER} = true ] && [ ${INSTALL_GRPC} = true ]; then \
  composer global --verbose require "grpc/grpc" \
  ;fi

USER ${LINUX_USER}

# Install global packages (Quality tools):
RUN if [ ${INSTALL_PHP} = true ] && [ ${INSTALL_COMPOSER} = true ] && [ ${INSTALL_PHP_CODE_QUALITY_TOOLS} = true ]; then \
  composer global --verbose require \
  "phpmd/phpmd" \
  "squizlabs/php_codesniffer" \
  "friendsofphp/php-cs-fixer" \
  ;fi

USER root

# Add the composer global packages to the PATH:
ENV PATH="$PATH:/home/${LINUX_USER}/.composer/vendor/bin"

####################################
# Nodejs / NVM:
####################################
ARG INSTALL_NODEJS=false
ARG INSTALL_NODEJS_FROM_SOURCE=false
ARG NODEJS_VERSION=stable
ARG NODEJS_VERSION_BACKUP=false

ENV NVM_DIR=/home/${LINUX_USER}/.nvm

ARG NODEJS_NVM_VERSION=v0.39.1

# Prepre the node build environment:
USER root

RUN if [ ${INSTALL_NODEJS} = true ]; then \
  apk add --no-cache --virtual .nodejs \
  linux-headers \
  python3 \
  ;fi

# Install NVM and NodeJS:
USER ${LINUX_USER}

# install default nodejs:
RUN if [ ${INSTALL_NODEJS} = true ]; then \
  cd /home/${LINUX_USER} && \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/${NODEJS_NVM_VERSION}/install.sh | bash && \
  . $NVM_DIR/nvm.sh && \
  # Install nodejs from source:
  if [ ${INSTALL_NODEJS_FROM_SOURCE} = true ]; then \
  nvm install -s ${NODEJS_VERSION} \
  ;else \
  nvm install ${NODEJS_VERSION} \
  ;fi && \
  nvm use ${NODEJS_VERSION} && \
  nvm alias default ${NODEJS_VERSION} && \
  # Install pre-defined nodejs packages:
  nvm use default && \
  npm install -g \
  nodemon \
  pm2 \
  eslint \
  mocha \
  node-gyp \
  typescript \
  tsc && \
  # install backup nodejs:
  if  [ ${NODEJS_VERSION_BACKUP} != false ]; then \
  cd /home/${LINUX_USER} && \
  # Install nodejs from source:
  if [ ${INSTALL_NODEJS_FROM_SOURCE} = true ]; then \
  nvm install -s ${NODEJS_VERSION_BACKUP} \
  ;else \
  nvm install ${NODEJS_VERSION_BACKUP} \
  ;fi && \
  nvm alias backup ${NODEJS_VERSION_BACKUP} && \
  # Install from backup nodejs:
  nvm use backup && \
  npm install -g \
  nodemon \
  pm2 \
  eslint \
  mocha \
  node-gyp \
  typescript \
  tsc \
  ;fi \
  ;fi

# Install nvm setting to bashrc setting
USER ${LINUX_USER}

RUN if [ ${INSTALL_NODEJS} = true ]; then \
  echo "" >> ~/.bashrc && \
  echo "export NVM_DIR=\"\$HOME/.nvm\"" >> ~/.bashrc && \
  echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\" # This load nvm" >> ~/.bashrc \
  ;fi

# Add nvm binaries to root's .bashrc
USER root

# ENV ROOT_NVM_COMMAND "export NVM_DIR=\"${NVM_DIR}\""

RUN if [ ${INSTALL_NODEJS} = true ]; then \
  echo "" >> ~/.bashrc && \
  # echo $ROOT_NVM_COMMAND >> ~/.bashrc && \
  echo "[ -s \"${NVM_DIR}/nvm.sh\" ] && . \"${NVM_DIR}/nvm.sh\" # This loads nvm" >> ~/.bashrc && \
  # set the default nodejs version:
  echo "${NODEJS_VERSION}" > ~/.nvmrc \
  ;fi

# Remove the dev packages for building nodejs:
USER root

RUN if [ ${INSTALL_NODEJS} = true ]; then \
  apk del .nodejs \
  ;fi

####################################
# Python 3:
# Python2 is no longer available
####################################
USER root

ARG INSTALL_PYTHON=false

RUN if [ ${INSTALL_PYTHON} = true ]; then \
  apk add --no-cache \
  python3 \
  py3-pip && \
  # update pip and install virtualenv:
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv \
  ;fi

####################################
# Install Golang:
####################################
USER root

ARG INSTALL_GOLANG=false

RUN if [ ${INSTALL_GOLANG} = true ]; then \
  apk add --no-cache \
  go \
  ;fi

####################################
# Image Optimizers:
####################################
USER root

ARG INSTALL_IMAGE_OPTIMIZERS=false

RUN if [ ${INSTALL_IMAGE_OPTIMIZERS} = true ]; then \
  apk add --no-cache \
  optipng \
  pngquant \
  gifsicle \
  jpegoptim \
  ;fi

####################################
# SSH server:
####################################
USER root

ARG INSTALL_SSH=false

RUN apk add --no-cache \
  openssh && \
  # Generate a new SSH key:
  ssh-keygen -A && \
  echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

####################################
# Fininal Touch
####################################
USER root

ARG PGID=1000

ADD ./laravel.ini /usr/local/etc/php/conf.d
ADD ./laravel.pool.conf /usr/local/etc/php-fpm.d/laravel.pool.conf

# Remove the PHP source
RUN docker-php-source delete && \
  rm -rf /usr/src/php && \
  rm -rf /usr/src/php-src

# Remove all virtual packages and tmp files
RUN apk del .build-deps && \
  rm -rf /tmp/* && \
  rm /var/cache/apk/*

USER root

WORKDIR /var/www

EXPOSE 9000 9001

CMD [ "/usr/sbin/sshd", "-D" ]

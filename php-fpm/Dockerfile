ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}-fpm

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL PHP_VERSION=${PHP_VERSION}

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

##############################
# Set global system libs
##############################

ARG NPROC=1
ENV NPROC ${NPROC}

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  libz-dev \
  libssl-dev \
  curl && \
  pecl channel-update pecl.php.net

##############################
# Set PHP version
##############################

ARG PHP_VERSION=7.1
ENV PHP_VERSION ${PHP_VERSION}


##############################
# Mcrypt:
##############################

# only install mcrypt extsion for php 7.0
ARG INSTALL_MCRYPT=false

RUN if [ ${INSTALL_MCRYPT} = true ] && [ `echo ${PHP_VERSION} | cut -c1-3` = 7.0 ]; then \
  apt-get install -y --no-install-recommends libmcrypt-dev && \
  docker-php-ext-install -j${NPROC} mcrypt \
  ;fi

##############################
# PDO MySQL:
##############################

ARG INSTALL_PDO_MYSQL=false

RUN if [ ${INSTALL_PDO_MYSQL} = true ]; then \
  # pdo_mysql extension
  docker-php-ext-install -j${NPROC} pdo_mysql \
  ;fi

##############################
# PDO PostgreSQL:
##############################

ARG INSTALL_PDO_PGSQL=false

RUN if [ ${INSTALL_PDO_PGSQL} = true ]; then \
  apt-get install -y --no-install-recommends libpq-dev && \
  # pdo_pgsql extension
  docker-php-ext-install -j${NPROC} pdo_pgsql \
  ;fi

##############################
# PDO sqlite:
##############################

ARG INSTALL_PDO_SQLITE=false

RUN if [ ${INSTALL_PDO_SQLITE} = true ]; then \
  apt-get install -y --no-install-recommends libsqlite3-dev && \
  # pdo_sqlite extension
  docker-php-ext-install -j${NPROC} pdo_sqlite \
  ;fi

##############################
# GD:
##############################

ARG INSTALL_GD=false

RUN if [ ${INSTALL_GD} = true ]; then \
  apt-get install -y --no-install-recommends \
  libjpeg62-turbo-dev \
  libpng-dev \
  libfreetype6-dev && \
  #
  # gd extension
  #
  docker-php-ext-configure gd \
  --with-jpeg-dir=/usr/lib \
  --with-freetype-dir=/usr/include/freetype2 && \
  docker-php-ext-install -j${NPROC} gd \
  ;fi

#####################################
# APC:
#####################################

ARG INSTALL_APC=false

RUN if [ ${INSTALL_APC} = true ]; then \
  # Install apcu
  pecl install apcu && \
  echo "extension=apcu.so" >> /usr/local/etc/php/conf.d/apcu.ini \
  ;fi


#####################################
# FTP:
#####################################

ARG INSTALL_FTP=false

RUN if [ ${INSTALL_FTP} = true ]; then \
  # Install ftp
  docker-php-ext-install -j${NPROC} ftp \
  ;fi


#####################################
# XSL:
#####################################

ARG INSTALL_XSL=false

RUN if [ ${INSTALL_XSL} = true ]; then \
  # Install xsl
  apt-get install -y --no-install-recommends libxslt-dev && \
  docker-php-ext-install -j${NPROC} xsl \
  ;fi


#####################################
# calendar:
#####################################

ARG INSTALL_CALENDAR=false

RUN if [ ${INSTALL_CALENDAR} = true ]; then \
  # Install calendar
  docker-php-ext-install -j${NPROC} calendar \
  ;fi


#####################################
# ctype:
#####################################

ARG INSTALL_CTYPE=false

RUN if [ ${INSTALL_CTYPE} = true ]; then \
  # Install ctype
  docker-php-ext-install -j${NPROC} ctype \
  ;fi

#####################################
# DBA:
#####################################

ARG INSTALL_DBA=false

RUN if [ ${INSTALL_DBA} = true ]; then \
  # Install dba
  docker-php-ext-install -j${NPROC} dba \
  ;fi

#####################################
# DOM:
#####################################

ARG INSTALL_DOM=false

RUN if [ ${INSTALL_DOM} = true ]; then \
  # Install dom
  docker-php-ext-install -j${NPROC} dom \
  ;fi

#####################################
# json:
#####################################

ARG INSTALL_JSON=false

RUN if [ ${INSTALL_JSON} = true ]; then \
  # Install json
  docker-php-ext-install -j${NPROC} json \
  ;fi

#####################################
# HASH:
#####################################

ARG INSTALL_HASH=false

RUN if [ ${INSTALL_HASH} = true ]; then \
  # Install ftp
  docker-php-ext-install -j${NPROC} hash \
  ;fi

#####################################
# SOCKETS:
#####################################

ARG INSTALL_SOCKETS=false

RUN if [ ${INSTALL_SOCKETS} = true ]; then \
  # Install sockets
  docker-php-ext-install -j${NPROC} sockets \
  ;fi


#####################################
# PDO:
#####################################

ARG INSTALL_PDO=false

RUN if [ ${INSTALL_PDO} = true ]; then \
  # Install pdo
  docker-php-ext-install -j${NPROC} pdo \
  ;fi

#####################################
# mbstring:
#####################################

ARG INSTALL_MBSTRING=false

RUN if [ ${INSTALL_MBSTRING} = true ]; then \
  # Install mbstring
  docker-php-ext-install -j${NPROC} mbstring \
  ;fi

#####################################
# imap:
#####################################

ARG INSTALL_IMAP=false

RUN if [ ${INSTALL_IMAP} = true ]; then \
  # Install imap
  apt-get install -y --no-install-recommends \
  libc-client-dev \
  libkrb5-dev && \
  docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
  docker-php-ext-install -j${NPROC} imap \
  ;fi

#####################################
# curl:
#####################################

ARG INSTALL_CURL=false

RUN if [ ${INSTALL_CURL} = true ]; then \
  # Install curl
  apt-get install -y --no-install-recommends libcurl4-openssl-dev && \
  docker-php-ext-install -j${NPROC} curl \
  ;fi

#####################################
# fileinfo:
#####################################

ARG INSTALL_FILEINFO=false

RUN if [ ${INSTALL_FILEINFO} = true ]; then \
  # Install fileinfo
  docker-php-ext-install -j${NPROC} fileinfo \
  ;fi

#####################################
# gettext:
#####################################

ARG INSTALL_GETTEXT=false

RUN if [ ${INSTALL_GETTEXT} = true ]; then \
  # Install gettext
  docker-php-ext-install -j${NPROC} gettext \
  ;fi

#####################################
# iconv:
#####################################

ARG INSTALL_ICONV=false

RUN if [ ${INSTALL_ICONV} = true ]; then \
  # Install iconv
  docker-php-ext-install -j${NPROC} iconv \
  ;fi

#####################################
# phar:
#####################################

ARG INSTALL_PHAR=false

RUN if [ ${INSTALL_PHAR} = true ]; then \
  # Install phar
  docker-php-ext-install -j${NPROC} phar \
  ;fi

#####################################
# posix:
#####################################

ARG INSTALL_POSIX=false

RUN if [ ${INSTALL_POSIX} = true ]; then \
  # Install posix
  docker-php-ext-install -j${NPROC} posix \
  ;fi

#####################################
# pspell:
#####################################

ARG INSTALL_PSPELL=false

RUN if [ ${INSTALL_PSPELL} = true ]; then \
  # Install pspell
  apt-get install -y \
  libpspell-dev \
  aspell-en \
  aspell-de && \
  docker-php-ext-configure pspell --with-pspell=/usr && \
  docker-php-ext-install -j${NPROC} pspell \
  ;fi

#####################################
# readline:
#####################################

ARG INSTALL_READLINE=false

RUN if [ ${INSTALL_READLINE} = true ]; then \
  # Install readline
  apt-get install -y --no-install-recommends \
  libedit-dev \
  libreadline-dev && \
  docker-php-ext-install -j${NPROC} readline \
  ;fi

#####################################
# recode:
#####################################

ARG INSTALL_RECODE=false

RUN if [ ${INSTALL_RECODE} = true ]; then \
  # Install recode
  apt-get install -y --no-install-recommends librecode-dev && \
  docker-php-ext-install -j${NPROC} recode \
  ;fi

#####################################
# shmop:
#####################################

ARG INSTALL_SHMOP=false

RUN if [ ${INSTALL_SHMOP} = true ]; then \
  # Install shmop
  docker-php-ext-install -j${NPROC} shmop \
  ;fi

#####################################
# simplexml:
#####################################

ARG INSTALL_SIMPLEXML=false

RUN if [ ${INSTALL_SIMPLEXML} = true ]; then \
  # Install simplexml
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} simplexml \
  ;fi

#####################################
# snmp:
#####################################

ARG INSTALL_SNMP=false

RUN if [ ${INSTALL_SNMP} = true ]; then \
  # Install snmp
  docker-php-ext-install -j${NPROC} snmp \
  ;fi

#####################################
# sysvmsg:
#####################################

ARG INSTALL_SYSVMSG=false

RUN if [ ${INSTALL_SYSVMSG} = true ]; then \
  # Install sysvmsg
  docker-php-ext-install -j${NPROC} sysvmsg \
  ;fi

#####################################
# sysvsem:
#####################################

ARG INSTALL_SYSVSEM=false

RUN if [ ${INSTALL_SYSVSEM} = true ]; then \
  # Install sysvsem
  docker-php-ext-install -j${NPROC} sysvsem \
  ;fi

#####################################
# sysvshm:
#####################################

ARG INSTALL_SYSVSHM=false

RUN if [ ${INSTALL_SYSVSHM} = true ]; then \
  # Install sysvshm
  docker-php-ext-install -j${NPROC} sysvshm \
  ;fi

#####################################
# bz2:
#####################################

ARG INSTALL_BZ2=false

RUN if [ ${INSTALL_BZ2} = true ]; then \
  apt-get install -y --no-install-recommends libbz2-dev && \
  docker-php-ext-install -j${NPROC} bz2 \
  ;fi

#####################################
# enchant:
#####################################

ARG INSTALL_ENCHANT=false

RUN if [ ${INSTALL_ENCHANT} = true ]; then \
  apt-get install -y --no-install-recommends libenchant-dev && \
  docker-php-ext-install -j${NPROC} enchant \
  ;fi

#####################################
# yaml:
#####################################

ARG INSTALL_YAML=false

RUN if [ ${INSTALL_YAML} = true ]; then \
  apt-get install -y --no-install-recommends libyaml-dev && \
  pecl install yaml && \
  docker-php-ext-enable yaml \
  ;fi


#####################################
# tidy:
#####################################

ARG INSTALL_TIDY=false

RUN if [ ${INSTALL_TIDY} = true ]; then \
  # Install tidy
  apt-get install -y --no-install-recommends libtidy-dev && \
  docker-php-ext-install -j${NPROC} tidy \
  ;fi

#####################################
# wddx:
#####################################

ARG INSTALL_WDDX=false

RUN if [ ${INSTALL_WDDX} = true ]; then \
  # Install wddx
  docker-php-ext-install -j${NPROC} wddx \
  ;fi

#####################################
# xml:
#####################################

ARG INSTALL_XML=false

RUN if [ ${INSTALL_XML} = true ]; then \
  # Install xml
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} xml \
  ;fi

#####################################
# xmlrpc:
#####################################

ARG INSTALL_XMLRPC=false

RUN if [ ${INSTALL_XMLRPC} = true ]; then \
  # Install xmlrpc
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} xmlrpc \
  ;fi

#####################################
# xmlwriter:
#####################################

ARG INSTALL_XMLWRITER=false

RUN if [ ${INSTALL_XMLWRITER} = true ]; then \
  # Install xmlwriter
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} xmlwriter \
  ;fi


#####################################
# SOAP:
#####################################

ARG INSTALL_SOAP=false

RUN if [ ${INSTALL_SOAP} = true ]; then \
  # Install the soap extension
  docker-php-ext-install -j${NPROC} soap \
  ;fi

#####################################
# pgsql
#####################################

ARG INSTALL_PGSQL=false

RUN if [ ${INSTALL_PGSQL} = true ]; then \
  # Install the pgsql extension
  docker-php-ext-install -j${NPROC} pgsql \
  ;fi

#####################################
# xDebug:
#####################################

ARG INSTALL_XDEBUG=false

RUN if [ ${INSTALL_XDEBUG} = true ]; then \
  # Install the xdebug extension
  pecl install xdebug && \
  docker-php-ext-enable xdebug \
  ;fi

# Copy xdebug configuration for remote debugging
# COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

#####################################
# Blackfire:
#####################################

ARG INSTALL_BLACKFIRE=false

RUN if [ ${INSTALL_XDEBUG} = false -a ${INSTALL_BLACKFIRE} = true ]; then \
  version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
  && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
  && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
  && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
  && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
  ;fi

#####################################
# PHP REDIS EXTENSION
#####################################

ARG INSTALL_PHPREDIS=false

RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
  # Install Php Redis Extension
  printf "\n" | pecl install -o -f redis && \
  rm -rf /tmp/pear && \
  docker-php-ext-enable redis \
  ;fi

#####################################
# Swoole EXTENSION FOR PHP 7
#####################################

ARG INSTALL_SWOOLE=false

RUN if [ ${INSTALL_SWOOLE} = true ]; then \
  # Install Php Swoole Extension
  pecl install swoole \
  &&  docker-php-ext-enable swoole \
  ;fi

#####################################
# MongoDB:
#####################################

ARG INSTALL_MONGO=false

RUN if [ ${INSTALL_MONGO} = true ]; then \
  # Install the mongodb extension
  pecl install mongodb && \
  docker-php-ext-enable mongodb \
  ;fi

#####################################
# AMQP:
#####################################

ARG INSTALL_AMQP=false

RUN if [ ${INSTALL_AMQP} = true ]; then \
  apt-get install -y --no-install-recommends librabbitmq-dev && \
  # Install the amqp extension
  pecl install amqp && \
  docker-php-ext-enable amqp \
  ;fi

#####################################
# ZipArchive:
#####################################

ARG INSTALL_ZIP_ARCHIVE=false

RUN if [ ${INSTALL_ZIP_ARCHIVE} = true ]; then \
  apt-get install -y --no-install-recommends libzip-dev && \
  # Install the zip extension
  docker-php-ext-install -j${NPROC} zip \
  ;fi

#####################################
# bcmath:
#####################################

ARG INSTALL_BCMATH=false

RUN if [ ${INSTALL_BCMATH} = true ]; then \
  # Install the bcmath extension
  docker-php-ext-install -j${NPROC} bcmath \
  ;fi

#####################################
# GMP (GNU Multiple Precision):
#####################################

ARG INSTALL_GMP=false

RUN if [ ${INSTALL_GMP} = true ]; then \
  # Install the GMP extension
  apt-get install -y --no-install-recommends libgmp-dev && \
  docker-php-ext-install -j${NPROC} gmp \
  ;fi

#####################################
# PHP Memcached:
#####################################

ARG INSTALL_MEMCACHED=false

RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
  apt-get install -y --no-install-recommends libmemcached-dev && \
  # Install the php memcached extension
  curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz" && \
  mkdir -p memcached && \
  tar -C memcached -zxvf /tmp/memcached.tar.gz --strip 1 && \
  ( \
  cd memcached \
  && phpize \
  && ./configure \
  && make -j${NPROC} \
  && make install \
  ) && \
  rm -r memcached && \
  rm /tmp/memcached.tar.gz && \
  docker-php-ext-enable memcached \
  ;fi

#####################################
# Exif:
#####################################

ARG INSTALL_EXIF=false

RUN if [ ${INSTALL_EXIF} = true ]; then \
  # Enable Exif PHP extentions requirements
  docker-php-ext-install -j${NPROC} exif \
  ;fi

#####################################
# PHP Aerospike:
#####################################

ARG INSTALL_AEROSPIKE=false

COPY ./aerospike.ini /usr/local/etc/php/conf.d/aerospike.ini

RUN if [ ${INSTALL_AEROSPIKE} = true ]; then \
  # Install the php aerospike extension
  curl -L -o /tmp/aerospike-client-php.tar.gz "https://github.com/aerospike/aerospike-client-php/archive/master.tar.gz" && \
  mkdir -p aerospike-client-php && \
  tar -C aerospike-client-php -zxvf /tmp/aerospike-client-php.tar.gz --strip 1 && \
  ( \
  cd aerospike-client-php/src \
  && phpize \
  && ./build.sh \
  && make install \
  ) && \
  rm /tmp/aerospike-client-php.tar.gz \
  ;else \
  rm /usr/local/etc/php/conf.d/aerospike.ini \
  ;fi

#####################################
# Opcache:
#####################################

ARG INSTALL_OPCACHE=false

RUN if [ ${INSTALL_OPCACHE} = true ]; then \
  docker-php-ext-install -j${NPROC} opcache \
  ;fi

# Copy opcache configration
# COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini

#####################################
# Mysqli Modifications:
#####################################

ARG INSTALL_MYSQLI=false

RUN if [ ${INSTALL_MYSQLI} = true ]; then \
  docker-php-ext-install -j${NPROC} mysqli \
  ;fi

#####################################
# Tokenizer Modifications:
#####################################

ARG INSTALL_TOKENIZER=false

RUN if [ ${INSTALL_TOKENIZER} = true ]; then \
  docker-php-ext-install -j${NPROC} tokenizer \
  ;fi

#####################################
# Human Language and Character Encoding Support:
#####################################

ARG INSTALL_INTL=false

RUN if [ ${INSTALL_INTL} = true ]; then \
  # Install intl and requirements
  apt-get install -y --no-install-recommends zlib1g-dev libicu-dev g++ && \
  docker-php-ext-configure intl && \
  docker-php-ext-install -j${NPROC} intl \
  ;fi

#####################################
# pcntl:
#####################################

ARG INSTALL_PCNTL=false

RUN if [ ${INSTALL_PCNTL} = true ]; then \
  docker-php-ext-install -j${NPROC} pcntl && \
  docker-php-ext-enable pcntl \
  ;fi

#####################################
# PHP V8JS
#####################################

ARG INSTALL_V8JS=false

RUN if [ ${INSTALL_V8JS} = true ]; then \
  apt-get install -y --no-install-recommends git && \
  #
  # Check https://github.com/phpv8/v8js/blob/php7/README.Linux.md to install necessary libraries
  #
  # Get v8 and compile it
  #
  apt-get install -y --no-install-recommends \
  curl \
  git \
  python \
  libglib2.0-dev \
  patchelf && \
  cd /tmp && \
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
  export PATH=`pwd`/depot_tools:"$PATH" && \
  #
  # Download v8
  #
  fetch v8 && \
  cd v8 && \
  gclient sync && \
  #
  # Setup GN
  #
  tools/dev/v8gen.py -vv x64.release -- is_component_build=true && \
  #
  # Build
  #
  ninja -l${NPROC} -C out.gn/x64.release/ && \
  #
  # Install to /opt/v8
  #
  mkdir -p /opt/v8/lib && \
  mkdir -p /opt/v8/include && \
  cp out.gn/x64.release/lib*.so out.gn/x64.release/*_blob.bin \
  out.gn/x64.release/icudtl.dat /opt/v8/lib/ && \
  cp -R include/* /opt/v8/include/ && \
  #
  # only on debian
  #
  for A in /opt/v8/lib/*.so; do patchelf --set-rpath '$ORIGIN' $A; done \
  ;fi

#
# Compile php-v8js itself
#
RUN if [ ${INSTALL_V8JS} = true ]; then \
  cp /opt/v8/{natives_blob.bin,snapshot_blob.bin} /usr/bin && \
  cd /opt/v8/obj && \
  ar rcsDT libv8_libplatform.a v8_libplatform/*.o && \
  cd /tmp && \
  git clone https://github.com/phpv8/v8js.git && \
  cd v8js && \
  phpize && \
  ./configure --with-v8js=/opt/v8 LDFLAGS="-lstdc++" && \
  make -j${NPROC} && \
  make test && \
  make install && \
  mkdir -p /etc/php/${PHP_VERSION}/cli && \
  echo "extension=v8js.so" >> /usr/local/etc/php/conf.d/v8js.ini \
  ;fi

#####################################
# libevent:
#####################################

ARG INSTALL_EVENT=false

RUN if [ ${INSTALL_EVENT} = true ]; then \
  apt-get install -y --no-install-recommends libevent-dev && \
  pecl install event && \
  docker-php-ext-enable event \
  ;fi

#####################################
# Suhosin:
#####################################

ARG INSTALL_SUHOSIN=false

RUN if [ `echo ${PHP_VERSION} | cut -c1-3` != 7.2 ] && [ `echo ${PHP_VERSION} | cut -c1-3` != 7.3 ] && [ ${INSTALL_SUHOSIN} = true ]; then \
  cd /tmp && \
  git clone https://github.com/sektioneins/suhosin7.git suhosin && \
  cd suhosin && \
  phpize && \
  ./configure && \
  make -j ${NPROC} && \
  make install && \
  echo "extension=suhosin.so" >> /usr/local/etc/php/conf.d/suhosin.ini \
  ;fi

#####################################
# Inotify:
#####################################

ARG INSTALL_INOTIFY=false

RUN if [ ${INSTALL_INOTIFY} = true ]; then \
  pecl install inotify && \
  echo "extension=inotify.so" >> /usr/local/etc/php/conf.d/inotify.ini \
  ;fi

#####################################
# OpenCC:
#####################################

ARG INSTALL_OPENCC=false

RUN if [ ${INSTALL_OPENCC} = true ]; then \
  apt-get install -y --no-install-recommends libopencc-dev git && \
  cd /tmp && \
  git clone https://github.com/nauxliu/opencc4php.git --depth 1 && \
  cd opencc4php && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  echo "extension=opencc.so" >> /usr/local/etc/php/conf.d/opencc.ini && \
  apt-get remove -y git \
  ;fi

#####################################
# Protobuf:
#
# pecl: https://pecl.php.net/package/protobuf
# github: https://github.com/protocolbuffers/protobuf/tree/master/php
#####################################

ARG INSTALL_PROTOBUF=false

RUN if [ ${INSTALL_PROTOBUF} = true ]; then \
  pecl install protobuf && \
  echo "extension=protobuf.so" >> /usr/local/etc/php/conf.d/protobuf.ini \
  ;fi

#####################################
# GHOSTSCRIPT:
#####################################

ARG INSTALL_GHOSTSCRIPT=false

RUN if [ ${INSTALL_GHOSTSCRIPT} = true ]; then \
  # Install the ghostscript extension
  # for PDF editing
  apt-get install -y --no-install-recommends poppler-utils ghostscript \
  ;fi

#####################################
# LDAP:
#####################################

ARG INSTALL_LDAP=false

RUN if [ ${INSTALL_LDAP} = true ]; then \
  apt-get install -y --no-install-recommends libldap2-dev && \
  docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
  docker-php-ext-install -j${NPROC} ldap \
  ;fi

#####################################
# SQL SERVER:
#####################################

ARG INSTALL_MSSQL=false

RUN if [ ${INSTALL_MSSQL} = true ]; then \
  #####################################
  # Ref from https://github.com/Microsoft/msphpsql/wiki/Dockerfile-for-adding-pdo_sqlsrv-and-sqlsrv-to-official-php-image
  #####################################
  # Add Microsoft repo for Microsoft ODBC Driver 13 for Linux
  apt-get update -yqq && \
  apt-get install -y --no-install-recommends apt-transport-https && \
  curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
  curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
  #
  # Install Dependencies
  #
  ACCEPT_EULA=Y apt-get install -y --no-install-recommends unixodbc unixodbc-dev libgss3 odbcinst msodbcsql locales && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
  #
  # Install pdo_sqlsrv and sqlsrv from PECL. Replace pdo_sqlsrv-4.1.8preview with preferred version.
  #
  pecl install pdo_sqlsrv-4.1.8preview sqlsrv-4.1.8preview && \
  docker-php-ext-enable pdo_sqlsrv sqlsrv \
  ;fi

#####################################
# Image optimizers:
#####################################

ARG INSTALL_IMAGE_OPTIMIZERS=false

RUN if [ ${INSTALL_IMAGE_OPTIMIZERS} = true ]; then \
  apt-get install -y --no-install-recommends jpegoptim optipng pngquant gifsicle \
  ;fi

#####################################
# ImageMagick:
#####################################

ARG INSTALL_IMAGEMAGICK=false

RUN if [ ${INSTALL_IMAGEMAGICK} = true ]; then \
  apt-get install -y --no-install-recommends libmagickwand-dev imagemagick && \
  pecl install imagick && \
  docker-php-ext-enable imagick \
  ;fi

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

ADD ./laravel.ini /usr/local/etc/php/conf.d
ADD ./laravel.pool.conf /usr/local/etc/php-fpm.d/

RUN apt-get -y autoremove && \
  apt-get clean && \
  rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000 9001

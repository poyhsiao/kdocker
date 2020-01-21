ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}-fpm

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL PHP_VERSION=${PHP_VERSION}

##############################
# Set global system env
##############################

ARG NPROC=1
ENV NPROC ${NPROC}

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  locales \
  libz-dev \
  libssl-dev && \
  pecl channel-update pecl.php.net

### Install tools

RUN apt-get install -y --no-install-recommends \
  zip \
  unzip \
  wget \
  curl \
  git \
  netcat \
  vim

### Install canvas required packages

ARG CANVAS_SUPPORT=false

RUN if [ ${CANVAS_SUPPORT} = true ]; then \
  apt-get install -y --no-install-recommends \
  libcairo2-dev \
  libgif-dev \
  libpango1.0-dev \
  ;fi

##############################
# Set global system env
##############################
RUN DEBIAN_FRONTEND=noninteractive

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  locale-gen

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN locale-gen

ENV TERM xterm

##############################
# Add user
##############################

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ARG PGID=1000
ARG LINUX_USER=kim

RUN groupadd -g ${PGID} ${LINUX_USER} && \
  useradd -u ${PUID} -g ${LINUX_USER} -m ${LINUX_USER}

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

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
  # gd extension
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
  if [ `echo ${PHP_VERSION} | cut -c1` = 7 ]; then \
  # Install apcu
  pecl install apcu \
  ;else \
  pecl install apcu-4.0.10 \
  ;fi && \
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

# Install phar
RUN if [ `echo ${PHP_VERSION} | cut -c1` = 7 ] && [ ${INSTALL_PHAR} = true ]; then \
  docker-php-ext-install -j${NPROC} phar \
  ;fi

#####################################
# posix:
#####################################

ARG INSTALL_POSIX=false

# Install posix
RUN if [ ${INSTALL_POSIX} = true ]; then \
docker-php-ext-install -j${NPROC} posix \
  ;fi

#####################################
# pspell:
#####################################

ARG INSTALL_PSPELL=false

# Install pspell
RUN if [ ${INSTALL_PSPELL} = true ]; then \
  apt-get install -y --no-install-recommends \
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

# Install readline
RUN if [ ${INSTALL_READLINE} = true ]; then \
  apt-get install -y --no-install-recommends \
  libedit-dev \
  libreadline-dev && \
  docker-php-ext-install -j${NPROC} readline \
  ;fi

####################################
# recode:
####################################

ARG INSTALL_RECODE=false

#install recode
RUN if [ ${INSTALL_RECODE} = true ]; then \
  apt-get install -y --no-install-recommends librecode-dev && \
  docker-php-ext-install -j${NPROC} recode \
  ;fi

#####################################
# SHMOP:
#####################################

ARG INSTALL_SHMOP=false
# Install shmop
RUN if [ ${INSTALL_SHMOP} = true ]; then \
  docker-php-ext-install -j${NPROC} shmop \
  ;fi

###################################
# simplexml:
###################################

ARG INSTALL_SIMPLEXML=false

# Install simplexml
RUN if [ ${INSTALL_SIMPLEXML} = true ]; then \
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} simplexml \
  ;fi

####################################
# SNMP:
####################################

ARG INSTALL_SNMP=false

# Install snmp
RUN if [ ${INSTALL_SNMP} = true ]; then \
  docker-php-ext-install -j${NPROC} snmp \
  ;fi

#####################################
# sysvmsg:
#####################################

ARG INSTALL_SYSVMSG=false

# Install sysvmsg
RUN if [ ${INSTALL_SYSVMSG} = true ]; then \
  docker-php-ext-install -j${NPROC} sysvmsg \
  ;fi

####################################
# sysvsem:
####################################

ARG INSTALL_SYSVSEM=false

# Install sysvsem
RUN if [ ${INSTALL_SYSVSEM} = true ]; then \
  docker-php-ext-install -j${NPROC} sysvsem \
  ;fi

######################################
# svshm:
######################################

ARG INSTALL_SYSVSHM=false

# Install sysvshm
RUN if [ ${INSTALL_SYSVSHM} = true ]; then \
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


###################################
# enchant:
###################################

ARG INSTALL_ENCHANT=false

RUN if [ ${INSTALL_ENCHANT} = true ]; then \
  apt-get install -y --no-install-recommends libenchant-dev && \
  docker-php-ext-install -j${NPROC} enchant \
  ;fi

###################################
# yaml:
###################################

RUN INSTALL_YAML=false

RUN if [ ${INSTALL_YAML} = true ]; then \
  apt-get install -y --no-install-recommends libyaml-dev && \
  if [ `echo ${PHP_VERSION} | cut -c1` = 7 ]; then \
    pecl install yaml \
  ;else \
    pecl install yaml-1.3.0 \
  ;fi && \
  docker-php-ext-enable yaml \
  ;fi

###################################
# tidy:
###################################

ARG INSTALL_TIDY=false

# Install tidy
RUN if [ ${INSTALL_TIDY} = true ]; then \
  apt-get install -y --no-install-recommends libtidy-dev && \
  docker-php-ext-install -j${NPROC} tidy \
  ;fi

###################################
# wddx:
###################################

ARG INSTALL_WDDX=false

# Install wddx
RUN if [ ${INSTALL_WDDX} = true ]; then \
  docker-php-ext-install -j${NPROC} wddx \
  ;fi

#####################################
# xml:
#####################################

ARG INSTALL_XML=false

# Install xml
RUN if [ ${INSTALL_XML} = true ]; then \
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} xml \
  ;fi

#####################################
# xmlreader:
#####################################

ARG INSTALL_XMLREADER=false

# Install xmlreader
RUN if [ ${INSTALL_XMLREADER} = true ]; then \
  apt-get install -y libxml2-dev && \
  docker-php-ext-install -j${NPROC} xmlreader \
  ;fi

#####################################
# xmlrpc:
#####################################

ARG INSTALL_XMLRPC=false

# Install xmlrpc
RUN if [ ${INSTALL_XMLRPC} = true ]; then \
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} xmlrpc \
  ;fi

#####################################
# xmlwriter:
#####################################

ARG INSTALL_XMLWRITER=false

# Install xmlwriter
RUN ${INSTALL_XMLWRITER} = true ]; then \
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-install -j${NPROC} xmlwriter \
  ;fi

###################################
# SOAP:
###################################

ARG INSTALL_SOAP=false

# Install the soap extension
RUN if [ ${INSTALL_SOAP} = true ]; then \
  docker-php-ext-install -j${NPROC} soap \
  ;fi

#####################################
# pgsql
#####################################

ARG INSTALL_PGSQL=false

# Install the pgsql extension
RUN if [ ${INSTALL_PGSQL} = true ]; then \
  apt-get install -y --no-install-recommends libpq-dev && \
  docker-php-ext-install -j${NPROC} pgsql \
  ;fi

###################################
# pgsql client
###################################

ARG INSTALL_PG_CLIENT=false

# Install the pgsql client
RUN if [ ${INSTALL_PG_CLIENT} = true ]; then \
  apt-get install -yf postgresql-client \
  ;fi

#####################################
# xDebug:
#####################################

ARG INSTALL_XDEBUG=false

# Install the xdebug extension
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
  if [ `echo ${PHP_VERSION} | cut -c1` = 7 ]; then \
    pecl install xdebug \
  ;else \
    pecl install xdebug-2.5.5 \
  ;fi && \
  docker-php-ext-enable xdebug \
  ;fi


#####################################
# Blackfire:
#####################################

ARG INSTALL_BLACKFIRE=false

RUN if [ ${INSTALL_XDEBUG} = false -a ${INSTALL_BLACKFIRE} = true ]; then \
  version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;")  && \
  curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version && \
  tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp && \
  mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
  printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
  ;fi

###################################
# PHP REDIS EXTENSION
#####################################

ARG INSTALL_PHPREDIS=false

RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
  if [ `echo ${PHP_VERSION} | cut -c1` != 7 ]; then \
    pecl install redis-4.3.0 \
  ;else \
    pecl install redis \
  ;fi && \
  docker-php-ext-enable redis \
  ;fi


#####################################
# Swoole EXTENSION FOR PHP 7
#####################################

ARG INSTALL_SWOOLE=false

# install Php Swoole Extension
RUN if [ ${INSTALL_SWOOLE} = true ] && [ `echo ${PHP_VERSION} | cut -c1` = 7 ]; then \
  pecl install swoole && \
  docker-php-ext-enable swoole \
  ;fi

#####################################
# mongoDB:
#####################################

ARG INSTALL_MONGO=false

# install mongodb extension
RUN if [ ${INSTALL_MONGO} = true ]; then \
  pecl install mongodb && \
  docker-php-ext-enable mongodb \
  ;fi

#####################################
# AMQP:
#####################################

ARG INSTALL_AMQP=false

# install the amqp extension
RUN if [ ${INSTALL_AMQP} = true ]; then \
  apt-get install -y --no-install-recommends librabbitmq-dev && \
  pecl install amqp && \
  docker-php-ext-enable amqp \
  ;fi

#################################
# ZipArchive:
#################################

ARG INSTALL_ZIP_ARCHIVE=false

# Install the zip extension
RUN if [ ${INSTALL_ZIP_ARCHIVE} = true ]; then \
  apt-get install -y --no-install-recommends libzip-dev && \
  docker-php-ext-install -j${NPROC} zip \
  ;fi

######################################
# bcmath:
######################################

ARG INSTALL_BCMATH=false

# install the bcmath extension
RUN if [ ${INSTALL_BCMATH} = true ]; then \
  docker-php-ext-install -j${NPROC} bcmath \
  ;fi

######################################
# GMP (GNU Multiple Precision):
######################################

ARG INSTALL_GMP=false

# Install the GMP extension
RUN if [ ${INSTALL_GMP} = true ]; then \
  apt-get install -y --no-install-recommends libgmp-dev && \
  if [ `echo ${PHP_VERSION} | cut -c1` != 7 ]; then \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
  ;fi && \
  docker-php-ext-install -j${NPROC} gmp \
  ;fi

#####################################
# PHP Memcached:
#####################################

ARG INSTALL_MEMCACHED=false

# Install the php memcached extension
RUN [ ${INSTALL_MEMCACHED} = true ]; then \
  apt-get install -y --no-install-recommends libmemcached-dev && \
  if [ `echo ${PHP_VERSION} | cut -c1` != 7 ]; then \
    pecl install memcached-2.2.0 \
  ;else \
    pecl install memcached \
  ;fi && \
  docker-php-ext-enable memcached \
  ;fi

#####################################
# Exif:
#####################################

ARG INSTALL_EXIF=false

RUN if [ ${INSTALL_EXIF} = true ]; then \
  docker-php-ext-install -j${NPROC} exif \
  ;fi

#####################################
# PHP Aerospike:
#####################################

ARG INSTALL_AEROSPIKE=false
ENV INSTALL_AEROSPIKE ${INSTALL_AEROSPIKE}

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


####################################
# Mysqli Modifications:
####################################

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

# Install intl and requirements
RUN if [ ${INSTALL_INTL} = true ]; then \
  apt-get install -y zlib1g-dev libicu-dev g++ && \
  docker-php-ext-configure intl && \
  docker-php-ext-install -j${NPROC} intl \
  ;fi

#####################################
# GHOSTCRIPT:
#####################################

ARG INSTALL_GHOSTSCRIPT=false

# install the ghostscript extension
RUN if [ ${INSTALL_GHOSTSCRIPT} = true ]; then \
  # for PDF editing
  apt-get install -y --no-install-recommends poppler-utils ghostscript \
  ;fi

####################################
# LDAP:
###################################

ARG INSTALL_LDAP=false

RUN if [ ${INSTALL_LDAP} = true ]; then \
  apt-get install -y --no-install-recommends libldap2-dev && \
  docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
  docker-php-ext-install -j${NPROC} ldap \
  ;fi

###################################
# pcntl:
###################################

ARG INSTALL_PCNTL=false

RUN if [ ${INSTALL_PCNTL} = true ]; then \
  docker-php-ext-install -j${NPROC} pcntl && \
  docker-php-ext-enable pcntl \
  ;fi

######################################
# SQL SERVER:
######################################
USER root

ARG INSTALL_MSSQL=false
ENV INSTALL_MSSQL ${INSTALL_MSSQL}

RUN if [ ${INSTALL_MSSQL} = true ]; then \
  #####################################
  # Install Depenencies:
  #####################################
  cd / && \
  apt-get update -yqq && \
  apt-get install -yf --no-install-recommends wget apt-transport-https curl freetds-common libsybdb5 freetds-bin unixodbc unixodbc-dev && \
  #
  #####################################
  #  The following steps were taken from
  #  Microsoft's github account:
  #  https://github.com/Microsoft/msphpsql/wiki/Dockerfile-for-getting-pdo_sqlsrv-for-PHP-7.0-on-Debian-in-3-ways
  #####################################
  #
  # Add PHP 7 repository
  # for Debian jessie
  # And System upgrade
  #
  cd / && \
  echo "deb http://packages.dotdeb.org jessie all" \
  | tee /etc/apt/sources.list.d/dotdeb.list \
  && wget -qO- https://www.dotdeb.org/dotdeb.gpg \
  | apt-key add - \
  && apt-get update -yqq \
  && apt-get upgrade -qq && \
  #
  # Install UnixODBC
  # Compile odbc_config as it is not part of unixodbc package
  cd / && \
  apt-get update -yqq && \
  apt-get install -y --no-install-recommends whiptail \
  unixodbc libgss3 odbcinst devscripts debhelper dh-exec dh-autoreconf libreadline-dev libltdl-dev \
  && dget -u -x http://http.debian.net/debian/pool/main/u/unixodbc/unixodbc_2.3.1-3.dsc \
  && cd unixodbc-*/ \
  && ./configure && make -j${NPROC} && make install \
  && cp -v ./exe/odbc_config /usr/local/bin/ && \
  #
  # Fake uname for install.sh
  #
  printf '#!/bin/bash\nif [ "$*" == "-p" ]; then echo "x86_64"; else /bin/uname "$@"; fi' \
  | tee /usr/local/bin/uname \
  && chmod +x /usr/local/bin/uname && \
  #
  # Microsoft ODBC Driver 13 for Linux
  # Note: There's a copy of this tar on my hubiC
  #
  cd / && \
  wget -nv -O msodbcsql-13.0.0.0.tar.gz \
  "https://meetsstorenew.blob.core.windows.net/contianerhd/Ubuntu%2013.0%20Tar/msodbcsql-13.0.0.0.tar.gz?st=2016-10-18T17%3A29%3A00Z&se=2022-10-19T17%3A29%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=cDwPfrouVeIQf0vi%2BnKt%2BzX8Z8caIYvRCmicDL5oknY%3D" \
  && tar -xf msodbcsql-13.0.0.0.tar.gz \
  && cd msodbcsql-*/ \
  && ldd lib64/libmsodbcsql-13.0.so.0.0 \
  && ./install.sh install --accept-license \
  && ls -l /opt/microsoft/msodbcsql/ \
  && odbcinst -q -d -n "ODBC Driver 13 for SQL Server" && \
  #
  #####################################
  # Install sqlsrv y pdo_sqlsrv
  # extensions:
  #####################################
  #
  pecl install sqlsrv-4.0.8 && \
  pecl install pdo_sqlsrv-4.0.8 && \
  #
  #####################################
  # Set locales for the container
  #####################################
  #
  apt-get install -y --no-install-recommends locales \
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen \
  && echo "extension=sqlsrv.so" > /etc/php/7.1/cli/conf.d/20-sqlsrv.ini \
  && echo "extension=pdo_sqlsrv.so" > /etc/php/7.1/cli/conf.d/20-pdo_sqlsrv.ini \
  ;fi

#####################################
# PHP V8JS
#####################################

ARG INSTALL_V8JS=false
ENV INSTALL_V8JS ${INSTALL_V8JS}

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
  # cp /opt/v8/natives_blob /usr/bin && \
  # cp /opt/v8/bin,snapshot_blob.bin /usr/bin && \
  ls -alh /opt/v8 && \
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
# Image optimizers:
#####################################

ARG INSTALL_IMAGE_OPTIMIZERS=false

RUN if [ ${INSTALL_IMAGE_OPTIMIZERS} = true ]; then \
  apt-get install -yf --no-install-recommends jpegoptim optipng pngquant gifsicle \
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


#####################################
# Suhosin:
#####################################

ARG INSTALL_SUHOSIN=false

RUN [ ${INSTALL_SUHOSIN} = true ]; then \
  if [ `echo ${PHP_VERSION} | cut -c1-3` = 7.0 ] || [ `echo ${PHP_VERSION} | cut -c1-3` = 7.1 ]; then \
    cd /tmp && \
    git clone https://github.com/sektioneins/suhosin7.git suhosin && \
    cd suhosin && \
    phpize && \
    ./configure && \
    make -j${NPROC} && \
    make install && \
    echo "extension=suhosin.so" >> /usr/local/etc/php/conf.d/suhosin.ini \
  ;fi

#####################################
# Inotify:
#####################################

ARG INSTALL_INOTIFY=false

RUN if [ ${INSTALL_INOTIFY} = true ]; then \
  if [ `echo ${PHP_VERSION} | cut -c1` != 7 ]; then \
    pecl install inotify-0.1.6 \
  ;else \
    pecl install inotify \
  ;fi && \
  echo "extension=inotify.so" >> /usr/local/etc/php/conf.d/inotify.ini \
  ;fi

#####################################
# OpenCC:
#####################################

ARG INSTALL_OPENCC=false

RUN if [ ${INSTALL_OPENCC} = true ] && [ `echo ${PHP_VERSION} | cut -c1` = 7 ]; then \
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
# PHP Composer:
#####################################

USER root
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV PATH="$PATH:/usr/local/bin"

ADD ./composer.json /root/.composer/composer.json

RUN composer global install && \
  composer global --verbose require "hirak/prestissimo" && \
  rm /root/.composer/composer.json

ARG INSTALL_PHP_CODE_QUALITY_TOOLS=false

RUN if [ ${INSTALL_PHP_CODE_QUALITY_TOOLS} = true ]; then \
  composer global --verbose require "squizlabs/php_codesniffer=*" && \
  composer global --verbose require "friendsofphp/php-cs-fixer" && \
  composer global --verbose require "phpmd/phpmd" \
  ;fi


#####################################
# Drush:
#####################################
USER root

ARG INSTALL_DRUSH=false

ENV DRUSH_VERSION 8.1.2

RUN if [ ${INSTALL_DRUSH} = true ]; then \
  apt-get -y install mysql-client && \
  # Install Drush 8 with the phar file.
  curl -fsSL -o /usr/local/bin/drush https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar | bash && \
  chmod +x /usr/local/bin/drush && \
  drush core-status \
  ;fi

#####################################
# Drupal Console:
#####################################
USER root

ARG INSTALL_DRUPAL_CONSOLE=false

RUN if [ ${INSTALL_DRUPAL_CONSOLE} = true ]; then \
  apt-get -y install --no-install-recommends mysql-client && \
  curl https://drupalconsole.com/installer -L -o drupal.phar && \
  mv drupal.phar /usr/local/bin/drupal && \
  chmod +x /usr/local/bin/drupal \
  ;fi

#####################################
# Non-root user : PHPUnit path
#####################################

# add ./vendor/bin to non-root user's bashrc (needed for phpunit)
USER ${LINUX_USER}

RUN echo "" >> ~/.bashrc && \
  echo 'export PATH="/var/www/vendor/bin:$PATH"' >> ~/.bashrc

#####################################
# Laravel Envoy:
#####################################
USER ${LINUX_USER}

ARG INSTALL_LARAVEL_ENVOY=false

RUN if [ ${INSTALL_LARAVEL_ENVOY} = true ]; then \
  # Install the Laravel Envoy
  composer global --verbose require "laravel/envoy=~1.0" \
  ;fi

#####################################
# Laravel Installer:
#####################################
USER ${LINUX_USER}

ARG INSTALL_LARAVEL_INSTALLER=false

RUN if [ ${INSTALL_LARAVEL_INSTALLER} = true ]; then \
  # Install the Laravel Installer
  composer global require "laravel/installer" \
  ;fi

#####################################
# Deployer:
#####################################
USER ${LINUX_USER}

ARG INSTALL_DEPLOYER=false

RUN if [ ${INSTALL_DEPLOYER} = true ]; then \
  # Install the Deployer
  composer global require "deployer/deployer" \
  ;fi

#####################################
# Linuxbrew:
#####################################
USER root

ARG INSTALL_LINUXBREW=false

RUN if [ ${INSTALL_LINUXBREW} = true ]; then \
  # Preparation
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends build-essential make cmake scons curl git \
  ruby autoconf automake autoconf-archive \
  gettext libtool flex bison \
  libbz2-dev libcurl4-openssl-dev \
  libexpat-dev libncurses-dev && \
  #
  # Install the Linuxbrew
  #
  git clone --depth=1 https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew && \
  echo "" >> ~/.bashrc && \
  echo 'export PKG_CONFIG_PATH"=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH"' >> ~/.bashrc && \
  #
  # Setup linuxbrew
  #
  echo 'export LINUXBREWHOME="$HOME/.linuxbrew"' >> ~/.bashrc && \
  echo 'export PATH="$LINUXBREWHOME/bin:$PATH"' >> ~/.bashrc && \
  echo 'export MANPATH="$LINUXBREWHOME/man:$MANPATH"' >> ~/.bashrc && \
  echo 'export PKG_CONFIG_PATH="$LINUXBREWHOME/lib64/pkgconfig:$LINUXBREWHOME/lib/pkgconfig:$PKG_CONFIG_PATH"' >> ~/.bashrc && \
  echo 'export LD_LIBRARY_PATH="$LINUXBREWHOME/lib64:$LINUXBREWHOME/lib:$LD_LIBRARY_PATH"' >> ~/.bashrc \
  ;fi

#####################################
# Minio:
#####################################
USER root

ARG INSTALL_MC=false

COPY mc/config.json /root/.mc/config.json

RUN if [ ${INSTALL_MC} = true ]; then\
  curl -fsSL -o /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && \
  chmod +x /usr/local/bin/mc \
  ;fi

#####################################
# Symfony:
#####################################
USER root

ARG INSTALL_SYMFONY=false

RUN if [ ${INSTALL_SYMFONY} = true ]; then \
  mkdir -p /usr/local/bin \
  && curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
  && chmod a+x /usr/local/bin/symfony \
  #
  #  Symfony 3 alias
  #
  && echo 'alias dev="php bin/console -e=dev"' >> ~/.bashrc \
  && echo 'alias prod="php bin/console -e=prod"' >> ~/.bashrc \
  #
  #  Symfony 2 alias
  #  && echo 'alias dev="php app/console -e=dev"' >> ~/.bashrc \
  #  && echo 'alias prod="php app/console -e=prod"' >> ~/.bashrc \
  #
  ;fi

#####################################
# PYTHON:
#####################################
USER root

ARG INSTALL_PYTHON=false

ARG INSTALL_PYTHON3=false

RUN if [ ${INSTALL_PYTHON} = true ]; then \
  apt-get update && \
  apt-get install -y --no-install-recommends python python-pip python-dev && \
  pip install --upgrade virtualenv \
  ;fi

RUN if [ ${INSTALL_PYTHON3} = true ] && [ `echo ${PHP_VERSION} | cut -c1` = 7 ]; then \
  if [ `echo ${PHP_VERSION} | cut -c1-3` = 7.3 ]; then \
    export PYTHON3_VERSION=3.7 \
  ;elif [ `echo ${PHP_VERSION} | cut -c1-3` = 7.2 ]; then \
    export PYTHON3_VERSION=3.5 \
  ;else \
    export PYTHON3_VERSION=3.4 \
  ;fi && \
  apt-get install -y --no-install-recommends \
  libpython$PYTHON3_VERSION \
  libpython$PYTHON3_VERSION-dev \
  python$PYTHON3_VERSION \
  python3-pip \
  python$PYTHON3_VERSION-dev && \
  pip3 install --upgrade virtualenv \
  ;fi

#####################################
# Terraform:
#####################################
USER root

ARG INSTALL_TERRAFORM=false

RUN if [ ${INSTALL_TERRAFORM} = true ]; then \
  curl -O https://releases.hashicorp.com/terraform/0.10.6/terraform_0.10.6_linux_amd64.zip && \
  unzip terraform_0.10.6_linux_amd64.zip && \
  mv terraform /usr/local/bin && \
  rm terraform_0.10.6_linux_amd64.zip \
  ;fi

#####################################
# Dusk Dependencies:
#####################################
USER root

ARG CHROME_DRIVER_VERSION=stable
ENV CHROME_DRIVER_VERSION ${CHROME_DRIVER_VERSION}

ARG INSTALL_DUSK_DEPS=false

RUN if [ ${INSTALL_DUSK_DEPS} = true ]; then \
  apt-get -y --no-install-recommends install xdg-utils \
  libxpm4 \
  libxrender1 \
  libgtk2.0-0 \
  libnss3 \
  libgconf-2-4 \
  xvfb \
  gtk2-engines-pixbuf \
  xfonts-cyrillic \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-base \
  xfonts-scalable \
  x11-apps && \
  curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i --force-depends google-chrome-stable_current_amd64.deb && \
  apt-get install -yf --no-install-recommends && \
  dpkg -i --force-depends google-chrome-stable_current_amd64.deb && \
  rm google-chrome-stable_current_amd64.deb && \
  curl -O https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  mv chromedriver /usr/local/bin/ && \
  rm chromedriver_linux64.zip \
  ;fi

#########################
# Node / NVM:
#########################

# Check if nvm needs to be installed
ARG INSTALL_NODEJS=false
ENV INSTALL_NODEJS ${INSTALL_NODEJS}

ARG NODEJS_VERSION=stable
ENV NODEJS_VERSION ${NODEJS_VERSION}

ARG NODEJS_VERSION_BACKUP=false
ENV NODEJS_VERSION_BACKUP ${NODEJS_VERSION_BACKUP}

ENV NVM_DIR /home/${LINUX_USER}/.nvm

ARG NODEJS_NVM_VERSION=v0.33.5
ENV NODEJS_NVM_VERSION ${NODEJS_NVM_VERSION}

# Install nvm
USER ${LINUX_USER}

RUN if [ ${INSTALL_NODEJS} = true ]; then \
  #
  # set nvm default environment
  #
  mkdir -p ${NVM_DIR} && \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/${NODEJS_NVM_VERSION}/install.sh | bash && \
  . $NVM_DIR/nvm.sh && \
  nvm install ${NODEJS_VERSION} && \
  nvm use ${NODEJS_VERSION} && \
  nvm alias default ${NODEJS_VERSION} && \
  npm install -g nodemon pm2 eslint gulp mocha node-gyp && \
  #
  # install backup node version
  #
  if [ NODEJS_VERSION_BACKUP != false ]; then \
  nvm install ${NODEJS_VERSION_BACKUP} && \
  nvm alias backup ${NODEJS_VERSION_BACKUP} && \
  npm install -g nodemon pm2 eslint gulp mocha node-gyp \
  ;fi && \
  nvm use default \
  ;fi

# Install nvm setting to bashrc setting
RUN if [ ${INSTALL_NODEJS} = true ]; then \
  echo "" >> ~/.bashrc && \
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bashrc \
  ;fi

# Add nvm binaries to root's .bashrc
USER root

ENV ROOT_NVM_COMMAND "export NVM_DIR=\"${NVM_DIR}\""

RUN if [ ${INSTALL_NODEJS} = true ]; then \
  echo "" >> ~/.bashrc && \
  echo $ROOT_NVM_COMMAND >> ~/.bashrc && \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bashrc \
  ;fi

#########################
# YARN:
#########################

USER ${LINUX_USER}

ARG INSTALL_YARN=false

ARG YARN_VERSION=latest
ENV YARN_VERSION ${YARN_VERSION}

RUN if [ ${INSTALL_NODEJS} = true ] && [ ${INSTALL_YARN} = true ]; then \
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
  #
  # set yarn version
  #
  if [ ${YARN_VERSION} = latest ]; then \
  curl -o- -L https://yarnpkg.com/install.sh | bash \
  ;else \
  curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version ${YARN_VERSION} \
  ;fi && \
  echo "" >> ~/.bashrc && \
  echo 'export PATH=$HOME/yarn/bin:$PATH' >> ~/.bashrc \
  ;fi

# ADD YARN binaries to root's .bashrc
USER root

ENV YARB_PATH /home/${USER}/.yarn
ENV ROOT_YARN_COMMAND "export YARN_DIR=\"/home/${USER}/.yarn\""

RUN if [ ${INSTALL_NODEJS} = true ] && [ ${INSTALL_YARN} = true ]; then \
  echo "" >> ~/.bashrc && \
  echo $ROOT_NVM_COMMAND >> ~/.bashrc && \
  echo 'export PATH="/home/$YARN_DIR/bin:$PATH"' >> ~/.bashrc \
  ;fi


#####################################
# ssh:
#####################################
ARG INSTALL_WORKSPACE_SSH=false

ADD insecure_id_rsa /tmp/id_rsa
ADD insecure_id_rsa.pub /tmp/id_rsa.pub

RUN if [ ${INSTALL_WORKSPACE_SSH} = true ]; then \
  rm -f /etc/service/sshd/down && \
  cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
  && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
  && cat /tmp/id_rsa >> /root/.ssh/id_rsa \
  && rm -f /tmp/id_rsa* \
  && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
  && chmod 400 /root/.ssh/id_rsa \
  && cp -rf /root/.ssh /home/laradock \
  && chown -R laradock:laradock /home/laradock/.ssh \
  ;fi

#####################################
# Crontab
#####################################
# Only links from settings

##############################
# Final step
##############################
USER root

# change user shell as bash by default
RUN chsh -s /bin/bash ${USER}

# Remove unnecessary packages
RUN apt-get -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www

EXPOSE 22 9000 9001

CMD ["php-fpm"]

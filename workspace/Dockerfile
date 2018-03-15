ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}-cli

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL PHP_VERSION=${PHP_VERSION}

##############################
# Set global system env
##############################

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
    locales \
    libz-dev \
    libssl-dev \
    checkinstall && \
    pecl channel-update pecl.php.net

### Install tools

RUN apt-get install -y --no-install-recommends \
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
ARG USER

ENV PUID ${PUID}
ENV PGID ${PGID}
ENV USER ${USER}

RUN groupadd -g ${PGID} ${USER} && \
    useradd -u ${PUID} -g ${USER} -m ${USER}

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
    docker-php-ext-install mcrypt \
;fi

##############################
# PDO MySQL:
##############################

ARG INSTALL_PDO_MYSQL=false

RUN if [ ${INSTALL_PDO_MYSQL} = true ]; then \
    # pdo_mysql extension
    docker-php-ext-install pdo_mysql \
;fi

##############################
# PDO PostgreSQL:
##############################

ARG INSTALL_PDO_PGSQL=false

RUN if [ ${INSTALL_PDO_PGSQL} = true ]; then \
    apt-get install -y --no-install-recommends libpq-dev && \
    # pdo_pgsql extension
    docker-php-ext-install pdo_pgsql \
;fi

##############################
# PDO sqlite:
##############################

ARG INSTALL_PDO_SQLITE=false

RUN if [ ${INSTALL_PDO_SQLITE} = true ]; then \
    apt-get install -y --no-install-recommends libsqlite3-dev && \
    # pdo_sqlite extension
    docker-php-ext-install pdo_sqlite \
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
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd \
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
    docker-php-ext-install ftp \
;fi


#####################################
# XSL:
#####################################

ARG INSTALL_XSL=false

RUN if [ ${INSTALL_XSL} = true ]; then \
    # Install xsl
    apt-get install -y --no-install-recommends libxslt-dev && \
    docker-php-ext-install xsl \
;fi


#####################################
# calendar:
#####################################

ARG INSTALL_CALENDAR=false

RUN if [ ${INSTALL_CALENDAR} = true ]; then \
    # Install calendar
    docker-php-ext-install calendar \
;fi


#####################################
# ctype:
#####################################

ARG INSTALL_CTYPE=false

RUN if [ ${INSTALL_CTYPE} = true ]; then \
    # Install ctype
    docker-php-ext-install ctype \
;fi

#####################################
# DBA:
#####################################

ARG INSTALL_DBA=false

RUN if [ ${INSTALL_DBA} = true ]; then \
    # Install dba
    docker-php-ext-install dba \
;fi

#####################################
# DOM:
#####################################

ARG INSTALL_DOM=false

RUN if [ ${INSTALL_DOM} = true ]; then \
    # Install dom
    docker-php-ext-install dom \
;fi

#####################################
# json:
#####################################

ARG INSTALL_JSON=false

RUN if [ ${INSTALL_JSON} = true ]; then \
    # Install json
    docker-php-ext-install json \
;fi

#####################################
# HASH:
#####################################

ARG INSTALL_HASH=false

RUN if [ ${INSTALL_HASH} = true ]; then \
    # Install ftp
    docker-php-ext-install hash \
;fi

#####################################
# SOCKETS:
#####################################

ARG INSTALL_SOCKETS=false

RUN if [ ${INSTALL_SOCKETS} = true ]; then \
    # Install sockets
    docker-php-ext-install sockets \
;fi


#####################################
# PDO:
#####################################

ARG INSTALL_PDO=false

RUN if [ ${INSTALL_PDO} = true ]; then \
    # Install pdo
    docker-php-ext-install pdo \
;fi

#####################################
# mbstring:
#####################################

ARG INSTALL_MBSTRING=false

RUN if [ ${INSTALL_MBSTRING} = true ]; then \
    # Install mbstring
    docker-php-ext-install mbstring \
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
    docker-php-ext-install imap \
;fi

#####################################
# curl:
#####################################

ARG INSTALL_CURL=false

RUN if [ ${INSTALL_CURL} = true ]; then \
    # Install curl
    apt-get install -y --no-install-recommends libcurl4-openssl-dev && \
    docker-php-ext-install curl \
;fi

#####################################
# fileinfo:
#####################################

ARG INSTALL_FILEINFO=false

RUN if [ ${INSTALL_FILEINFO} = true ]; then \
    # Install fileinfo
    docker-php-ext-install fileinfo \
;fi

#####################################
# gettext:
#####################################

ARG INSTALL_GETTEXT=false

RUN if [ ${INSTALL_GETTEXT} = true ]; then \
    # Install gettext
    docker-php-ext-install gettext \
;fi

#####################################
# iconv:
#####################################

ARG INSTALL_ICONV=false

RUN if [ ${INSTALL_ICONV} = true ]; then \
    # Install iconv
    docker-php-ext-install iconv \
;fi

#####################################
# phar:
#####################################

ARG INSTALL_PHAR=false

RUN if [ ${INSTALL_PHAR} = true ]; then \
    # Install phar
    docker-php-ext-install phar \
;fi

#####################################
# posix:
#####################################

ARG INSTALL_POSIX=false

RUN if [ ${INSTALL_POSIX} = true ]; then \
    # Install posix
    docker-php-ext-install posix \
;fi

#####################################
# pspell:
#####################################

ARG INSTALL_PSPELL=false

RUN if [ ${INSTALL_PSPELL} = true ]; then \
    # Install pspell
    apt-get install -y --no-install-recommends \
        libpspell-dev \
        aspell-en \
        aspell-de && \
    docker-php-ext-configure pspell --with-pspell=/usr && \
    docker-php-ext-install pspell \
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
    docker-php-ext-install readline \
;fi

#####################################
# recode:
#####################################

ARG INSTALL_RECODE=false

RUN if [ ${INSTALL_RECODE} = true ]; then \
    # Install recode
    apt-get install -y --no-install-recommends librecode-dev && \
    docker-php-ext-install recode \
;fi

#####################################
# shmop:
#####################################

ARG INSTALL_SHMOP=false

RUN if [ ${INSTALL_SHMOP} = true ]; then \
    # Install shmop
    docker-php-ext-install shmop \
;fi

#####################################
# simplexml:
#####################################

ARG INSTALL_SIMPLEXML=false

RUN if [ ${INSTALL_SIMPLEXML} = true ]; then \
    # Install simplexml
    apt-get install -y --no-install-recommends libxml2-dev && \
    docker-php-ext-install simplexml \
;fi

#####################################
# snmp:
#####################################

ARG INSTALL_SNMP=false

RUN if [ ${INSTALL_SNMP} = true ]; then \
    # Install snmp
    docker-php-ext-install snmp \
;fi

#####################################
# sysvmsg:
#####################################

ARG INSTALL_SYSVMSG=false

RUN if [ ${INSTALL_SYSVMSG} = true ]; then \
    # Install sysvmsg
    docker-php-ext-install sysvmsg \
;fi

#####################################
# sysvsem:
#####################################

ARG INSTALL_SYSVSEM=false

RUN if [ ${INSTALL_SYSVSEM} = true ]; then \
    # Install sysvsem
    docker-php-ext-install sysvsem \
;fi

#####################################
# sysvshm:
#####################################

ARG INSTALL_SYSVSHM=false

RUN if [ ${INSTALL_SYSVSHM} = true ]; then \
    # Install sysvshm
    docker-php-ext-install sysvshm \
;fi

#####################################
# bz2:
#####################################

ARG INSTALL_BZ2=false

RUN if [ ${INSTALL_BZ2} = true ]; then \
    apt-get install -y --no-install-recommends libbz2-dev && \
    docker-php-ext-install bz2 \
;fi

#####################################
# enchant:
#####################################

ARG INSTALL_ENCHANT=false

RUN if [ ${INSTALL_ENCHANT} = true ]; then \
    apt-get install -y --no-install-recommends libenchant-dev && \
    docker-php-ext-install enchant \
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
    docker-php-ext-install tidy \
;fi

#####################################
# wddx:
#####################################

ARG INSTALL_WDDX=false

RUN if [ ${INSTALL_WDDX} = true ]; then \
    # Install wddx
    docker-php-ext-install wddx \
;fi

#####################################
# xml:
#####################################

ARG INSTALL_XML=false

RUN if [ ${INSTALL_XML} = true ]; then \
    # Install xml
    apt-get install -y --no-install-recommends libxml2-dev && \
    docker-php-ext-install xml \
;fi

#####################################
# xmlreader:
#####################################

ARG INSTALL_XMLREADER=false

RUN if [ ${INSTALL_XMLREADER} = true ]; then \
    # Install xmlreader
    apt-get install -y libxml2-dev && \
    docker-php-ext-install xmlreader \
;fi

#####################################
# xmlrpc:
#####################################

ARG INSTALL_XMLRPC=false

RUN if [ ${INSTALL_XMLRPC} = true ]; then \
    # Install xmlrpc
    apt-get install -y --no-install-recommends libxml2-dev && \
    docker-php-ext-install xmlrpc \
;fi

#####################################
# xmlwriter:
#####################################

ARG INSTALL_XMLWRITER=false

RUN if [ ${INSTALL_XMLWRITER} = true ]; then \
    # Install xmlwriter
    apt-get install -y --no-install-recommends libxml2-dev && \
    docker-php-ext-install xmlwriter \
;fi


#####################################
# SOAP:
#####################################

ARG INSTALL_SOAP=false

RUN if [ ${INSTALL_SOAP} = true ]; then \
    # Install the soap extension
    docker-php-ext-install soap \
;fi

#####################################
# pgsql
#####################################

ARG INSTALL_PGSQL=false

RUN if [ ${INSTALL_PGSQL} = true ]; then \
    apt-get install -y --no-install-recommends libpq-dev && \
    # Install the pgsql extension
    docker-php-ext-install pgsql \
;fi

#####################################
# pgsql client
#####################################

ARG INSTALL_PG_CLIENT=false
ENV INSTALL_PG_CLIENT ${INSTALL_PG_CLIENT}

RUN if [ ${INSTALL_PG_CLIENT} = true ]; then \
    # Install the pgsql client
    apt-get install -yf postgresql-client \
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
    # Install the zip extension
    docker-php-ext-install zip \
;fi

#####################################
# bcmath:
#####################################

ARG INSTALL_BCMATH=false

RUN if [ ${INSTALL_BCMATH} = true ]; then \
    # Install the bcmath extension
    docker-php-ext-install bcmath \
;fi

#####################################
# GMP (GNU Multiple Precision):
#####################################

ARG INSTALL_GMP=false

RUN if [ ${INSTALL_GMP} = true ]; then \
    # Install the GMP extension
	apt-get install -y --no-install-recommends libgmp-dev && \ 
    docker-php-ext-install gmp \
;fi

#####################################
# PHP Memcached:
#####################################

ARG INSTALL_MEMCACHED=false

RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
    apt-get install -y --no-install-recommends libmemcached-dev && \
    # Install the php memcached extension
    curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" && \
    mkdir -p memcached && \
    tar -C memcached -zxvf /tmp/memcached.tar.gz --strip 1 && \
    ( \
        cd memcached \
        && phpize \
        && ./configure \
        && make -j$(nproc) \
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
    docker-php-ext-install exif \
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
    docker-php-ext-install opcache \
;fi

#####################################
# Mysqli Modifications:
#####################################

ARG INSTALL_MYSQLI=false

RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install mysqli \
;fi

#####################################
# Tokenizer Modifications:
#####################################

ARG INSTALL_TOKENIZER=false

RUN if [ ${INSTALL_TOKENIZER} = true ]; then \
    docker-php-ext-install tokenizer \
;fi

#####################################
# Human Language and Character Encoding Support:
#####################################

ARG INSTALL_INTL=false

RUN if [ ${INSTALL_INTL} = true ]; then \
    # Install intl and requirements
    apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl \
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
    docker-php-ext-install ldap \
;fi

#####################################
# pcntl:
#####################################

ARG INSTALL_PCNTL=false

RUN if [ ${INSTALL_PCNTL} = true ]; then \
    docker-php-ext-install pcntl && \
    docker-php-ext-enable pcntl \
;fi

#####################################
# SQL SERVER:
#####################################
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
        && ./configure && make && make install \
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
    ninja -C out.gn/x64.release/ && \
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
    cd /tmp && \
    git clone https://github.com/phpv8/v8js.git && \
    cd v8js && \
    phpize && \
    ./configure --with-v8js=/opt/v8 LDFLAGS="-lstdc++" && \
    make && \
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
# PHP Composer:
#####################################

USER root

# Install composer and add its bin to PATH
RUN cd /tmp && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# source the bash
RUN . ~/.bashrc

# install prestissimo to speed up composer packages installation

COPY ./composer.json /home/${USER}/.composer/composer.json

RUN chown -R ${USER}:${USER} /home/${USER}/.composer

USER ${USER}

RUN echo "export PATH=${PATH}:/usr/local/bin:~/.composer/vendor/bin" >> ~/.bashrc && \
    . ~/.bashrc

RUN composer global install && \
    composer global --verbose require "hirak/prestissimo"

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
USER ${USER}

RUN echo "" >> ~/.bashrc && \
    echo 'export PATH="/var/www/vendor/bin:$PATH"' >> ~/.bashrc

#####################################
# Laravel Envoy:
#####################################
USER ${USER}

ARG INSTALL_LARAVEL_ENVOY=false

RUN if [ ${INSTALL_LARAVEL_ENVOY} = true ]; then \
    # Install the Laravel Envoy
    composer global require "laravel/envoy=~1.0" \
;fi

#####################################
# Laravel Installer:
#####################################
USER ${USER}

ARG INSTALL_LARAVEL_INSTALLER=false

RUN if [ ${INSTALL_LARAVEL_INSTALLER} = true ]; then \
    # Install the Laravel Installer
	echo "" >> ~/.bashrc && \
	echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.bashrc && \
    composer global require "laravel/installer" \
;fi

#####################################
# Deployer:
#####################################
USER ${USER}

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
  pip install --upgrade pip && \
  pip install --upgrade virtualenv \
;fi

RUN if [ ${INSTALL_PYTHON3} = true ]; then \
    if [ `echo ${PHP_VERSION} | cut -c1-3` = 7.2 ]; then \
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
    pip3 install --upgrade pip && \
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
ARG NODEJS_VERSION=stable
ENV NODEJS_VERSION ${NODEJS_VERSION}

ARG NODEJS_VERSION_BACKUP=false
ENV NODEJS_VERSION_BACKUP ${NODEJS_VERSION_BACKUP}

ARG NVM_DIR=/home/docker/.nvm
ENV NVM_DIR /home/${USER}/.nvm

ARG YARN_VERSION=latest
ENV YARN_VERSION ${NODEJS_YARN_VERSION}

ARG NODEJS_NVM_VERSION=v0.33.5
ENV NODEJS_NVM_VERSION ${NODEJS_NVM_VERSION}

# Install nvm
USER ${USER}

##
# install backup node version
##

##
# set nvm default environment
##
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/${NODEJS_NVM_VERSION}/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install ${NODEJS_VERSION} && \
    nvm use ${NODEJS_VERSION} && \
    nvm alias default ${NODEJS_VERSION} && \
    npm install -g nodemon pm2 eslint gulp node-inspector mocha node-gyp && \
    if [ NODEJS_VERSION_BACKUP != false ]; then \
    nvm install ${NODEJS_VERSION_BACKUP} && \
    nvm alias backup ${NODEJS_VERSION_BACKUP} && \
    npm install -g nodemon pm2 eslint gulp node-inspector mocha node-gyp \
    ;fi && \
    nvm use default

# Install nvm setting to bashrc setting
RUN echo "" >> ~/.bashrc && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bashrc

# RUN if [ NODEJS_VERSION_BACKUP != false ]; then \
#     nvm install ${NODEJS_VERSION_BACKUP} && \
#     nvm alias ${NODEJS_VERSION_BACKUP} backup && \
#     npm install -g nodemon pm2 eslint gulp node-inspector mocha node-gyp \
# ;fi

# Add nvm binaries to root's .bashrc
USER root

ENV ROOT_NVM_COMMAND "export NVM_DIR=\"${NVM_DIR}\""

RUN echo "" >> ~/.bashrc && \
    echo $ROOT_NVM_COMMAND >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bashrc \
;fi

#########################
# YARN:
#########################

USER ${USER}

# ARG YARN_VERSION=latest
# ENV YARN_VERSION ${NODEJS_YARN_VERSION}


RUN [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    curl -o- -L https://yarnpkg.com/install.sh | bash && \
    echo "" >> ~/.bashrc && \
    echo 'export PATH=$HOME/yarn/bin:$PATH' >> ~/.bashrc

# ADD YARN binaries to root's .bashrc

USER root

ENV YARB_PATH /home/${USER}/.yarn
ENV ROOT_YARN_COMMAND "export YARN_DIR=\"/home/${USER}/.yarn\""

RUN echo "" >> ~/.bashrc && \
    echo $ROOT_NVM_COMMAND >> ~/.bashrc && \
    echo 'export PATH="/home/$YARN_DIR/bin:$PATH"' >> ~/.bashrc


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

# Clean up
USER root

RUN apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

# Set default work directory
WORKDIR /var/www
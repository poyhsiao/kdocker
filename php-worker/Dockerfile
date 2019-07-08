ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL PHP_VERSION=${PHP_VERSION}-alpine

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

##############################
# Install require libs and tools
##############################

RUN apk update && \
    apk upgrade && \
    apk add --update --virtual .buildenv \
    build-base \
    autoconf \
    libmemcached-dev \
    libmcrypt-dev \
    libxml2-dev \
    zlib-dev \
    cyrus-sasl-dev \
    libgsasl-dev \
    sqlite-dev \
    curl-dev

##############################
# Required packages
##############################

RUN apk --update add netcat-openbsd \
    wget \
    curl \
    git \
    supervisor

##############################
# Basic php ext
##############################

ARG PHP_VERSION=7.1
ENV PHP_VERSION ${PHP_VERSION}

## Update pecl channel
RUN pecl channel-update pecl.php.net

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    pdo_sqlite

#####################################
#
# mcrypt:
#
# only availble under PHP 7.0
#####################################

RUN if [ `echo ${PHP_VERSION} | cut -c1-3` = 7.0 ]; then \
    docker-php-ext-install mcrypt \
;fi

#####################################
# Mysqli Modifications:
#####################################

ARG INSTALL_MYSQLI=false

RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install mysqli \
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
# pcntl:
#####################################

ARG INSTALL_PCNTL=false

RUN if [ ${INSTALL_PCNTL} = true ]; then \
    docker-php-ext-install pcntl && \
    docker-php-ext-enable pcntl \
;fi

#####################################
# json:
#####################################

ARG INSTALL_JSON=false

RUN if [ ${INSTALL_JSON} = true ]; then \
    # Install json
    docker-php-ext-install json \
;fi

##############################
# PHP gmp ext
##############################

ARG INSTALL_INTL=false

RUN if [ ${INSTALL_INTL} = true ]; then \
    apk --update add icu-dev && \
    docker-php-ext-install intl \
;fi

#####################################
# curl:
#####################################

ARG INSTALL_CURL=false

RUN if [ ${INSTALL_CURL} = true ]; then \
    # Install curl
    docker-php-ext-install curl \
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
# Tokenizer Modifications:
#####################################

ARG INSTALL_TOKENIZER=false

RUN if [ ${INSTALL_TOKENIZER} = true ]; then \
    docker-php-ext-install tokenizer \
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
# Exif:
#####################################

ARG INSTALL_EXIF=false

RUN if [ ${INSTALL_EXIF} = true ]; then \
    # Enable Exif PHP extentions requirements
    docker-php-ext-install exif \
;fi

#####################################
# xml:
#####################################

ARG INSTALL_XML=false

RUN if [ ${INSTALL_XML} = true ]; then \
    # Install xml
    docker-php-ext-install xml \
;fi

##############################
# PHP gmp ext
##############################

ARG INSTALL_GMP=false

RUN if [ ${INSTALL_GMP} = true ]; then \
    apk --update add gmp-dev && \
    docker-php-ext-install gmp \
;fi

##############################
# PHP pdo_pgsql ext
##############################

ARG INSTALL_PGSQL=false

RUN if [ ${INSTALL_PGSQL} = true ]; then \
    apk --update add postgresql-dev && \
    docker-php-ext-install pdo_pgsql \
;fi

##############################
# PHP Redis ext
##############################

ARG INSTALL_PHPREDIS=false

RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
    printf "\n" | pecl install -o -f redis && \
    rm -rf /tmp/pear && \
    docker-php-ext-enable redis \
;fi

##############################
# Memcached ext
##############################

ARG INSTALL_MEMCACHED=false
ARG MEMCACHED_VERSION=3.0.4

RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
    apk --update add libmemcached-libs && \
    # Install the php memcached extension
    curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" && \
    mkdir -p memcached && \
    tar -C memcached -zxvf /tmp/memcached.tar.gz --strip 1 && \
    ( \
        cd memcached && \
        phpize && \
        ./configure && \
        make -j$(nproc) && \
        make test && \
        make install \
    ) && \
    rm -r memcached && \
    rm /tmp/memcached.tar.gz && \
    docker-php-ext-enable memcached \
;fi

##############################
# Clear apk packages cache
##############################

RUN apk del .buildenv && \
    rm /var/cache/apk/* && \
    rm -rf /tmp/* && \
    mkdir -p /var/www

#
#--------------------------------------------------------------------------
# Optional Supervisord Configuration
#--------------------------------------------------------------------------
#
# Modify the ./supervisor.conf file to match your App's requirements.
# Make sure you rebuild your container with every change.
#

# COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]

#
#--------------------------------------------------------------------------
# Optional Software's Installation
#--------------------------------------------------------------------------
#
# If you need to modify this image, feel free to do it right here.
#
    # -- Your awesome modifications go here -- #

#
#--------------------------------------------------------------------------
# Check PHP version
#--------------------------------------------------------------------------
#

RUN php -v | head -n 1 | grep -q "PHP 7."

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

WORKDIR /etc/supervisor/conf.d/
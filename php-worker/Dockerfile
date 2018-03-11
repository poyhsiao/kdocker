ARG PHP_VERSION=7.1
FROM php:${PHP_VERSION}-alpine

MAINTAINER Kim Hsiao <white.shopping@gmail.com>

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
# Install require libs and tools
##############################

RUN apk update && \
    apk upgrade && \
    apk --update add build-base \
    autoconf \
    libmemcached-dev \
    libmcrypt-dev \
    libxml2-dev \
    zlib-dev \
    cyrus-sasl-dev \
    libgsasl-dev \
    sqlite-dev \
    curl-dev \
    icu-dev \
    gmp-dev \
    netcat-openbsd \
    wget \
    curl \
    git \
    supervisor

##############################
# Basic php ext
##############################

RUN docker-php-ext-install \
    mysqli \
    mbstring \
    intl \
    json \
    curl \
    iconv \
    pdo \
    pdo_mysql \
    pdo_sqlite \
    mcrypt \
    tokenizer \
    bcmath \
    gmp \
    exif \
    xml

##############################
# Memcached ext
##############################

# ARG INSTALL_MEMCACHED=false
# ENV INSTALL_MEMCACHED ${INSTALL_MEMCACHED}

# RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
#     pecl channel-update pecl.php.net && \
#     pecl install memcached && \
#     docker-php-ext-install memecached \
# ;fi

##############################
# PostgreSQL drivers
##############################

ARG INSTALL_PGSQL=false
ENV INSTALL_PGSQL ${INSTALL_PGSQL}

RUN if [ ${INSTALL_PGSQL} ]; then \
    apk --update add postgresql-dev && \
    docker-php-ext-install pdo_pgsql \
;fi

##############################
# Clear apk packages cache
##############################

RUN rm /var/cache/apk/* && \
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
FROM phusion/baseimage:latest

MAINTAINER Kim Hsiao <white.shopping@gmail.com>

##############################
# Set global system env
##############################
RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
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
# Set PHP environment
##############################

# Add PHP ppa
USER root

RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

ARG PHP_VERSION
ENV PHP_PREFIX php${PHP_VERSION}

# Install "PHP Extensions", "Libraries" and "System required tools"
USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
        ${PHP_PREFIX}-cli \
        ${PHP_PREFIX}-common \
        ${PHP_PREFIX}-curl \
        ${PHP_PREFIX}-intl \
        ${PHP_PREFIX}-json \
        ${PHP_PREFIX}-xml \
        ${PHP_PREFIX}-mbstring \
        ${PHP_PREFIX}-mcrypt \
        ${PHP_PREFIX}-mysql \
        ${PHP_PREFIX}-pgsql \
        ${PHP_PREFIX}-sqlite \
        ${PHP_PREFIX}-sqlite3 \
        ${PHP_PREFIX}-zip \
        ${PHP_PREFIX}-bcmath \
        ${PHP_PREFIX}-memcached \
        ${PHP_PREFIX}-gd \
        ${PHP_PREFIX}-dev \
        build-essential \
        unzip \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        sqlite3 \
        git \
        curl \
        vim \
        nano \
        postgresql-client && \
    pecl channel-update pecl.php.net && \
    apt-get clean

#####################################
# SOAP:
#####################################
USER root

ARG INSTALL_SOAP=false
ENV INSTALL_SOAP ${INSTALL_SOAP}

RUN if [ ${INSTALL_SOAP} = true ]; then \
  # Install the PHP SOAP extension
  apt-get -y install libxml2-dev ${PHP_PREFIX}-soap \
;fi

#####################################
# LDAP:
#####################################

ARG INSTALL_LDAP=false
ENV INSTALL_LDAP ${INSTALL_LDAP}

RUN if [ ${INSTALL_LDAP} = true ]; then \
    apt-get install -y libldap2-dev && \
    apt-get install -y ${PHP_PREFIX}-ldap \
;fi

#####################################
# IMAP:
#####################################

ARG INSTALL_IMAP=false
ENV INSTALL_IMAP ${INSTALL_IMAP}

RUN if [ ${INSTALL_IMAP} = true ]; then \
    apt-get install -y ${PHP_PREFIX}-imap \
;fi


#####################################
# xDebug:
#####################################

ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    # Load the xdebug extension only with phpunit commands
    apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages ${PHP_PREFIX}-xdebug && \
    sed -i 's/^;//g' /etc/php/${PHP_VERSION}/cli/conf.d/20-xdebug.ini && \
    echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/vendor/bin/phpunit'" >> ~/.bashrc \
;fi
# ADD for REMOTE debugging
COPY ./xdebug.ini /etc/php/${PHP_VERSION}/cli/conf.d/xdebug.ini

#####################################
# MongoDB:
#####################################

# Check if Mongo needs to be installed
ARG INSTALL_MONGO=false
ENV INSTALL_MONGO ${INSTALL_MONGO}
RUN if [ ${INSTALL_MONGO} = true ]; then \
    # Install the mongodb extension
    pecl -q install mongodb && \
    echo "extension=mongodb.so" >> /etc/php/${PHP_VERSION}/mods-available/mongodb.ini && \
    ln -s /etc/php/${PHP_VERSION}/mods-available/mongodb.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-mongodb.ini \
;fi

#####################################
# AMQP:
#####################################

# Check if Mongo needs to be installed
ARG INSTALL_AMQP=false
ENV INSTALL_AMQP ${INSTALL_AMQP}
RUN if [ ${INSTALL_AMQP} = true ]; then \
    apt-get install librabbitmq-dev -y && \
    # Install the mongodb extension
    pecl -q install amqp && \
    echo "extension=amqp.so" >> /etc/php/${PHP_VERSION}/mods-available/amqp.ini && \
    ln -s /etc/php/${PHP_VERSION}/mods-available/amqp.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-amqp.ini \
;fi

#####################################
# PHP REDIS EXTENSION FOR PHP 7.1
#####################################

ARG INSTALL_PHPREDIS=false
ENV INSTALL_PHPREDIS ${INSTALL_PHPREDIS}
RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
    # Install Php Redis extension
    printf "\n" | pecl -q install -o -f redis && \
    echo "extension=redis.so" >> /etc/php/${PHP_VERSION}/mods-available/redis.ini && \
    phpenmod redis \
;fi

#####################################
# Swoole EXTENSION FOR PHP 7
#####################################

ARG INSTALL_SWOOLE=false
RUN if [ ${INSTALL_SWOOLE} = true ]; then \
    # Install Php Swoole Extension
    pecl -q install swoole && \
    echo "extension=swoole.so" >> /etc/php/${PHP_VERSION}/mods-available/swoole.ini && \
    ln -s /etc/php/${PHP_VERSION}/mods-available/swoole.ini /etc/php/${PHP_VERSION}/cli/conf.d/20-swoole.ini \
;fi

#####################################
# PHP Composer:
#####################################

# Install composer and add its bin to PATH
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

# source the bash
RUN . ~/.bashrc

#####################################
# Drush:
#####################################
USER root

ENV DRUSH_VERSION 8.1.2
ARG INSTALL_DRUSH=false
ENV INSTALL_DRUSH ${INSTALL_DRUSH}

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
ENV INSTALL_DRUPAL_CONSOLE ${INSTALL_DRUPAL_CONSOLE}

RUN if [ ${INSTALL_DRUPAL_CONSOLE} = true ]; then \
    apt-get -y install mysql-client && \
    curl https://drupalconsole.com/installer -L -o drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal \
;fi

#####################################
# PHP Aerospike:
#####################################
USER root

ARG INSTALL_AEROSPIKE=false
ENV INSTALL_AEROSPIKE ${INSTALL_AEROSPIKE}

# Copy aerospike configration for remote debugging
COPY ./aerospike.ini /etc/php/${PHP_VERSION}/cli/conf.d/aerospike.ini

RUN if [ ${INSTALL_AEROSPIKE} = true ]; then \
    # Install the php aerospike extension
    curl -L -o /tmp/aerospike-client-php.tar.gz "https://github.com/aerospike/aerospike-client-php/archive/master.tar.gz" \
    && mkdir -p aerospike-client-php \
    && tar -C aerospike-client-php -zxvf /tmp/aerospike-client-php.tar.gz --strip 1 \
    && ( \
        cd aerospike-client-php/src \
        && phpize \
        && ./build.sh \
        && make install \
    ) \
    && rm /tmp/aerospike-client-php.tar.gz \
;fi

RUN if [ ${INSTALL_AEROSPIKE} = false ]; then \
    rm /etc/php/${PHP_VERSION}/cli/conf.d/aerospike.ini \
;fi

#####################################
# PHP V8JS:
#####################################
USER root

ARG INSTALL_V8JS=false
ENV INSTALL_V8JS ${INSTALL_V8JS}

ARG V8JS_VERSION=archived
ENV V8JS_VERSION ${V8JS_VERSION}

RUN if [ ${INSTALL_V8JS} = true ]; then \
    # Install the php V8JS extension
    add-apt-repository -y ppa:pinepain/libv8-${V8JS_VERSION} && \
    apt-get update -y && \
    # && apt-get install -y ${PHP_PREFIX}-xml ${PHP_PREFIX}-dev php-pear libv8-${V8JS_VERSION} \
    apt-get install -y libv8-${V8JS_VERSION} && \
    pecl install v8js && \
    echo "extension=v8js.so" >> /etc/php/${PHP_VERSION}/cli/php.ini \
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
ENV INSTALL_LARAVEL_ENVOY ${INSTALL_LARAVEL_ENVOY}

RUN if [ ${INSTALL_LARAVEL_ENVOY} = true ]; then \
    # Install the Laravel Envoy
    composer global require "laravel/envoy=~1.0" \
;fi

#####################################
# Laravel Installer:
#####################################
USER ${USER}

ARG INSTALL_LARAVEL_INSTALLER=false
ENV INSTALL_LARAVEL_INSTALLER ${INSTALL_LARAVEL_INSTALLER}

RUN if [ ${INSTALL_LARAVEL_INSTALLER} = true ]; then \
    # Install the Laravel Installer
	echo "" >> ~/.bashrc && \
	echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.bashrc \
	&& composer global require "laravel/installer" \
;fi

#####################################
# Deployer:
#####################################
USER ${USER}

ARG INSTALL_DEPLOYER=false
ENV INSTALL_DEPLOYER ${INSTALL_DEPLOYER}

RUN if [ ${INSTALL_DEPLOYER} = true ]; then \
    # Install the Deployer
    composer global require "deployer/deployer" \
;fi

#####################################
# Linuxbrew:
#####################################
USER root

ARG INSTALL_LINUXBREW=false
ENV INSTALL_LINUXBREW ${INSTALL_LINUXBREW}

RUN if [ ${INSTALL_LINUXBREW} = true ]; then \
    # Preparation
    apt-get upgrade -y && \
    apt-get install -y build-essential make cmake scons curl git \
        ruby autoconf automake autoconf-archive \
        gettext libtool flex bison \
        libbz2-dev libcurl4-openssl-dev \
        libexpat-dev libncurses-dev && \

    # Install the Linuxbrew
    git clone --depth=1 https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew && \
    echo "" >> ~/.bashrc && \
    echo 'export PKG_CONFIG_PATH"=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH"' >> ~/.bashrc && \

    # Setup linuxbrew
    echo 'export LINUXBREWHOME="$HOME/.linuxbrew"' >> ~/.bashrc && \
    echo 'export PATH="$LINUXBREWHOME/bin:$PATH"' >> ~/.bashrc && \
    echo 'export MANPATH="$LINUXBREWHOME/man:$MANPATH"' >> ~/.bashrc && \
    echo 'export PKG_CONFIG_PATH="$LINUXBREWHOME/lib64/pkgconfig:$LINUXBREWHOME/lib/pkgconfig:$PKG_CONFIG_PATH"' >> ~/.bashrc && \
    echo 'export LD_LIBRARY_PATH="$LINUXBREWHOME/lib64:$LINUXBREWHOME/lib:$LD_LIBRARY_PATH"' >> ~/.bashrc \
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
        apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages wget apt-transport-https curl freetds-common libsybdb5 freetds-bin unixodbc unixodbc-dev && \

    #####################################
    #  The following steps were taken from
    #  Microsoft's github account:
    #  https://github.com/Microsoft/msphpsql/wiki/Dockerfile-for-getting-pdo_sqlsrv-for-PHP-7.0-on-Debian-in-3-ways
    #####################################

    # Add PHP 7 repository
    # for Debian jessie
    # And System upgrade
        cd / && \
        echo "deb http://packages.dotdeb.org jessie all" \
        | tee /etc/apt/sources.list.d/dotdeb.list \
        && wget -qO- https://www.dotdeb.org/dotdeb.gpg \
        | apt-key add - \
        && apt-get update -yqq \
        && apt-get upgrade -qq && \

    # Install UnixODBC
    # Compile odbc_config as it is not part of unixodbc package
        cd / && \
        apt-get update -yqq && \
        apt-get install -y whiptail \
        unixodbc libgss3 odbcinst devscripts debhelper dh-exec dh-autoreconf libreadline-dev libltdl-dev \
        && dget -u -x http://http.debian.net/debian/pool/main/u/unixodbc/unixodbc_2.3.1-3.dsc \
        && cd unixodbc-*/ \
        && ./configure && make && make install \
        && cp -v ./exe/odbc_config /usr/local/bin/ && \

    # Fake uname for install.sh
        printf '#!/bin/bash\nif [ "$*" == "-p" ]; then echo "x86_64"; else /bin/uname "$@"; fi' \
        | tee /usr/local/bin/uname \
        && chmod +x /usr/local/bin/uname && \

    # Microsoft ODBC Driver 13 for Linux
    # Note: There's a copy of this tar on my hubiC
        cd / && \
        wget -nv -O msodbcsql-13.0.0.0.tar.gz \
        "https://meetsstorenew.blob.core.windows.net/contianerhd/Ubuntu%2013.0%20Tar/msodbcsql-13.0.0.0.tar.gz?st=2016-10-18T17%3A29%3A00Z&se=2022-10-19T17%3A29%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=cDwPfrouVeIQf0vi%2BnKt%2BzX8Z8caIYvRCmicDL5oknY%3D" \
        && tar -xf msodbcsql-13.0.0.0.tar.gz \
        && cd msodbcsql-*/ \
        && ldd lib64/libmsodbcsql-13.0.so.0.0 \
        && ./install.sh install --accept-license \
        && ls -l /opt/microsoft/msodbcsql/ \
        && odbcinst -q -d -n "ODBC Driver 13 for SQL Server" && \


    #####################################
    # Install sqlsrv y pdo_sqlsrv
    # extensions:
    #####################################

    pecl install sqlsrv-4.0.8 && \
    pecl install pdo_sqlsrv-4.0.8 && \

    #####################################
    # Set locales for the container
    #####################################

    apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && echo "extension=sqlsrv.so" > /etc/php/7.1/cli/conf.d/20-sqlsrv.ini \
    && echo "extension=pdo_sqlsrv.so" > /etc/php/7.1/cli/conf.d/20-pdo_sqlsrv.ini \
;fi

#####################################
# Minio:
#####################################
USER root

ARG INSTALL_MC=false
ENV INSTALL_MC ${INSTALL_MC}

COPY mc/config.json /root/.mc/config.json

RUN if [ ${INSTALL_MC} = true ]; then\
    curl -fsSL -o /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && \
    chmod +x /usr/local/bin/mc \
;fi

#####################################
# Image optimizers:
#####################################
USER root

ARG INSTALL_IMAGE_OPTIMIZERS=false
ENV INSTALL_IMAGE_OPTIMIZERS ${INSTALL_IMAGE_OPTIMIZERS}

RUN if [ ${INSTALL_IMAGE_OPTIMIZERS} = true ]; then \
    apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages jpegoptim optipng pngquant gifsicle && \
    if [ ${INSTALL_NODE} = true ]; then \
        . ~/.bashrc && npm install -g svgo \
    ;fi\
;fi

#####################################
# Symfony:
#####################################
USER root

ARG INSTALL_SYMFONY=false
ENV INSTALL_SYMFONY ${INSTALL_SYMFONY}

RUN if [ ${INSTALL_SYMFONY} = true ]; then \
  mkdir -p /usr/local/bin \
  && curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
  && chmod a+x /usr/local/bin/symfony \

  #  Symfony 3 alias
  && echo 'alias dev="php bin/console -e=dev"' >> ~/.bashrc \
  && echo 'alias prod="php bin/console -e=prod"' >> ~/.bashrc \

  #  Symfony 2 alias
  #  && echo 'alias dev="php app/console -e=dev"' >> ~/.bashrc \
  #  && echo 'alias prod="php app/console -e=prod"' >> ~/.bashrc \
;fi

#####################################
# PYTHON:
#####################################
USER root

ARG INSTALL_PYTHON=false
ENV INSTALL_PYTHON ${INSTALL_PYTHON}

ARG INSTALL_PYTHON3=false
ENV INSTALL_PYTHON3 ${INSTALL_PYTHON3}

ARG PYTHON3_VERSION=3.6
ENV PYTHON3_VERSION ${PYTHON3_VERSION}

RUN if [ ${INSTALL_PYTHON} = true ]; then \
  apt-get update && \
  apt-get -y install python python-pip python-dev && \
  pip install --upgrade pip && \
  pip install --upgrade virtualenv \
;fi

RUN if [ ${INSTALL_PYTHON3} = true ]; then \
    add-apt-repository ppa:jonathonf/python-3.6 && \
    apt-get update && \
    apt-get -y install libpython${PYTHON3_VERSION} libpython${PYTHON3_VERSION}-dev python${PYTHON3_VERSION} python3-pip python${PYTHON3_VERSION}-dev && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade virtualenv \
;fi

#####################################
# ImageMagick:
#####################################
USER root

ARG INSTALL_IMAGEMAGICK=false
ENV INSTALL_IMAGEMAGICK ${INSTALL_IMAGEMAGICK}

RUN if [ ${INSTALL_IMAGEMAGICK} = true ]; then \
    apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages imagemagick php-imagick \
;fi

#####################################
# Terraform:
#####################################
USER root

ARG INSTALL_TERRAFORM=false
ENV INSTALL_TERRAFORM ${INSTALL_TERRAFORM}

RUN if [ ${INSTALL_TERRAFORM} = true ]; then \
    curl -O https://releases.hashicorp.com/terraform/0.10.6/terraform_0.10.6_linux_amd64.zip && \
    unzip terraform_0.10.6_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    rm terraform_0.10.6_linux_amd64.zip \
;fi

#####################################
# pgsql client
#####################################
USER root

ARG INSTALL_PG_CLIENT=false
ENV INSTALL_PG_CLIENT ${INSTALL_PG_CLIENT}

RUN if [ ${INSTALL_PG_CLIENT} = true ]; then \
    # Install the pgsql clint
    apt-get -y install postgresql-client \
;fi

#####################################
# Dusk Dependencies:
#####################################
USER root

ARG CHROME_DRIVER_VERSION=stable
ENV CHROME_DRIVER_VERSION ${CHROME_DRIVER_VERSION}

ARG INSTALL_DUSK_DEPS=false
ENV INSTALL_DUSK_DEPS ${INSTALL_DUSK_DEPS}

RUN if [ ${INSTALL_DUSK_DEPS} = true ]; then \
  apt-get -y install xdg-utils \
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
    apt-get -y -f install && \
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

ARG YARN_DIR=/home/docker/.yarn
ENV YARN_DIR=/home/${USER}/.yarn

RUN [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    curl -o- -L https://yarnpkg.com/install.sh | bash && \
    echo "" >> ~/.bashrc && \
    echo 'export PATH=$HOME/yarn/bin:$PATH' >> ~/.bashrc

# ADD YARN binaries to root's .bashrc

USER root

ENV YARB_PATH /home/${USER}/.yarn
ENV ROOT_YARN_COMMAND "export YARN_DIR=\"${YARN_DIR}\""

RUN echo "" >> ~/.bashrc && \
    echo $ROOT_NVM_COMMAND >> ~/.bashrc && \
    echo 'export PATH="$YARN_DIR/bin:$PATH"' >> ~/.bashrc


#####################################
# ssh:
#####################################
ARG INSTALL_WORKSPACE_SSH=false
ENV INSTALL_WORKSPACE_SSH ${INSTALL_WORKSPACE_SSH}

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
USER root

COPY ./crontab /etc/cron.d
RUN chmod -R 644 /etc/cron.d

##############################
# Final step
##############################

# Clean up
USER root

RUN apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

# Set default work directory
WORKDIR /var/www
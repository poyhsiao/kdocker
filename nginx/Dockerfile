# syntax = docker/dockerfile:experimental
ARG NGINX_VERSION=1.23
FROM nginx:${NGINX_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL NGINX_VERSION=${NGINX_VERSION}

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

# ADD nginx.conf /etc/nginx/

# If you're in China, or you need to change sources, will be set CHANGE_SOURCE to true in .env.

ARG CHANGE_SOURCE=false
RUN if [ ${CHANGE_SOURCE} = true ]; then \
  # Change application source from dl-cdn.alpinelinux.org to aliyun source
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
  ;fi

RUN apk update \
  apk upgrade && \
  apk add --no-cache \
  bash \
  curl \
  logrotate \
  openssl

RUN if [ ${NGINX_VERSION} = "1.13" ]; then \
  adduser -D -H -u 82 -s /bin/bash www-data \
  ;else \
  adduser -u 82 -D -S -G www-data www-data \
  ;fi

ARG PHP_UPSTREAM_CONTAINER=workspace
ARG PHP_UPSTREAM_PORT=9000

# Create messages file for logrotate
RUN touch /var/log/messages

# Copy logrotate config file
COPY logrotate/nginx /etc/logrotate.d/

# Set upstream conf and remove the default conf
RUN echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
  && rm /etc/nginx/conf.d/default.conf

EXPOSE 80 443 2018

CMD ["nginx"]

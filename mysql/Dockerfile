# syntax = docker/dockerfile:experimental

ARG MYSQL_VERSION=latest
FROM mysql:${MYSQL_VERSION}-debian

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL MYSQ_VERSION=${MYSQL_VERSION}

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

##############################
# Update system with bug-fixed
##############################
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER mysql

EXPOSE 3306

CMD [ "mysqld" ]


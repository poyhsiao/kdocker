# syntax = docker/dockerfile:experimental
ARG MONGO_VERSION=3.6
FROM mongo:${MONGO_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL MONGO_VERSION=${MONGO_VERSION}

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

EXPOSE 27017

CMD [ "mongod" ]

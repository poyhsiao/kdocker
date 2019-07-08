ARG RABBITMQ_VERSION=3.7
FROM rabbitmq:${RABBITMQ_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL RABBITMQ_VERSION=${RABBITMQ_VERSION}

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
RUN apk update && \
    apk upgrade

RUN rabbitmq-plugins enable --offline rabbitmq_management

EXPOSE 5672 15671 15672
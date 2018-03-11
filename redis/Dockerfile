ARG REDIS_VERSION=4.0-alpine
FROM redis:${REDIS_VERSION}

MAINTAINER Kim Hsiao <white.shopping@gmail.com>

LABEL REDIS_VERSION=${REDIS_VERSION}

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

EXPOSE 6379

CMD [ "redis-server" ]
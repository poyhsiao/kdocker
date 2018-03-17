ARG MEMCACHED_VERSION=1.5.6
FROM memcached:${MEMCACHED_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL MEMCACHED_VERSION=${MEMCACHED_VERSION}

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

EXPOSE 11211

USER memcache

CMD [ "memcached" ]
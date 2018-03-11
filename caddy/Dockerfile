FROM alpine:edge

MAINTAINER Kim Hsiao <white.shopping@gmail.com>

LABEL CADDY_VERSION=0.10.11

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

RUN apk update && \
    apk upgrade && \
    apk --no-cache add bash tini git openssh-client && \
    apk --no-cache add --virtual devs tar curl

## install caddy server with plugins

ARG PLUGINS="http.awslambda,http.cache,http.cors,http.expires,http.forwardproxy,http.ipfilter,http.locale,http.login,http.mailout,http.minify,http.nobots,http.proxyprotocol,http.ratelimit,http.realip,http.reauth,http.upload,net"
ENV PLUGINS ${PLUGINS}

ARG LICENSE="personal"
ENV LICENSE ${LICENSE}

ARG PLATFORM="amd64"

ARG URL=https://caddyserver.com/download/linux/${PLATFORM}?plugins=${PLUGINS}&license=${LICENSE}

RUN cd /tmp && \
    curl --silent --show-error --fail --location \
    --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
    ${URL} | tar --no-same-owner -C /usr/bin -xz caddy

# remove devs

RUN apk del devs && \
    rm -rf /tmp/*

# copy setting file to target
COPY ./Caddyfile /etc/Caddyfile

EXPOSE 80 443 2018

WORKDIR /var/www

CMD [ "/usr/bin/caddy", "-conf", "/etc/Caddyfile" ]
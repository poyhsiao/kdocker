ARG POSTGRES_VERSION=10
FROM postgres:${POSTGRES_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL POSTGRES_VERSION=${POSTGRES_VERSION}

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

RUN apk update && \
    apk upgrade

EXPOSE 5432

CMD [ "postgres" ]
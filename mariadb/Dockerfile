ARG MARIADB_VERSION=10.3
FROM mariadb:${MARIADB_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL MARIADB_VERSION=${MARIADB_VERSION}

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

ADD ./my.cnf /etc/mysql/conf.d/my.cnf

EXPOSE 3306

CMD [ "mysqld" ]
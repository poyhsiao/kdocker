ARG MYSQL_VERSION=latest
FROM mysql:${MYSQL_VERSION}

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

ADD my.cnf /etc/mysql/conf.d/my.cnf

# Add mysql log directory
RUN mkdir -p /var/log/mysql && \
    touch /var/log/mysql/mysql.log && \
    touch /var/log/mysql/mysql-bin.log && \
    touch /var/log/mysql/error.log && \
    touch /var/log/mysql/slow.log && \
    chown -R mysql:mysql /var/log/mysql

EXPOSE 3306

CMD [ "mysqld" ]


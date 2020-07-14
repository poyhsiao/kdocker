ARG POSTGIS_VERSION=10
FROM postgis/postgis:${POSTGIS_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL POSTGIS_VERSION=${POSTGIS_VERSION}

##############################
# Set Timezone
##############################
ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

##############################
# Update system with bug-fixed
##############################
RUN apt-get update && \
  apt-get -y upgrade

RUN apt-get -y autoremove && \
  apt-get clean && \
  rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 5432

CMD [ "postgres" ]

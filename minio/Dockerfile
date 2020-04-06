ARG MINIO_VERSION=latest
FROM minio/minio:${MINIO_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL MINIO_VERSION=${MINIO_VERSION}

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
RUN apk update && \
  apk upgrade

ENTRYPOINT [ "minio", "server", "/export" ]

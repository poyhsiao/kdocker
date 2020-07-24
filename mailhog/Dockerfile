ARG MAILHOG_VERSION=latest
FROM mailhog/mailhog:${MAILHOG_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL MAILHOG_VERSION=${MAILHOG_VERSION}

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

CMD [ "Mailhog" ]

EXPOSE 1025 8025

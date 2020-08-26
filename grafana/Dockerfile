ARG GRAFANA_VERSION=latest
FROM grafana/grafana:${GRAFANA_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL GRAFANA_VERSION=${GRAFANA_VERSION}

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

# ARG GF_INSTALL_IMAGE_RENDERER_PLUGIN=${GRAFANA_PLUGIN_ENABLE}

EXPOSE 3000

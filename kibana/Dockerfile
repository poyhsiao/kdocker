ARG KIBANA_VERSION=5.6.8
FROM docker.elastic.co/kibana/kibana-oss:${KIBANA_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL KIBANA_VERSION=${KIBANA_VERSION}

USER root

ENV PATH /user/share/kibana/bin:$PATH

WORKDIR /user/share/kibana

EXPOSE 5601

# CMD [ "kibana", "--allow-root" ]

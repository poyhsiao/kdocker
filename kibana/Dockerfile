ARG KIBANA_VERSION=5.6.8
FROM docker.elastic.co/kibana/kibana:${KIBANA_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL KIBANA_VERSION=${KIBANA_VERSION}

#########################
# Remove x-pack
#########################
USER root

ARG KIBANA_ENABLE_SECURITY

RUN if [ "${KIBANA_ENABLE_SECURITY}" != "true" ]; then \
    cd /usr/share/kibana && \
    ./bin/kibana-plugin remove x-pack \
;fi

ENV PATH /user/share/kibana/bin:$PATH

WORKDIR /user/share/kibana

EXPOSE 5601

CMD [ "kibana" ]
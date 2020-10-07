ARG LOGSTASH_VERSION=6.2.2
FROM docker.elastic.co/logstash/logstash-oss:${LOGSTASH_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL LOGSTASH_VERSION=${LOGSTASH_VERSION}

ENV PATH /usr/share/logstash/bin:$PATH

WORKDIR /usr/share/logstash

ARG LOGSTASH_PLUGINS=NONE
ENV LOGSTASH_PLUGINS=${LOGSTASH_PLUGINS}

# RUN echo [ "${LOGSTASH_PLUGINS}" != "NONE" ]; && \
#   sleep 10 && \
RUN if [ "$LOGSTASH_PLUGINS" != "NONE" ]; then \
      rm -f /usr/share/logstash/pipeline/logstash.conf && \
      logstash-plugin install --no-verify `echo $LOGSTASH_PLUGINS | sed 's/;/ /g'` \
    ;fi

EXPOSE 5041-5050 10101/udp

CMD [ "logstash" ]

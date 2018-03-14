ARG LOGSTASH_VERSION=6.2.2
FROM docker.elastic.co/logstash/logstash-oss:${LOGSTASH_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL LOGSTASH_VERSION=${LOGSTASH_VERSION}

ENV PATH /user/share/logstash/bin:$PATH

WORKDIR /user/share/logstash

EXPOSE 5002

CMD [ "logstash" ]
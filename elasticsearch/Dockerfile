ARG ELASTICSEARCH_VERSION=6.2.2
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:${ELASTICSEARCH_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL ELASTICSEARCH_VERSION=${ELASTICSEARCH_VERSION}

#########################
# Add plugins
#########################

USER elasticsearch

ARG ELASTICSEARCH_VERSION=6.2.2
ARG ELASTICSEARCH_SMARTCN_ANALYZER=false
ARG ELASTICSEARCH_IK_ANALYZER=false
ARG ELASTICSEARCH_ANSJ_ANALYZER=false

ENV ELASTICSEARCH_VERSION ${ELASTICSEARCH_VERSION}
ENV ELASTICSEARCH_SMARTCN_ANALYZER ${ELASTICSEARCH_SMARTCN_ANALYZER}
ENV ELASTICSEARCH_IK_ANALYZER ${ELASTICSEARCH_IK_ANALYZER}
ENV ELASTICSEARCH_ANSJ_ANALYZER ${ELASTICSEARCH_ANSJ_ANALYZER}

#########################
# Add smartcn
#########################

USER elasticsearch

RUN if [ "${ELASTICSEARCH_SMARTCN_ANALYZER}" = "true" ]; then \
  cd /usr/share/elasticsearch && \
  ./bin/elasticsearch-plugin install --batch analysis-smartcn \
  ;fi

#########################
# Add ik_analyzer
#########################

USER elasticsearch

RUN if [ "${ELASTICSEARCH_IK_ANALYZER}" = "true" ]; then \
  cd /usr/share/elasticsearch && \
  ./bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${ELASTICSEARCH_VERSION}/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip \
  ;fi

#########################
# Add ANSJ analyzer
#########################

USER elasticsearch

RUN if [ "${ELASTICSEARCH_ANSJ_ANALYZER}" = "true" ]; then \
  cd /usr/share/elasticsearch && \
  ./bin/elasticsearch-plugin install --batch https://github.com/NLPchina/elasticsearch-analysis-ansj/releases/download/v${ELASTICSEARCH_VERSION}/elasticsearch-analysis-ansj-${ELASTICSEARCH_VERSION}.0-release.zip \
  ;fi

#########################
# Start
#########################

USER elasticsearch

WORKDIR /usr/share/elasticsearch

CMD [ "bin/elasticsearch" ]

EXPOSE 9200 9300

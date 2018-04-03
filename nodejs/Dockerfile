ARG NODEJS_VERSION=latest
FROM node:${NODEJS_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL NODEJS_VERSION=${NODEJS_VERSION}

ARG NODEJS_USER=node
ENV NODEJS_USER ${NODEJS_USER}

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

##############################
# Set node user
##############################

RUN if [ ${NODEJS_USER} != node ]; then \
    deluser --remove-home node && \
    addgroup -S ${NODEJS_USER} -g 1001 && \
    adduser -S -g ${NODEJS_USER} -u 1001 ${NODEJS_USER} \
;fi

##############################
# Set node global path
##############################

ENV NPM_CONFIG_PREFIX=/home/${NODEJS_USER}/.npm-global
ENV PATH=$PATH:/home/${NODEJS_USER}/.npm-global/bin

##############################
# Set or update yarn if required
##############################

ARG NODEJS_YARN_VERSION=default
ENV NODEJS_YARN_VERSION=${NODEJS_YARN_VERSION}

RUN if [ ${NODEJS_YARN_VERSION} != default ]; then \
        apk add --update --no-cache --virtual .build curl && \
        cd \tmp && \
        #
        # check yarn version
        #
        if [ ${NODEJS_YARN_VERSION} != latest ]; then \
            curl -fSLO --compressed "https://yarnpkg.com/downloads/${NODEJS_YARN_VERSION}/yarn-v${NODEJS_YARN_VERSION}.tar.gz" && \
            tar -xzf yarn-v${NODEJS_YARN_VERSION}.tar.gz -C /opt/ && \
            ln -snf /opt/yarn-v${NODEJS_YARN_VERSION}/bin/yarn /usr/local/bin/yarn && \
            rm yarn-v${NODEJS_YARN_VERSION}.tar.gz \
        ;else \
            rm -rf /opt/* && \
            curl -fSLO --compressed "https://yarnpkg.com/latest.tar.gz" && \
            tar -xzf latest.tar.gz -C /opt/ && \
            chmod 777 /opt/* && \
            ln -snf /opt/yarn-*/bin/yarn /usr/local/bin/yarn && \
            rm latest.tar.gz \
        ;fi \
;fi

##############################
# Install required global npm packages
##############################

USER ${NODEJS_USER}

COPY ./global-packages /tmp

RUN cd \tmp && \
    cat /tmp/global-packages | xargs yarn add global

##############################
# final step
##############################

USER root

RUN apk del .build && \
    rm /var/cache/apk/* && \
    rm -rf /tmp/*

USER ${NODEJS_USER}

WORKDIR /home/${NODEJS_USER}/app

EXPOSE 80 443 3000 8080

CMD [ "sleep", "314469260" ]

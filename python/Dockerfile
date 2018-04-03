ARG PYTHON_VERSION=3
FROM python:${PYTHON_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL PYTHON_VERSIO=${PYTHON_VERSION}

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
# Update pip version
##############################

RUN pip install --upgrade pip

##############################
# Install require build env
##############################

RUN apk add --update --no-cache build-base bash

COPY ./build-requirement.txt /tmp

RUN cat /tmp/build-requirement.txt | xargs apk add --update --no-cache

##############################
# Install required python pkg
##############################

COPY ./requirements.txt /tmp

RUN pip install -r /tmp/requirements.txt

##############################
# Final step
##############################

RUN rm /var/cache/apk/* && \
    rm -rf /tmp/*

WORKDIR /var/www

EXPOSE 80 443 8000

CMD [ "sleep", "314469260" ]
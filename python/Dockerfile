ARG PYTHON_VERSION=3
FROM python:${PYTHON_VERSION}-stretch

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

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y

##############################
# Update pip version
##############################

RUN pip install --upgrade pip

##############################
# Install require build env
##############################

RUN apt-get install -y --no-install-recommends build-essential

COPY ./build-requirement.txt /tmp

RUN cat /tmp/build-requirement.txt | xargs apt-get install -y --no-install-recommends

##############################
# Install required python pkg
##############################

COPY ./requirements.txt /tmp

RUN pip install -r /tmp/requirements.txt

##############################
# Final step
##############################

RUN apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www

EXPOSE 80 443 8000

CMD [ "sleep", "314469260" ]
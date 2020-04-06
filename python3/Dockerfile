ARG PYTHON3_VERSION=3.8
FROM python:${PYTHON3_VERSION}-alpine

ARG TZ=UTC
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

ARG PYTHON3_LOG_DIR=/var/log/python3
ENV PYTHON3_LOG_DIR=${PYTHON3_LOG_DIR}

WORKDIR /tmp

COPY requirements.txt /tmp
RUN pip install --upgrade pip && \
  pip install --no-cache-dir -r requirements.txt && \
  rm -rf /tmp/* && \
  mkdir -p ${PYTHON3_LOG_DIR}

ARG APP_POINTER=/var/src/app
WORKDIR ${APP_POINTER}

EXPOSE 8000 8003

CMD [ "python" ]

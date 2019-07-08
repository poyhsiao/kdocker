#!/usr/bin/env sh

$(which docker-compose) stop $1 && \
    $(which docker-compose) start $1

#!/bin/env sh

DOCKER_CMD=$(which docker)
$DOCKER_CMD rmi $($DOCKER_CMD images -a --filterdangling=true -q)

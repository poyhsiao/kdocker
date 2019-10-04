#!/bin/env sh

DOCKER_CMD=$(which docker)

$DOCKER_CMD kill $($DOCKER_CMD ps -q)
$DOCKER_CMD rm $($DOCKER_CMD ps --filter=status=exited --filter=status=created -q)
$DOCKER_CMD rmi $($DOCKER_CMD images -a -q)

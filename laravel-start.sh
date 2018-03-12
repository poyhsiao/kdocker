#!/usr/bin/env sh

docker-compose up -d php-fpm nginx postgres-postgis mongo redis rabbitmq memcached elasticsearch php-worker

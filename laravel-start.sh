#!/usr/bin/env sh

docker-compose up -d php-fpm nginx mysql mongo redis rabbitmq memcached elasticsearch php-worker phpmyadmin kibana logstash

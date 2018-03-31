#!/usr/bin/env sh

docker-compose up -d php-fpm nginx mariadb mongo redis rabbitmq memcached elasticsearch php-worker phpmyadmin kibana logstash

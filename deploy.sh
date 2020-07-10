#!/bin/bash
set -e

echo "Statring identidock system"

docker run -d --restart=always --name redis redis:latest
docker run -d --restart=always --name dnmonster amouat/dnmonster:1.0
docker run -d --restart=always --link dnmonster:dnmonster --link redis:redis \
	-e ENV=PROD --name identidock vanger69/identidock:auto
docker run -d --restart=always --name proxy --link identidock:identidock -p 80:80 \
       -e NGINX_HOST=52.174.123.33 -e NGINX_PROXY=http://identidock:9000 \
       proxy:1.0

echo "Started"

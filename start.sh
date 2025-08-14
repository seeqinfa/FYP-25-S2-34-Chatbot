#!/bin/bash

# Create necessary directories
mkdir -p /tmp/client_body
mkdir -p /tmp/proxy
mkdir -p /tmp/fastcgi
mkdir -p /tmp/uwsgi
mkdir -p /tmp/scgi

# Start PHP-FPM in background
php-fpm82 -y /app/php-fpm.conf -D

# Start nginx in foreground
nginx -c /app/nginx.conf -g 'daemon off;'
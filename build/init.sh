#!/usr/bin/env sh


envsubst < /etc/nginx/ssl.conf.tmpl > /etc/nginx/ssl.conf
envsubst < /etc/nginx/default_server.conf.tmpl > /etc/nginx/default_server.conf


echo "creating/renewing cers for the first time"
sh /renew.sh

echo "starting cron deamon:"
/usr/sbin/crond -b

echo "Starting nginx deamon"
exec nginx -g 'daemon off;'




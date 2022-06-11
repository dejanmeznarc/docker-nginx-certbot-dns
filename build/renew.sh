#!/usr/bin/env sh
set -e

CDATE=`date +"%Y-%m-%d %T"`

echo " "
echo " "
echo ${CDATE} trying to renew *.${DOMAIN}


echo "dns_cloudflare_api_token = ${CLOUDFLARE_API_KEY}" > /cf.key.ini

certbot certonly \
  --dns-cloudflare --agree-tos -n \
  --email "${CERTBOT_EMAIL}" \
  --dns-cloudflare-credentials /cf.key.ini \
  --dns-cloudflare-propagation-seconds "${WAIT_SECONDS:-10}" \
  -d "*.${DOMAIN}" \
  --deploy-hook "nginx -t && nginx -s reload"

#nginx -t && nginx -s reload
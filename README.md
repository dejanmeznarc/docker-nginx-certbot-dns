# Nginx and certbot-dns-cloudflare in docker container

## what it does?
* generates wildcard certificate (*.example.com)
* set its up with nginx
* automatically renews certs (at night 2:59)


## Docker compose:
```yaml
version: "3"

services:
  nginx_certbot:
    build:
      dockerfile: ./Dockerfile
      context: ./
    
    volumes:
      - ./certs:/etc/letsencrypt:z
      - ./sites:/etc/nginx/conf.d:z

    ports:
      - 80:80
      - 443:443

    environment:
      - CERTBOT_EMAIL= # email used for certbot alerts
      - CLOUDFLARE_API_KEY= # cloudflare api key for zone
      - WAIT_SECONDS= # wait before checking cert (dns propagation timeout)
      - DOMAIN=   # without * (only: example.com, *. is added in docker afterwards)
```
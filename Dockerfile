FROM certbot/dns-cloudflare AS certbot


RUN apk add curl nginx gettext

RUN mkdir -p /run/nginx
COPY build/nginx_ssl_server.conf /etc/nginx/ssl_server.conf
COPY build/nginx_ssl.conf /etc/nginx/ssl.conf.tmpl
COPY build/nginx.conf /etc/nginx/nginx.conf
COPY build/init.sh /etc/entrypoint.sh
COPY build/renew.sh /renew.sh
RUN chmod 755 /renew.sh /etc/entrypoint.sh

RUN echo "55       2       *       *       *       /renew.sh >> /var/log/dejan/script.log" >> /crontab.txt
RUN /usr/bin/crontab /crontab.txt

EXPOSE 80
EXPOSE 443
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]







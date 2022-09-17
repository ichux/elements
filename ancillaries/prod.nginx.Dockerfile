FROM nginx:1.23.1

COPY ./static /etc/static
COPY ./ancillaries/serveapi.conf /etc/nginx/conf.d/default.conf
COPY ./ancillaries/server-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "./entrypoint.sh"]

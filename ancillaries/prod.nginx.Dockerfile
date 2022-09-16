FROM nginx:1.23.1

ENTRYPOINT ["sh", "./server-entrypoint.sh"]

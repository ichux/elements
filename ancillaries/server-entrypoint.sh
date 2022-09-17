#!/bin/bash

if [ "$1" = 'nginx' ]; then
  app_ip=`hostname -i`
  echo "${app_ip%.*}.2    if_elements_app_prod" >> /etc/hosts

  exec nginx -g 'daemon off;'
fi

exec "$@"

#!/bin/sh
set -e

if [ "$1" = 'supervisord' ]; then
    exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
fi

exec "$@"

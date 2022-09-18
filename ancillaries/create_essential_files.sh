#!/usr/bin/env bash

printf "\nThis action \x1b[31mOVERWRITES\x1b[0m existent files\nDo you wish to create them (y/n) as ? "
read answer

create_env(){
cat > .env<< EOF
# Django settings
DEBUG=1
SECRET_KEY=7b77ad7601c3f546b97ca24782037f131463e26bd27a3236a7a84215becc3e6cbb8b16e5
TIME_ZONE=Africa/Lagos
CHECK_URL_INTERVAL=3
LANGUAGE_CODE=en-uk
ALLOWED_HOSTS=127.0.0.1 localhost

# As of Django 4.0, the values in the CSRF_TRUSTED_ORIGINS setting
# must start with a scheme (usually http:// or https://)
CSRF_TRUSTED_ORIGINS=http://127.0.0.1 http://localhost

# DOCKER DEVELOPMENT
SUPERVISOR_DEV_PROD_PORT=17001
DJANGO_DEV_PORT=17002

# DOCKER PRODUCTION
SUPERVISOR_ADMIN_PROD_PORT=18001
DJANGO_PROD_PORT=18002
NGINX_PORT=18003

# should gunicorn reload the project on change or not. Values: true or false
WEB_RELOAD=0

# profile the application run by gunicorn to discover or trace bottlenecks
PROFILE=0
EOF

printf "\n\x1b[32m===\x1b[0m\n\x1b[31m.env\x1b[0m has been successfully created\n"
[ ! -f core/per_settings.py ] && \
	printf "for dev, you need to have \x1b[31mcore/per_settings.py\x1b[0m present\n"
printf "\x1b[32m===\x1b[0m\n"
}

if [ "$answer" != "${answer#[Yy]}" ] ;then
    # [[ "$1" = "dev" ]] && create_dev_env && exit 0
    # [[ "$1" = "prod" ]] && create_prod_env
    create_env
fi

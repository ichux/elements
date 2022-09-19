#!/usr/bin/env bash

# Inside the container run: curl `cat hip`:2108
# docker exec -it cf_elements_app_prod bash -c 'curl `cat hip`:2108/.env'
printf $(ifconfig en0 | grep "inet[ ]" | awk '{print $2}') > hip

printf "\nThis action \x1b[31mOVERWRITES\x1b[0m existent files\nDo you wish to create them (y/n) as ? "
read answer

create_env(){
cat > .env<< EOF
# Django settings
DEBUG=0
SECRET_KEY=ad4ebc44fcdc1f055a3837646c46bf047d5568374c659af3438a66cad63c9e34321b790f
TIME_ZONE=Africa/Lagos
CHECK_URL_INTERVAL=3
LANGUAGE_CODE=en-uk
ALLOWED_HOSTS=127.0.0.1 localhost

# As of Django 4.0, the values in the CSRF_TRUSTED_ORIGINS setting
# must start with a scheme (usually http:// or https://)
CSRF_TRUSTED_ORIGINS=http://127.0.0.1 http://localhost

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
printf "\x1b[32m===\x1b[0m\n"
}

if [ "$answer" != "${answer#[Yy]}" ] ;then
    create_env
fi

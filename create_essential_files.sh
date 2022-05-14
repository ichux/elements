#!/bin/sh

echo -n "This action OVERWRITES exitent files\n\nDo you wish to create them (y/n) as ? "
read answer

create_files(){
cat > .env<< EOF
# how many workers of gunicorn to be run
CONCURRENCY=1

# should gunicorn reload the project on change or not. Values: true or false
WEB_RELOAD=true

# profile the application run by gunicorn to discover or trace bottlenecks
PROFILE=false

# Django settings
TIME_ZONE=Africa/Lagos
CHECK_URL_INTERVAL=3
LANGUAGE_CODE=en-uk
ALLOWED_HOSTS=127.0.0.1 localhost

# DOCKER DEVELOPMENT
SUPERVISOR_DEV_PROD_PORT=17001
DJANGO_DEV_PORT=0.0.0.0:17002

# DOCKER PRODUCTION
SUPERVISOR_ADMIN_PROD_PORT=18001
DJANGO_PROD_PORT=0.0.0.0:18002
EOF

echo "\n\n===\n'.env' has been successfully created\n===\n\n"
}

if [ "$answer" != "${answer#[Yy]}" ] ;then
    create_files
fi

# if [[ "$1" =~ ^[Yy]$ ]]; then
#     create_files
# fi
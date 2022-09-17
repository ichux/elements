printf "\nThis action \x1b[31mOVERWRITES\x1b[0m existent files\nDo you wish to create them (y/n) as ? \n"
read answer

create_files(){
cat > .env<< EOF
# how many workers of gunicorn to be run
CONCURRENCY=1

# should gunicorn reload the project on change or not. Values: true or false
WEB_RELOAD=false

# profile the application run by gunicorn to discover or trace bottlenecks
PROFILE=false

# Django settings
TIME_ZONE=Africa/Lagos
CHECK_URL_INTERVAL=3
LANGUAGE_CODE=en-uk
ALLOWED_HOSTS=127.0.0.1 localhost if_elements_app_prod

# DOCKER DEVELOPMENT
SUPERVISOR_DEV_PROD_PORT=17001
DJANGO_DEV_PORT=17002

# DOCKER PRODUCTION
SUPERVISOR_ADMIN_PROD_PORT=18001
DJANGO_PROD_PORT=18002
NGINX_PORT=18003
EOF

printf "\n\x1b[32m===\x1b[0m\n'.env' has been successfully created\n\x1b[32m===\x1b[0m\n"
}

if [ "$answer" != "${answer#[Yy]}" ] ;then
    create_files
fi

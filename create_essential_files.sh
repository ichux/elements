#!/bin/sh

echo -n "This action OVERWRITES exitent files\n\nDo you wish to create them (y/n) as ? "
read answer

create_files(){
cat > core/per_settings.py<< EOF
import logging
import os
import sys
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
os.environ.setdefault("SECRET_KEY", "django-insecure-trek0si6ms+neatlnthqk796y2a9d5js&3hdc&fz*pyyv)76*d")

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

os.environ.setdefault("ALLOWED_HOSTS", "")


# Application definition

DEFAULT_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
]


INSTALLED_APPS = [
    "api",
]


INSTALLED_APPS += DEFAULT_APPS

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

ROOT_URLCONF = "core.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "core.wsgi.application"


# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "ancillaries" / "elements.sqlite3",
    }
}


# Password validation
# https://docs.djangoproject.com/en/3.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.CommonPasswordValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.NumericPasswordValidator",
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.2/topics/i18n/

os.environ.setdefault("LANGUAGE_CODE", "en-us")
os.environ.setdefault("TIME_ZONE", "UTC")

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.2/howto/static-files/

STATIC_URL = "/static/"

# Default primary key field type
# https://docs.djangoproject.com/en/3.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"


LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "verbose": {
            "format": "[%(asctime)s] %(levelname)s [%(pathname)s: %(name)s.%(funcName)s:%(lineno)s]:%(message)s",
            "datefmt": "%d/%b/%Y %H:%M:%S",
        },
        "simple": {
            "format": "%(levelname)s %(message)s",
        },
    },
    "handlers": {
        "file": {
            "class": "logging.handlers.RotatingFileHandler",
            "formatter": "verbose",
            "level": logging.ERROR,
            "filename": BASE_DIR / "ancillaries" / "logs" / "django.log",
            "maxBytes": 1024 * 1024 * 10,  # 10 MB
            "backupCount": 20,
        },
        "console": {
            "class": "logging.StreamHandler",
            "level": "DEBUG",
            "formatter": "simple",
            "stream": sys.stdout,
        },
    },
    "loggers": {
        "django": {
            "handlers": ["file", "console"],
            "level": "INFO",
            "propagate": True,
        },
    },
}

STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'static'

os.environ.setdefault("CHECK_URL_INTERVAL", "10")
EOF


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
SECRET_KEY=ChangeThisSecretNow!--ad04276d6f68c4ff42550ef531c58675
ALLOWED_HOSTS=127.0.0.1 localhost

# DOCKER DEVELOPMENT
SUPERVISOR_DEV_PROD_PORT=17001
DJANGO_DEV_PORT=0.0.0.0:17002

# DOCKER PRODUCTION
SUPERVISOR_ADMIN_PROD_PORT=18001
DJANGO_PROD_PORT=0.0.0.0:18002
EOF

echo "\n\n===\n'.env' and 'core/per_settings.py' have been successfully created\n===\n\n"
}

if [ "$answer" != "${answer#[Yy]}" ] ;then
    create_files
fi
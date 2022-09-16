FROM python:3.8.8-buster

ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV CRYPTOGRAPHY_DONT_BUILD_RUST 1

RUN groupadd --gid 1000 ubuntu && useradd --uid 1000 --gid ubuntu --create-home --no-log-init --shell /bin/bash ubuntu

RUN apt-get update && apt-get install -y supervisor netcat
COPY ancillaries/prod-supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /app

COPY ./ancillaries/requirements.txt /app/ancillaries/requirements.txt

RUN pip3.8 install --disable-pip-version-check --upgrade pip setuptools wheel
RUN pip3.8 install --no-cache-dir -r /app/ancillaries/requirements.txt gunicorn meinheld

COPY . .

RUN chown -R ubuntu:ubuntu ./
USER ubuntu

ENTRYPOINT ["sh", "./entrypoint.sh"]

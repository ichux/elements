FROM bitnami/python:3.10

ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV CRYPTOGRAPHY_DONT_BUILD_RUST 1

RUN groupadd --gid 1000 debian-11 && \
    useradd --uid 1000 --gid debian-11 --create-home --no-log-init --shell /bin/bash debian-11

RUN apt-get update && apt-get install -y supervisor netcat curl && apt-get clean
COPY ./ancillaries/prod-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./ancillaries/requirements.txt /app/ancillaries/requirements.txt

WORKDIR /app
RUN pip3.10 install --no-cache-dir --disable-pip-version-check --upgrade \
    pip setuptools wheel gunicorn -r /app/ancillaries/requirements.txt && \
    chown -R debian-11:debian-11 ./

USER debian-11
ENTRYPOINT ["sh", "./entrypoint.sh"]

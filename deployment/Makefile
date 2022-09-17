# Do not remove this block. It is used by the 'help' rule when
# constructing the help output.
# help:
# help: Elements Makefile help
# help:

.PHONY: help
# help: help						- Please use "make <target>" where <target> is one of
help:
	@grep "^# help\:" Makefile | sed 's/\# help\: //' | sed 's/\# help\://'

.PHONY: build
# help: build						- build the docker containers
build:
	@docker-compose up --build -d

.PHONY: boot
# help: boot					        - bootstrap the application e.g make boot c=prod OR make boot c=dev
boot:
	@. ./produce_env.sh

.PHONY: bash
# help: bash						- enter bash app
bash:
	@docker exec -it cf_elements_app_prod bash

.PHONY: logs
# help: logs						- Get the logs of a service
logs:
	@docker logs cf_elements_app_prod --timestamps --follow

.PHONY: tests
# help: tests						- Runs tests for the application
tests:
	@docker exec -i cf_elements_app_prod python3 runtests.py

.PHONY: admin
# help: admin						- Create an admin user
admin:
	@echo "from django.contrib.auth.models import User; \
	User.objects.create_superuser('admin', 'ichux@piccl.com', 'UnlockAdm1n')" \
	| docker exec -i cf_elements_app_prod python3 manage.py shell
	@echo "An admin user was successfully created"

.PHONY: resprod
# help: resprod						- Restart prod Supervisor
resprod:
	@curl -d \
	'<?xml version="1.0"?><methodCall><methodName>supervisor.restart</methodName></methodCall>' \
	http://prod:0nY0URServer@localhost:18001/RPC2 >/dev/null 2>&1

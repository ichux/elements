# Do not remove this block. It is used by the 'help' rule when
# constructing the help output.
# help:
# help: Elements Makefile help
# help:

.PHONY: help
# help: help						- Please use "make <target>" where <target> is one of
help:
	@grep "^# help\:" Makefile | sed 's/\# help\: //' | sed 's/\# help\://'


.PHONY: bootstrap
# help: bootstrap					- bootstrap the application for the first time. Run this only once!
bootstrap:
	@[ ! -f .env ] || [ ! -f core/per_settings.py ] && sh create_essential_files.sh


.PHONY: build
# help: build						- build the docker containers
build:
	@#make build c=prod OR make build c=dev
	@docker-compose -f $(c)-docker-compose.yml up --build -d


.PHONY: bash
# help: bash						- enter bash app
bash:
	@#make bash c=prod OR make bash c=dev
	@docker exec -it element_app_$(c)_container bash


.PHONY: logs
# help: logs						- Get the logs of a service
logs:
	@#make logs c=prod OR make tests c=dev
	@docker-compose -f $(c)-docker-compose.yml logs --timestamps --follow

.PHONY: tests
# help: tests						- Runs tests for the application
tests:
	@#make tests c=prod OR make tests c=dev
	@docker exec -i element_app_$(c)_container python runtests.py

.PHONY: admin
# help: admin						- Create an admin user
admin:
	@#make admin c=dev
	@echo "from django.contrib.auth.models import User; \
	User.objects.create_superuser('admin', 'admin@elements.nl', 'P455InPWforAdmin')" \
	| docker exec -i element_app_$(c)_container python manage.py shell
	@echo "An admin user was successfully created"


.PHONY: redev
# help: redev						- Restart dev Supervisor
redev:
	@curl -d \
	'<?xml version="1.0"?><methodCall><methodName>supervisor.restart</methodName></methodCall>' \
	http://dev:0nY0URPc@localhost:17001/RPC2 >/dev/null 2>&1

.PHONY: resprod
# help: resprod						- Restart prod Supervisor
resprod:
	@curl -d \
	'<?xml version="1.0"?><methodCall><methodName>supervisor.restart</methodName></methodCall>' \
	http://prod:0nY0URServer@localhost:18001/RPC2 >/dev/null 2>&1

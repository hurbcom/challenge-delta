#
# Available target rules
#

default: help

help:
	@echo
	@echo "Delta Challenge"
	@echo
	@echo "Please use 'make <target>' where <target> is one of"
	@echo
	@echo "Targets:"
	@echo "  run		run (build and start) the entire application using docker compose"
	@echo "  packages	see all packages installed"
	@echo "  down		remove all containers applications using docker compose"
	@echo "  start		start all containers using docker compose"
	@echo "  stop		stop all containers using docker compose"
	@echo "  restart	restart all containers using docker compose"
	@echo "  logs		follow logs from all containers using docker compose"
	@echo "  logs_db	follow logs from db container"
	@echo "  logs_nginx	follow logs from fe container"
	@echo "  logs_node	follow logs from be container"
	@echo "  build		build containers images using docker compose"
	@echo "  clean		clean all configurations even the containers images and volumes"
	@echo "  test		execute tests using the test.sh"
	@echo "  create	create packages in the db. Usage: make create package=<name_of_the_package>"
	@echo "  delete	delete packages in the db. Usage: make create id=<id_of_the_package>"
	@echo
	

packages:
	@curl localhost/packages

down:
	docker-compose down --remove-orphans

build:
	docker-compose build --no-cache --force-rm

run:
	docker-compose build --no-cache --force-rm && \
	docker-compose up -d 

clean:
	@echo 'Cleaning all the configurations including the volumes and images created'
	@docker-compose down --remove-orphans --volumes --rmi all

logs:
	docker-compose logs -f

logs_db:
	docker logs -f  --details delta_db

logs_nginx:
	docker logs -f  --details delta_fe

logs_node:
	docker logs -f  --details delta_app

stop:
	docker-compose stop

start:
	docker-compose start

show:
	docker-compose ps 

restart:
	docker-compose restart
	@echo
	@echo 'Containers status: '
	@echo
	@docker ps --all --format "{{.ID}}\t{{.Names}}\t{{.Status}}" | grep delta || true

create:
ifdef package
	@curl -X POST localhost/packages --header "Content-Type: text/plain" -d $(package) || true
else
	@echo 'Package is not defined'
	@echo 'Usage: make create package=<name_of_the_package>'
endif

delete:
ifdef id
	@curl -X DELETE localhost/packages/$(id) || true
	@echo
else
	@echo 'Id is not defined'
	@echo 'Usage: make delete id=<id_of_package>'
endif

test:
	@chmod +x test.sh
	@/bin/bash test.sh
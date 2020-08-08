##
# This Makefile should be used exclusively on development environment.
##

# Container names
APP_CONTAINER_NAME=hurb-app
LOADBALANCER_CONTAINER_NAME=hurb-loadbalancer
DATABASE_CONTAINER_NAME=hurb-database

# Container image tags
APP_IMAGE_TAG=thenets/$(APP_CONTAINER_NAME)
LOADBALANCER_IMAGE_TAG=thenets/$(LOADBALANCER_CONTAINER_NAME)

# Build
docker-build: docker-build-app docker-build-loadbalancer

docker-build-app:
	cd src/app \
		&& docker build -t $(APP_IMAGE_TAG) .

docker-build-loadbalancer:
	cd src/loadbalancer \
		&& docker build -t $(LOADBALANCER_IMAGE_TAG) .

# Run
docker-run-app: docker-build-app
	docker run -it --rm \
		--name $(APP_CONTAINER_NAME) \
		-p 8888:8888 \
		$(APP_IMAGE_TAG) $(CMD)

docker-run-loadbalancer: docker-build-loadbalancer
	docker run -it --rm \
		--name $(LOADBALANCER_CONTAINER_NAME) \
		-p 80:80 \
		$(LOADBALANCER_IMAGE_TAG)

docker-run-database:
	docker run --rm \
		--name $(DATABASE_CONTAINER_NAME) \
		-p 3306:3306 \
		-e "MYSQL_ROOT_PASSWORD=QueroCafe" \
		mysql:5

# Helpers
compose-up: cleanup
	docker-compose build
	docker-compose up
cleanup:
	docker rm -f $$(docker ps -qa) || true
	docker system prune -f
	docker volume rm -f challenge-delta_database_data

APP_IMAGE_TAG=thenets/hurb-app
LOADBALANCER_IMAGE_TAG=thenets/hurb-loadbalancer

# Build
docker-build: docker-build-app

docker-build-app:
	cd src/app \
		&& docker build -t $(APP_IMAGE_TAG) .

docker-build-loadbalancer:
	cd src/loadbalancer \
		&& docker build -t $(LOADBALANCER_IMAGE_TAG) .

# Run
docker-run-app: docker-build-app
	docker run -it --rm \
		--name hurb-app \
		-p 8888:8888 \
		$(APP_IMAGE_TAG)

docker-run-loadbalancer: docker-build-loadbalancer
	docker run -it --rm \
		--name hurb-loadbalancer \
		-p 80:80 \
		-u root \
		$(LOADBALANCER_IMAGE_TAG)



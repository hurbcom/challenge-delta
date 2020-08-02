APP_IMAGE_TAG=thenets/hurb-app

docker-build: docker-build-app

docker-build-app:
	cd src/app \
		&& docker build -t $(APP_IMAGE_TAG) .

docker-run:
	docker run -it --rm \
		--name hurb-app \
		-p 8888:8888 \
		$(APP_IMAGE_TAG)

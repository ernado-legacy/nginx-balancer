all: build

build:
	docker build -t cydev/nginx-balancer .
push:
	docker push cydev/nginx-balancer
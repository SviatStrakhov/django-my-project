.PHONY: all build push deploy run stop

all: build push deploy

build:
	docker build -t 209566858151.dkr.ecr.eu-central-1.amazonaws.com/myproject:latest -f config/app/Dockerfile .

push:
	docker push 209566858151.dkr.ecr.eu-central-1.amazonaws.com/myproject:latest

deploy:
	eb deploy myproject2-dev

run:
	docker-compose up -d

stop:
	docker-compose down

stop-v:
	docker-compose down -v
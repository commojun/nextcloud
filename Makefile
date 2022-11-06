refresh: down up

up:
	docker-compose up -d

down:
	docker-compose down

pull:
	docker pull nextcloud:apache
	docker pull mariadb:10.8
	docker pull redis:latest

build:
	docker build -t nextcloud:custom ./dockerfile

update: pull build up

shell/%:
	docker-compose exec $* bash

logs:
	docker-compose logs -f

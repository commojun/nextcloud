.PHONY: db

refresh: down up

up:
	docker-compose up -d

down:
	docker-compose down

pull:
	docker pull nextcloud:30-apache
	docker pull mariadb:10.11
	docker pull redis:latest

build:
	docker build -t nextcloud:custom ./dockerfile

update: pull build refresh

shell:
	docker-compose exec -u www-data app bash

logs:
	docker-compose logs -f

db:
	docker compose exec db mysql -uroot -p nextcloud

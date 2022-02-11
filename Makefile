refresh: down up

up:
	docker-compose up -d

down:
	docker-compose down

pull:
	docker pull nextcloud:latest
	docker pull mariadb:latest

update: pull build-all up

shell/%:
	docker-compose exec $* bash

logs:
	docker-compose logs -f

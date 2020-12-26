init: docker-down-clear docker-pull docker-build docker-up

docker-up:
	docker-compose up -d

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build --pull

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

password:
	docker run --rm registry:2.6 htpasswd -Bbn admin admin > htpasswd
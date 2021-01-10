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

deploy-local:
	ssh ${HOST} -p ${PORT} 'rm -rf registry && mkdir registry'
	scp -P ${PORT} docker-compose.yml ${HOST}:registry/docker-compose.yml
	scp -P ${PORT} -r docker ${HOST}:registry/docker
	ssh ${HOST} -p ${PORT} 'cd registry && echo "COMPOSE_PROJECT_NAME=registry" >> .env'
	ssh ${HOST} -p ${PORT} 'cd registry && docker-compose pull'
	ssh ${HOST} -p ${PORT} 'cd registry && docker-compose up --build --remove-orphans -d'

deploy:
	ssh ${HOST} -p ${PORT} 'rm -rf registry && mkdir registry'
	scp -P ${PORT} docker-compose-production.yml ${HOST}:registry/docker-compose.yml
	scp -P ${PORT} -r docker ${HOST}:registry/docker
	scp -P ${PORT} ${HTPASSWD_FILE} ${HOST}:registry/htpasswd
	ssh ${HOST} -p ${PORT} 'cd registry && echo "COMPOSE_PROJECT_NAME=registry" >> .env'
	ssh ${HOST} -p ${PORT} 'cd registry && docker-compose pull'
	ssh ${HOST} -p ${PORT} 'cd registry && docker-compose up --build --remove-orphans -d'

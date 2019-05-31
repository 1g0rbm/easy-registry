init: prepare_scripts dotenv basic_http_auth

prepare_scripts:
	chmod +x ./scripts/*

basic_http_auth:
	./scripts/create_htpasswd.sh

dotenv:
	cp ./.env.dist .env
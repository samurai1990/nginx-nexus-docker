.PHONY: ssl builddev

all:
	@make ssl
	@make builddev

ssl:
	-mkdir certs
	@openssl req -new -newkey rsa:2048 -nodes -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=localhost" -keyout certs/server.key -out certs/server.csr
	@openssl x509 -req -days 365 -in certs/server.csr -signkey certs/server.key -out certs/server.crt
	@cp certs/server.key nginx && cp certs/server.crt nginx

builddev: 
	-docker image rm --force nginx:docker 
	docker build --no-cache -t nginx:docker nginx

run:
	@docker-compose up -d

down:
	@docker-compose down

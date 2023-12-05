.PHONY: ssl builddev

ssl:
	-mkdir certs
	@openssl req -new -newkey rsa:2048 -nodes -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=localhost" -keyout server.key -out server.csr
	@openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
	@cp certs/server.key nginx && cp certs/erver.crt nginx

builddev:
	-docker image rm --force nginx:docker 
	docker build --no-cache -t nginx:docker nginx

run:
	@docker-compose up -d

down:
	@docker-compose down

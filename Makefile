.PHONY: ssl builddev run down

all:
	@make ssl
	@make builddev

ssl:auth
	-mkdir certs
	@read -p "Enter password for Root Key: " input && openssl genrsa -passout pass:"$$input" -des3 -out certs/rootCA.key 2048
	@read -p "Enter password for Root PEM: " input && openssl req -passin pass:"$$input" -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=Local Certificate"  -x509 -new -nodes -key certs/rootCA.key -sha256 -days 1024 -out certs/rootCA.pem
	@openssl req -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=localhost"  -new -sha256 -nodes -out certs/nexus.csr -newkey rsa:2048 -keyout certs/nexuskey.key
	@read -p "Enter Domain name: " input && echo "subjectAltName=DNS:localhost,DNS:$$input" > extfile.cnf
	@echo "********************" && echo "domains: " && cat extfile.cnf && echo "********************"
	@read -p "Enter password for nexus Cert: " input && openssl x509 -req -passin pass:"$$input" -in certs/nexus.csr -CA certs/rootCA.pem -CAkey certs/rootCA.key -CAcreateserial -out certs/nexuscert.crt -days 500 -sha256 -extfile extfile.cnf
	@rm -f extfile.cnf
	@cp certs/nexuscert.crt nginx && cp certs/nexuskey.key nginx

remove_ssl:
	-rm -rf certs
	-rm nginx/*.crt && rm nginx/*.key

auth:
	@read -p "Enter username : " username && sh -c "echo -n '$$username:' >> nginx/.htpasswd"
	@sh -c "openssl passwd -apr1 >> nginx/.htpasswd"

builddev: 
	-docker image rm --force nginx:docker 
	docker build --no-cache -t nginx:docker nginx

run:
	@docker compose up -d

down:
	@docker compose down

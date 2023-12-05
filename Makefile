.PHONY: ssl builddev

ssl:
	-mkdir certs
	@read -p "Enter password for Root Key: " input && openssl genrsa -passout pass:"$$input" -des3 -out certs/rootCA.key 2048
	@read -p "Enter password for Root PEM: " input && openssl req -passin pass:"$$input" -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=Local Certificate"  -x509 -new -nodes -key certs/rootCA.key -sha256 -days 1024 -out certs/rootCA.pem
	@openssl req -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=localhost"  -new -sha256 -nodes -out certs/nexus.csr -newkey rsa:2048 -keyout certs/nexuskey.pem
	@echo "subjectAltName=DNS:localhost,DNS:nexus-repo" > extfile.cnf
	@read -p "Enter password for nexus Cert: " input && openssl x509 -req -passin pass:"$$input" -in certs/nexus.csr -CA certs/rootCA.pem -CAkey certs/rootCA.key -CAcreateserial -out certs/nexuscert.crt -days 500 -sha256 -extfile extfile.cnf
	@rm -f extfile.cnf
	@cp certs/nexuscert.crt nginx && cp certs/nexuskey.pem nginx

builddev:
	docker build --no-cache -t nginx-nexusproxy nginx

run:
	@docker-compose up -d

down:
	@docker-compose down

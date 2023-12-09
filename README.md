# nginx-nexus-docker


#### generate sertificate and username and password
```bash
make ssl
```


#### change the default docker registry from docker.io to my private registry
find file `docker.service` then add command `--registry-mirror`
example:
```bash
[Service] ExecStart= ExecStart=/usr/bin/dockerd -H fd:// --registry-mirror http://$REPO_IP:$REPO_PORT 
```
after reload and restart docker service:
```bash
sudo systemctl daemon-reload && sudo systemctl restart docker
```

#### docker daemon with self-signed TLS certificates
```bash
sudo mkdir -p /etc/docker/certs.d/$REPO_IP:$REPO_PORT
```
or
```bash
sudo mkdir -p /etc/docker/certs.d/$DOMAIN:$PORT
```
then copy certficate in there.
```bash
sudo cp server.crt /etc/docker/certs.d/$REPO_IP:$REPO_PORT
```
or
```bash
sudo cp server.crt /etc/docker/certs.d/$DOMAIN:$PORT
```
FROM nginx:stable-alpine

RUN mkdir -p /etc/nginx/external

COPY nginx.conf /etc/nginx/nginx.conf

COPY nexuscert.crt /etc/nginx/external/nexuscert.crt

COPY nexuskey.key /etc/nginx/external/nexuskey.key

COPY .htpasswd /etc/nginx/.htpasswd
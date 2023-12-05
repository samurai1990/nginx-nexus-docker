FROM nginx:stable-alpine

RUN mkdir -p /etc/nginx/external

COPY nginx.conf /etc/nginx/nginx.conf

COPY server.crt /etc/nginx/external/server.crt

COPY server.key /etc/nginx/external/server.key


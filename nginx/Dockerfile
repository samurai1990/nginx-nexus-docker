FROM nginx:alpine

RUN mkdir -p /etc/nginx/external

COPY nginx.conf /etc/nginx/nginx.conf

COPY nexuskey.pem /etc/nginx/external/nexuskey.pem

COPY nexuscert.crt /etc/nginx/external/nexuscert.crt


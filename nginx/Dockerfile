FROM nginx:alpine

MAINTAINER Amar Khan "amarkotasky@gmail.com"

EXPOSE 443
EXPOSE 80

VOLUME ["/etc/nginx/certs"]

COPY ssl/ /etc/nginx/certs/

COPY default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx" ,"-g", "daemon off;"]
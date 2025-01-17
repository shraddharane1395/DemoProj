FROM ubuntu

RUN apt-get update

RUN apt-get install nginx -y

COPY index.html /var/www/html

CMD ["nginx","-g","daemon off;"]

EXPOSE 80

FROM ubuntu

WORKDIR /app

RUN apt-get update

RUN apt-get install nginx -y

COPY index.html /usr/share/nginx/html

CMD ["nginx","-g","daemon off;"]

EXPOSE 80

FROM ubuntu:16.04
MAINTAINER James Turnbull "james@example.com"
RUN apt-get update
RUN apt-get install -y nginx
RUN echo 'Hi, I am in your container' \
    >/var/www/html/index.html
EXPOSE 80

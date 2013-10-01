FROM       ubuntu
MAINTAINER James Turnbull "james@example.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
ENV REFRESHED_AT 2013-08-01
RUN apt-get update
RUN apt-get -y install python-software-properties software-properties-common
RUN add-apt-repository ppa:nginx/stable
RUN apt-get update
RUN apt-get -y install nginx
RUN mkdir -p /var/www/html/website
ADD nginx/global.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/
EXPOSE 80

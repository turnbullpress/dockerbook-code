FROM       ubuntu
MAINTAINER James Turnbull "james@example.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
ENV REFRESHED_AT 2013-08-01
RUN apt-get update
RUN apt-get -y install ruby rubygems
RUN gem install --no-rdoc --no-ri sinatra json redis
RUN mkdir -p /opt/webapp
EXPOSE 4567

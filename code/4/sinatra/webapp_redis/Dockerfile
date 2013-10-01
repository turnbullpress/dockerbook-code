FROM ubuntu
MAINTAINER James Turnbull "james@example.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
ENV REFRESHED_AT 2013-08-07
RUN apt-get update
RUN apt-get -y install redis-server
CMD ["/usr/bin/redis-server"]

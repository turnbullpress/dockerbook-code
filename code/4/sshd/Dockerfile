FROM ubuntu:16.04
MAINTAINER James Turnbull "james@example.com"
ENV REFRESHED_AT 2016-06-01
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo "root:password" | chpasswd
EXPOSE 22

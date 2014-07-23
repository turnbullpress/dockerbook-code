# VERSION  0.0.1
FROM ubuntu:12.04
MAINTAINER James Turnbull "james@example.com"
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo "root:password" | chpasswd
EXPOSE 22

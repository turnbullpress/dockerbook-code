FROM ubuntu:14.04
MAINTAINER James Turnbull "james@example.com"
ENV REFRESHED_AT 2015-07-20

RUN apt-get update
RUN apt-get -y install redis-tools

ENTRYPOINT ["/usr/bin/redis-cli"]
CMD []

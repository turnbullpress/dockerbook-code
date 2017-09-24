FROM ubuntu:16.04
MAINTAINER James Turnbull "james@example.com"
ENV REFRESHED_AT 2014-06-01

RUN apt-get -qq update && apt-get -qq install redis-server redis-tools

EXPOSE 6379

ENTRYPOINT ["/usr/bin/redis-server" ]
CMD []

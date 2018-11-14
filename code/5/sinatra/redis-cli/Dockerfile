FROM ubuntu:18.04
LABEL maintainer="james@example.com"
ENV REFRESHED_AT 2015-07-20

RUN apt-get update
RUN apt-get -y install redis-tools

ENTRYPOINT ["/usr/bin/redis-cli"]
CMD []

FROM ubuntu:18.04
LABEL maintainer="james@example.com"
ENV REFRESHED_AT 2017-06-01

RUN apt-get -qq update
RUN apt-get install -qq software-properties-common
RUN add-apt-repository ppa:chris-lea/redis-server
RUN apt-get -qq update
RUN apt-get -qq install redis-server redis-tools

VOLUME [ "/var/lib/redis", "/var/log/redis" ]

EXPOSE 6379

CMD []

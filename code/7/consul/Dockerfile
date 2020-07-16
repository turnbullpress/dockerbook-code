FROM ubuntu:18.04
LABEL maintainer="james@example.com"
ENV REFRESHED_AT 2014-08-01

RUN apt-get -qq update
RUN apt-get -qq install curl unzip

ADD https://releases.hashicorp.com/consul/0.3.1/consul_0.3.1_linux_amd64.zip /tmp/consul.zip
RUN cd /usr/sbin && unzip /tmp/consul.zip && chmod +x /usr/sbin/consul && rm /tmp/consul.zip

RUN mkdir -p /webui/
ADD https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip /webui/webui.zip

RUN cd /webui; unzip webui.zip; rm webui.zip
ADD consul.json /config/

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp

VOLUME ["/data"]

ENTRYPOINT [ "/usr/sbin/consul", "agent", "-config-dir=/config" ]
CMD []

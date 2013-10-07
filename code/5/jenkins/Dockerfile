FROM ubuntu:14.04
MAINTAINER james@example.com
ENV REFRESHED_AT 2014-06-01

RUN echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-get update -qq
RUN apt-get install -qqy curl
RUN curl https://get.docker.io/gpg | apt-key add -
RUN apt-get update -qq
RUN apt-get install -qqy iptables ca-certificates lxc openjdk-6-jdk git-core lxc-docker

RUN mkdir -p /opt/jenkins/data/plugins
RUN curl -sf -o /opt/jenkins/jenkins.war -L http://mirrors.jenkins-ci.org/war/latest/jenkins.war
RUN curl -sf -o /opt/jenkins/data/plugins/chucknorris.hpi -L http://mirrors.jenkins-ci.org/plugins/chucknorris/latest/chucknorris.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/greenballs.hpi -L http://mirrors.jenkins-ci.org/plugins/greenballs/latest/greenballs.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/scm-api.hpi -L http://mirrors.jenkins-ci.org/plugins/scm-api/latest/scm-api.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git-client.hpi -L http://mirrors.jenkins-ci.org/plugins/git-client/latest/git-client.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git.hpi -L http://mirrors.jenkins-ci.org/plugins/git/latest/git.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/ws-cleanup.hpi -L http://mirrors.jenkins-ci.org/plugins/ws-cleanup/latest/ws-cleanup.hpi

ADD ./dockerjenkins.sh /usr/local/bin/dockerjenkins.sh
RUN chmod +x /usr/local/bin/dockerjenkins.sh
ENV JENKINS_HOME /opt/jenkins/data

VOLUME /var/lib/docker

EXPOSE 8080

ENTRYPOINT [ "/usr/local/bin/dockerjenkins.sh" ]

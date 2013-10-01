FROM ubuntu
MAINTAINER James Turnbull "james@example.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.lis
ENV REFRESHED_AT 2013-09-14
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools php5-mysql openssh-server sudo vim
RUN easy_install -q supervisor
ADD ./start.sh /start.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN rm -rf /var/www/
ADD http://wordpress.org/latest.tar.gz /wordpress.tar.gz
RUN tar xvzf /wordpress.tar.gz
RUN mv /wordpress /var/www/
RUN chown -R www-data:www-data /var/www/
RUN chmod 755 /start.sh
RUN mkdir /var/log/supervisor/
RUN mkdir /var/run/sshd
EXPOSE 80
EXPOSE 22
CMD ["/bin/bash", "/start.sh"]

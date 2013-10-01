#!/bin/bash

    if [ ! -f /var/www/wp-config.php ]; then
      SSH_USER=`echo $RANDOM`
      SSH_PASSWORD=`pwgen -c -n -1 18`
      mkdir /home/$SSH_USER
      useradd -G sudo -d /home/$SSH_USER $SSH_USER -s /bin/bash
      chown $SSH_USER /home/$SSH_USER
      echo $SSH_USER:$SSH_PASSWORD | chpasswd

      WORDPRESS_DB=${SSH_USER}_wordpress
      sed -e "s/database_name_here/$WORDPRESS_DB/
      s/username_here/$SSH_USER/
      s/password_here/$SSH_PASSWORD/
      s/wp_/$SSH_USER\_/
      /'AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
      /'SECURE_AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
      /'LOGGED_IN_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
      /'NONCE_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
      /'AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
      /'SECURE_AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
      /'LOGGED_IN_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
      /'NONCE_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/" /var/www/wp-config-sample.php > /var/www/wp-config.php
      chown www-data:www-data /var/www/wp-config.php

      /usr/bin/mysqld_safe &
      sleep 10s
      MYSQL_PASSWORD=`pwgen -c -n -1 18`
      mysqladmin -u root password $MYSQL_PASSWORD
      mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE $WORDPRESS_DB; GRANT ALL PRIVILEGES ON $WORDPRESS_DB.* TO '$SSH_USER'@'localhost' IDENTIFIED BY '$SSH_PASSWORD'; FLUSH PRIVILEGES;"
      killall mysqld
      sleep 10s
      echo ssh $SSH_USER password: $SSH_PASSWORD
      echo mysql root password: $MYSQL_PASSWORD
    fi

supervisord -c /etc/supervisord.conf -n

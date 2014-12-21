FROM ubuntu:14.04
MAINTAINER frism

# add application repository URL to the default sources
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty main universe" >> /etc/apt/sources.list

# update the repository
RUN apt-get update && \
    apt-get -y upgrade

# install basic tools
RUN apt-get install -y curl git vim nano wget dialog net-tools rsync

# install necessary tools
RUN apt-get install -y nginx mysql-server mysql-client php5-fpm php5-mysql

# install wordpress
ADD http://wordpress.org/latest.tar.gz /usr/share/nginx/latest.tar.gz
RUN cd /usr/share/nginx/ && tar xvf latest.tar.gz && rm latest.tar.gz
RUN mv /usr/share/nginx/html/5* /usr/share/nginx/wordpress
RUN rm -rf /usr/share/nginx/www
RUN mv /usr/share/nginx/wordpress /usr/share/nginx/www
ADD wp-config.php /usr/share/nginx/www/
RUN mkdir /usr/share/nginx/www/wp-content/uploads
RUN chown -R www-data:www-data /usr/share/nginx/www

# configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
ADD default.conf /etc/nginx/sites-available/default
ADD info.php /usr/share/nginx/www/info.php

# configure mysql
RUN mysql_install_db
  # to-do: create database_name, database_user, database_user_password

# expose ports
EXPOSE 80
EXPOSE 3306
EXPOSE 22

# starts the server
RUN echo 'service mysql start && php5-fpm' >> ~/.bashrc
CMD service nginx start

# clean up apt when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
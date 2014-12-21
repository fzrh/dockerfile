FROM ubuntu:14.04
MAINTAINER frism

# add application repository URL to the default sources
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty main universe" >> /etc/apt/sources.list

# update the repository
RUN apt-get update
RUN apt-get -y upgrade

# install basic tools
RUN apt-get install -y curl git vim nano wget dialog net-tools rsync

# install necessary tools
RUN apt-get install -y nginx mysql-server mysql-client php5-fpm php5-mysql

# configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
ADD default.conf /etc/nginx/sites-available/default
ADD info.php /usr/share/nginx/html/info.php

# configure mysql
RUN mysql_install_db

# expose ports
EXPOSE 80

# starts the server
RUN echo 'service mysql start && php5-fpm' >> ~/.bashrc
CMD service nginx start

# clean up apt when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
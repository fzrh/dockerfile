# Set the base image to Ubuntu
FROM ubuntu
MAINTAINER Faezrah Rizalman

# add application repository URL to the default sources
#RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list

# update the repository
RUN apt-get update

# install necessary tools
RUN apt-get install -y nano wget dialog net-tools rsync

# download and install nginx
RUN apt-get install -y nginx  

# nginx config
# append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# download and install php
RUN apt-get install -y php5-fpm php5-mysql

# php-fpm config
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

# nginx config (for php processor)
ADD default.conf /etc/nginx/sites-available/default.conf 

# download and install mysql
RUN apt-get install -y mysql-server mysql-client

# setup mysql
RUN mysql_install_db

# starting mysql service
#RUN /etc/init.d/mysqld start
#RUN /usr/bin/mysqld_safe

# Expose ports
EXPOSE 80
EXPOSE 3306

# Set the default command to execute
CMD service php5-fpm start && nginx

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

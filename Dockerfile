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
#RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

# nginx config (for php processor)
#RUN rm -v /etc/nginx/sites-available/default.conf
ADD default.conf /etc/nginx/sites-available/default.conf 

# Expose ports
EXPOSE 80

# Set the default command to execute
CMD service php5-fpm start && nginx

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

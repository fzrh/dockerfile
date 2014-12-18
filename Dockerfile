# Set the base image
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

# starts the container
CMD service nginx start

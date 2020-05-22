FROM ubuntu:18.04
LABEL maintainer="chikilov"

# common update
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends apt-utils
# php version
ARG PHP_VERSION=7.3

# ex : dev, stage, production
ARG ENV=dev

# util installation
RUN apt-get install --fix-missing -y curl git sudo net-tools wget vim

# php installation
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php${PHP_VERSION}-fpm
RUN apt-get install -y php${PHP_VERSION}-mbstring
RUN apt-get install -y php${PHP_VERSION}-curl
RUN apt-get install -y php${PHP_VERSION}-xml
RUN apt-get install -y php${PHP_VERSION}-mysql
RUN apt-get install -y php${PHP_VERSION}-bcmath

# nginx installation
RUN apt-get remove -y apache2
RUN add-apt-repository ppa:nginx/development
RUN apt-get update
RUN apt-get install -y nginx-full
RUN rm -rf /etc/nginx/sites-enabled/default

# mysql installation
RUN apt-get install -y mysql-server

# copy environment files
WORKDIR /home/ubuntu/apps
COPY php/${ENV}/php.ini /etc/php/${PHP_VERSION}/fpm/php.ini
COPY php/${ENV}/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
COPY nginx/${ENV}/fastcgi_params /etc/nginx/fastcgi_params
COPY nginx/${ENV}/sites-enabled /etc/nginx/sites-enabled

# file own change
RUN service mysql start; exit 0
RUN usermod -d /var/lib/mysql/ mysql
RUN chown -R mysql:mysql /var/lib/mysql
RUN mkdir /home/ubuntu/apps/current/logs

EXPOSE 80 3306

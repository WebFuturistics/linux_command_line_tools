#!/usr/bin/env bash
# Filename: ubuntu_lemp_1.sh
# Description: installs necessary packages to run LEMP successfully (warning: no SQL DB)
#
# Following packages will be installed:
#
# unzip
# git
# curl
# nginx
# openVPN
#
# language-pack-en-base
#
# php7.0 (from ppa:ondrej/php)
# php7.0-fpm
# php7-cli
# php7.0-mbstring
# php7.0-xml
# php7.0-curl
#
# composer

# resynchronize the package index files
apt-get update

# install utils
yes | apt-get install unzip

# install curl
yes | apt-get install curl

# install git
yes | apt-get install git

# install nginx
yes | apt-get install nginx

# install OpenVPN
yes | apt-get install openvpn

# install PHP7
yes | add-apt-repository ppa:ondrej/php
yes | apt-get install -y language-pack-en-base

yes | LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

apt-get update
yes | apt-get install php7.0
yes | apt-get install php7.0-fpm

# install PHP7 extensions
yes | apt-get install php7.0-mbstring
yes | apt-get install php7.0-xml
yes | apt-get install php7.0-curl

# install composer
yes | apt-get install php7-cli
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#1 Creo un usuario
adduser chundo &&
adduser chundo sudo

#2 Actualizar OS, instalar dependencias y ruby
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - &&
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &&
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list &&
sudo add-apt-repository ppa:chris-lea/redis-server &&
# ENTER
sudo apt-get update &&
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn 
sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev &&
# y

#3 Instalar rbenv

#4 Instalar Bundle  y Rails
gem install bundler &&
gem install bundler -v 1.17.3 &&
bundle -v

#5 Corrrer paquetes
rbenv rehash

#6 Instalar NGINX & Passenger
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 &&
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list' &&
sudo apt-get update &&
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger &&
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi &&
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

# Agregar ruby a passenger
which rbenv &&
sudo nano /etc/nginx/conf.d/mod-http-passenger.conf
# passenger_ruby /home/deploy/.rbenv/shims/ruby;

# Correr NGINX
sudo service nginx start

# Configuro NGINX 
sudo rm /etc/nginx/sites-enabled/default &&
sudo nano /etc/nginx/sites-enabled/myapp &&
sudo service nginx reload

# Creo la base de datos
sudo apt-get install postgresql postgresql-contrib libpq-dev
#y
sudo su - postgres
createuser --pwprompt chundo
createdb -O chundo ideardev
exit

# ENV
nano /home/chundo/ideardev/.rbenv-vars

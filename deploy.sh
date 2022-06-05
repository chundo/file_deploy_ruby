#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#1 Creo un usuario

# adduser deploy &&
# adduser deploy sudo &&

#2 Actualizar OS, instalar dependencias y ruby
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &&
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list &&
sudo add-apt-repository ppa:chris-lea/redis-server &&
sudo apt-get install -y nodejs yarn &&
sudo apt-get update &&
sudo apt-get install -y unzip &&
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn &&

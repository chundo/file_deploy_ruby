#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#1 Creo un usuario

#adduser deploy &&
#adduser deploy sudo &&

#2 Actualizar OS, instalar dependencias y ruby
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &&
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list &&
sudo add-apt-repository ppa:chris-lea/redis-server &&
sudo apt-get install -y nodejs yarn &&
sudo apt-get update &&
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn &&

#3 Instalar rbenv
rm *.zip &&
rm -r ~/.rbenv &&
rm -r rbenv-master &&

# git clone https://github.com/rbenv/rbenv.git ~/.rbenv &&
wget https://github.com/rbenv/rbenv/archive/refs/heads/master.zip  &&
unzip master.zip &&
mkdir ~/.rbenv &&
mv rbenv-master/* /root/.rbenv &&
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc &&
echo 'eval "$(rbenv init -)"' >> ~/.bashrc &&

# git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build &&
rm *.zip &&
rm -r ruby-build-master &&
wget https://github.com/rbenv/ruby-build/archive/refs/heads/master.zip &&
unzip master.zip &&
mkdir ~/.rbenv/plugins &&
mkdir ~/.rbenv/plugins/ruby-build &&
mv ruby-build-master/* ~/.rbenv/plugins/ruby-build &&
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc &&

# git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars &&
rm *.zip &&
rm -r rbenv-vars-master &&
wget https://github.com/rbenv/rbenv-vars/archive/refs/heads/master.zip &&
unzip master.zip &&
mkdir ~/.rbenv/plugins/rbenv-vars &&
mv rbenv-vars-master/* ~/.rbenv/plugins/rbenv-vars &&
exec $SHELL -l &&
exec $SHELL &&
sudo rbenv install 3.1.2 &&
sudo rbenv global 3.1.2 &&
ruby -v &&

#4 Instalar Bundle  y Rails
gem install bundler &&
gem install bundler -v 1.17.3 &&
bundle -v &&

#4 Installing NGINX & Passenger
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 &&
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'  &&
sudo apt-get update  &&
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger  &&
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi  &&
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf  &&
cp file_deploy_ruby-main/mod-http-passenger.conf  /etc/nginx/conf.d/ &&
sudo service nginx start &&
sudo rm /etc/nginx/sites-enabled/default &&
cp file_deploy_ruby-main/myapp /etc/nginx/sites-enabled/ &&
sudo service nginx reload

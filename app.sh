echo '----------Create User------------' &&
adduser deploy --disabled-password --gecos '' &&
adduser deploy sudo &&
echo '----------Create Dependences and update server------------' &&
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &&
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo add-apt-repository -y ppa:chris-lea/redis-server &&
sudo apt-get install -y nodejs yarn &&
sudo apt-get update &&
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn &&
yarn -v &&
echo '----------Installing Ruby------------' &&
git clone https://github.com/rbenv/rbenv.git ~/.rbenv &&
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc &&
echo 'eval "$(rbenv init -)"' >> ~/.bashrc &&
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build &&
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc &&
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars &&
exec $SHELL &&
rbenv install 3.1.2 &&
rbenv global 3.1.2 &&
ruby -v 


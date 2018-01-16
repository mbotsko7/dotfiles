#!/bin/bash

# PPAs
sudo add-apt-repository -y ppa:webupd8team/java

sudo apt update

# Install CURL for Ruby
sudo apt install -y curl libcurl3 libcurl3-gnutls libcurl4-openssl-dev

# Install postgres
sudo apt install -y postgresql postgresql-contrib

# Other requirements
sudo apt install -y libpq-dev
sudo apt install -y rabbitmq-server
sudo apt install -y redis-server

# Install Java
sudo apt install -y oracle-java8-installer

# Create project directories
mkdir ~/Code
cd ~/Code
git clone https://github.com/developmentarc/pedanco
git clone https://github.com/developmentarc/wopr-stats

# Install (just wget) elasticsearch 1.7.6
curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.6.tar.gz
tar -xvf elasticsearch-1.7.6.tar.gz
mv elasticsearch-1.7.6 elasticsearch
rm elasticsearch-1.7.6.tar.gz

# Install RVM and RVM for Fish
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash
curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish
echo "rvm default" >> ~/.config/fish/config.fish

# Install ruby-2.2.3
rvm install ruby-2.2.3
cd ~/Code/wopr-stats
gem install bundler
gem install foreman
bundle install

rvm install ruby-2.4.1
rvm --default use 2.4.1
cd ~/Code/pedanco
gem install bundler
gem install foreman
bundle install

cd ~

# Alias woprengine


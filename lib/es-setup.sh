#!/usr/bin/env bash

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get -y install git openjdk-7-jre-headless service-wrapper curl wget

sudo update-alternatives --set java /usr/lib/jvm/java-7-openjdk-i386/jre/bin/java

# Install tmux, vim, zsh, git, htop.
sudo apt-get -yq install tmux vim git-core zsh htop

# Install ElasticSearch.
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.5.list
sudo apt-get update && sudo apt-get install elasticsearch

chmod g+ws /etc/elasticsearch/
mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.bak
cp /home/vagrant/config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

# update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start

# Install Kibana.
# sudo apt-get update && sudo apt-get install kibana

# /etc/init.d/elasticsearch restart
# or service elasticsearch restart

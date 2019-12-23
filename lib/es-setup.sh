#!/usr/bin/env bash
# Setting ES version to install.
ES_VERSION="7.4.2"
ES_PLUGIN_INSTALL_CMD="/usr/share/elasticsearch/bin/plugin install "

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


# wget -nv "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION-amd64.deb"
# sudo dpkg -i "elasticsearch-$ES_VERSION-amd64.deb"

chmod g+ws /etc/elasticsearch/
mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.bak
cp /home/vagrant/config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

# update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start

# Holds ES plugins we want to install.
ES_PLUGINS=()

# Internal Plugins.
# ES_PLUGINS+=(com.github.kzwang/elasticsearch-image/1.2.0)
# ES_PLUGINS+=(elasticsearch/elasticsearch-mapper-attachments/2.4.2)

# Supervision/Dashboard ES plugins.
# ES_PLUGINS+=(mobz/elasticsearch-head)
# ES_PLUGINS+=(lukas-vlcek/bigdesk)
# ES_PLUGINS+=(elasticsearch/elasticsearch-analysis-icu/2.4.1)
# ES_PLUGINS+=(lmenezes/elasticsearch-kopf)
# ES_PLUGINS+=(royrusso/elasticsearch-HQ)
# ES_PLUGINS+=(elasticsearch/marvel/latest)

# Loop through and install ES plugins.
for P in ${ES_PLUGINS[*]}
do
	${ES_PLUGIN_INSTALL_CMD} $P
done

/etc/init.d/elasticsearch restart
# or service elasticsearch restart

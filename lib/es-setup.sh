#!/usr/bin/env bash
# Setting ES version to install.
ES_VERSION="2.4.1"
ES_PLUGIN_INSTALL_CMD="/usr/share/elasticsearch/bin/plugin install "

apt-get -yq update
apt-get -yq install git openjdk-7-jre-headless service-wrapper curl

update-alternatives --set java /usr/lib/jvm/java-7-openjdk-i386/jre/bin/java

# Install TMUX.
apt-get install tmux

# Install VIM.
apt-get install vim

# Install HTOP.
apt-get install htop

# Install ElasticSearch.
wget -nv https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/$ES_VERSION/elasticsearch-$ES_VERSION.deb
dpkg -i elasticsearch-$ES_VERSION.deb

mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.bak
cp /home/vagrant/config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start

# Holds ES plugins we want to install.
ES_PLUGINS=()

# Internal Plugins.
ES_PLUGINS+=(com.github.kzwang/elasticsearch-image/1.2.0)
ES_PLUGINS+=(elasticsearch/elasticsearch-mapper-attachments/2.4.2)

# Supervision/Dashboard ES plugins.
ES_PLUGINS+=(mobz/elasticsearch-head)
ES_PLUGINS+=(lukas-vlcek/bigdesk)
ES_PLUGINS+=(elasticsearch/elasticsearch-analysis-icu/2.4.1)
ES_PLUGINS+=(lmenezes/elasticsearch-kopf)
ES_PLUGINS+=(royrusso/elasticsearch-HQ)
ES_PLUGINS+=(elasticsearch/marvel/latest)

# Loop through and install ES plugins.
for P in ${ES_PLUGINS[*]}
do
	${ES_PLUGIN_INSTALL_CMD} $P
done

/etc/init.d/elasticsearch restart
# or service elasticsearch restart

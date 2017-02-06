# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	# Set the box IP address.
	box_ip = '10.0.0.11'
	config.vm.network :private_network, ip: "#{box_ip}"

	# Sync the configuration directory.
	config.vm.synced_folder "config", "/home/vagrant/config"

	# Run the ES setup script.
	config.vm.provision :shell, :path => "lib/es-setup.sh"

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	config.vm.box = "precise32"
	config.vm.box_url = "https://vagrantcloud.com/hashicorp/boxes/precise32/versions/1.0.0/providers/virtualbox.box"

	# Set the box IP address.
	box_ip = '10.0.0.11'
	config.vm.network :private_network, ip: "#{box_ip}"

	config.vm.provider 'virtualbox' do |vbox|
		vbox.customize ['modifyvm', :id, '--memory', 1024]
		vbox.customize ['modifyvm', :id, '--cpus', 1]
	end

	# Sync the configuration directory.
	config.vm.synced_folder "config", "/home/vagrant/config"

	# Run the ES setup script.
	config.vm.provision :shell, :path => "lib/es-setup.sh"

end

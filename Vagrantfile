# -*- mode: ruby -*-
# vi: set ft=ruby noexpandtab:

# Required plugin: vagrant-vbguest and vagrant-reload
# vagrant plugin install vagrant-vbguest
# vagrant plugin install vagrant-reload
#
# Do not forget to update plugins with command
# vagrant plugin update

# Define VM's spec
toolbox_node_cpu = "2"
toolbox_node_memory = "8192"

# Define download cmd
software_download_cmd="curl --connect-timeout 300 --retry 10 --retry-delay 10 --silent --insecure --location"

# Vagrantfile
Vagrant.configure("2") do |config|
	if Vagrant.has_plugin?("vagrant-vbguest")
		config.vbguest.auto_update = false
		config.vbguest.auto_reboot = true
	end

	config.vm.box = "macos-catalina"

	# Toolbox node
	config.vm.define "chezmoi" do |chezmoi|
		config.vm.provider "virtualbox" do |chezmoi|
			toolbox.gui = true
			toolbox.linked_clone = false
			toolbox.cpus = toolbox_node_cpu
			toolbox.memory = toolbox_node_memory
			toolbox.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
		end

		toolbox.vm.hostname = "chezmoi"
		toolbox.vm.provider :virtualbox do |chezmoi|
			toolbox.name = "chezmoi"
		end
	end
end

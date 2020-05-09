Vagrant.configure("2") do |config|
	config.vm.box = "generic/alpine38"

	config.vm.hostname = "webdevBox"
	config.vm.network "public_network", ip: "192.168.0.135"

	config.vm.synced_folder ".", "/vagrant/"
	config.vm.synced_folder "www/", "/www/"
	config.vm.synced_folder "sites-conf/", "/var/sites-conf/"

	config.vm.provider "virtualbox" do |vb|
		vb.memory = "2048"
	end

	config.vm.provision :shell, path: "installation.sh", privileged: true
	config.vm.provision :shell, path: "php_configure.sh", privileged: true
	config.vm.provision :shell, path: "bootstrap.sh", run: "always", privileged: true
end
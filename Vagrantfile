# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(2) do |config|

  # you can get away with smaller limits if you remove
  # the MAKE="make -j 8" in the setup scripts

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 3072
    vb.cpus = 2
  end

  config.vm.box = "ubuntu/trusty64"

  config.vm.box_check_update = false

  # change the host port if you have multiple instances running on the same box
  config.vm.network "forwarded_port", guest: 3838, host: 3838

  config.vm.provision "shell", path: "setup_base.sh"
  config.vm.provision "shell", path: "setup_custom.sh"
  config.vm.provision "shell", path: "update_pkg.sh", run: "always"

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.provider :virtualbox do |v|
    v.memory = 2048
    # https://github.com/hashicorp/vagrant/issues/11777
    # uncomment the following 2 lines if you use focal lts
    # v.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
    # v.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
  end
  config.vm.provision :shell, inline: "sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime", run: "always"
  config.vm.provision :shell, inline: "apt update && apt install -qy ansible"
  config.vm.box = "ubuntu/bionic64"
  # uncomment the following 2 lines to define a public network (bridge)
  #config.vm.network "public_network",
  #  use_dhcp_assigned_default_route: true
  config.vm.synced_folder "share/", "/opt/share", create: true
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 443, host: 8081, auto_correct: true
  #config.vm.network "forwarded_port", guest: 9090, host: 9090, auto_correct: true
  #config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  #config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true

  config.vm.provision :ansible_local do |ansible|
    ansible.become         = true
    ansible.playbook       = "provisioning/seedbox.yml"
    ansible.verbose        = true
    ansible.install        = true

  end


  config.vm.provision "shell", path: "provisioning/config_docker.sh"

end

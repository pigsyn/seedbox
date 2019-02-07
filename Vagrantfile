# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.synced_folder "share/", "/opt/share", create: true
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 443, host: 8081, auto_correct: true

  config.vm.provision :ansible_local do |ansible|
    ansible.become = true
    ansible.playbook       = "provisioning/seedbox.yml"
    ansible.verbose        = true
    ansible.install        = true

  end

  config.vm.provision "shell", inline: <<-SHELL
    torrent_uid=$(grep torrent /etc/passwd|cut -d ':' -f 3)
	sed -i "s/1001/${torrent_uid}/g" /root/docker-compose.yml
    docker-compose -f /root/docker-compose.yml up -d
  SHELL
end

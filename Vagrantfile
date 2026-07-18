Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.box_check_update = false

    # Image Registry
  config.vm.define "registry" do |registry|
    registry.vm.box = "almalinux/9"
    registry.vm.hostname = "registry.do180.lab"

    registry.vm.network "private_network", ip: "192.168.88.5", virtualbox__intnet: "188net"

    registry.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"

    if Vagrant.has_plugin?("vagrant-vbguest")
      registry.vbguest.auto_update = false
    end
    registry.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end

    registry.vm.provision :shell, :inline => <<-SHELL
      sed -i -E 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null
      echo 'vagrant:vagrant' | chpasswd
      systemctl restart sshd
    SHELL
    registry.vm.provision :shell, :inline => "yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y; sudo yum install -y sshpass ansible"

  end
  
  # Workstation
  config.vm.define "workstation" do |workstation|
    workstation.vm.box = "almalinux/9"
    workstation.vm.hostname = "workstation.do180.lab"

    workstation.vm.network "private_network", ip: "192.168.88.4", virtualbox__intnet: "188net"

    workstation.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"

    if Vagrant.has_plugin?("vagrant-vbguest")
      workstation.vbguest.auto_update = false
    end
    workstation.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end

    workstation.vm.provision :shell, :inline => <<-SHELL
      sed -i -E 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null
      echo 'vagrant:vagrant' | chpasswd
      systemctl restart sshd
    SHELL
    workstation.vm.provision :shell, :inline => "yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y; sudo yum install -y sshpass ansible"

    workstation.vm.provision :ansible_local do |ansible|
      ansible.playbook = "/vagrant/playbooks/master.yml"
      ansible.install = false
      ansible.compatibility_mode = "2.0"
      ansible.inventory_path = "/vagrant/inventory"
      ansible.config_file = "/vagrant/ansible.cfg"
      ansible.limit = "all"
  end
end
end

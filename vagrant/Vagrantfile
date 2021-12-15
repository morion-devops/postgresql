Vagrant.configure("2") do |config|

  config.vm.define "postgres-master" do |server|
    server.vm.box = "debian/bullseye64"
    server.vm.hostname = "postgres-master"
    server.vm.network "private_network", ip: "192.168.121.105"
    server.vm.synced_folder '.', '/vagrant', disabled: true # disable default binding

    server.vm.provider :libvirt do |domain|
      domain.memory = 600
      domain.cpus = 1
    end
  end

  config.vm.define "postgres-node1" do |server|  
    server.vm.box = "debian/bullseye64"
    server.vm.hostname = "postgres-node1"
    server.vm.network "private_network", ip: "192.168.121.106"
    server.vm.synced_folder '.', '/vagrant', disabled: true # disable default binding

    server.vm.provider :libvirt do |domain|
      domain.memory = 600
      domain.cpus = 1
    end
  end

end
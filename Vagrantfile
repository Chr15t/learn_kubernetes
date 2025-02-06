Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  # Configuration générale pour éviter les doublons
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Machine "masterrr"
  config.vm.define "masterrr" do |master|
    master.vm.hostname = "masterrr"
    master.vm.network "private_network", ip: "192.168.56.10"
  end

  # Machine "worker"
  config.vm.define "worker" do |worker|
    worker.vm.hostname = "worker"
    worker.vm.network "private_network", ip: "192.168.56.11"
  end
end

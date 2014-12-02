$script = <<SCRIPT
groupadd docker
gpasswd -a vagrant docker
cp /vagrant/admiral /usr/local/bin
cp /vagrant/*.sh /home/vagrant/
cp /vagrant/README /home/vagrant/
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get -y update
apt-get -y --force-yes install lxc-docker
SCRIPT


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provision "shell", inline: $script
end

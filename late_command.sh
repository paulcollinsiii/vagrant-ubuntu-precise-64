#!/bin/bash

# passwordless sudo
echo "%sudo   ALL=NOPASSWD: ALL" >> /etc/sudoers

# public ssh key for vagrant user
mkdir /home/vagrant/.ssh
wget -O /home/vagrant/.ssh/authorized_keys "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub"
chmod 755 /home/vagrant/.ssh
chmod 644 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# speed up ssh
echo "UseDNS no" >> /etc/ssh/sshd_config

# get chef
gem install chef --no-rdoc --no-ri

# Install a modern version of puppet and puppet-librarian
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update
apt-get install -y puppet git
gem install librarian-puppet

# display login promt after boot
sed "s/quiet splash//" /etc/default/grub > /tmp/grub
mv /tmp/grub /etc/default/grub
update-grub

# clean up
apt-get clean

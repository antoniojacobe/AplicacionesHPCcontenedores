#!/bin/bash -e

configure_hosts_file ()
{
sudo tee /etc/hosts<<EOF
192.168.56.30 node-01
192.168.56.31 node-02
EOF
}

configure_ssh()
{
sudo apt-get -y install sshpass

# SSH Key Pair 
yes y | ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa

# usuario 900 es vagrant
sudo chown 900:900 /home/vagrant/.ssh/id*
}

install_openmpi()
{
sudo apt-get update
sudo apt-get -y install openmpi-bin	
}

configure_hosts_file
configure_ssh
install_openmpi

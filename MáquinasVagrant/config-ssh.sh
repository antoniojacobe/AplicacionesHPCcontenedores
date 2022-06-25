#!/bin/bash -e

if [ "$HOSTNAME" = "node-01" ]; 
then 
    echo "ssh-keyscan node-01"	
    ssh-keyscan -4 -t rsa node-02 >>/home/vagrant/.ssh/known_hosts
    echo "ssh-copy-id node-01"
    sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub "vagrant@node-02"
fi

if [ "$HOSTNAME" = "node-02" ]; 
then 
    echo "ssh-keyscan node-02"	
    ssh-keyscan -4 -t rsa node-01 >>/home/vagrant/.ssh/known_hosts
    echo "ssh-copy-id node-02"
    sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub "vagrant@node-01"
fi

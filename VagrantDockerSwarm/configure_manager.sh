#!/bin/bash -e

sudo docker swarm init --listen-addr 172.16.8.10:2377 --advertise-addr 172.16.8.10:2377
sudo docker swarm join-token --quiet worker > /vagrant/worker_token
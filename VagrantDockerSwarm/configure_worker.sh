#!/bin/bash -e

echo Uniendo worker al manager...
sudo docker swarm join --token $(cat /vagrant/worker_token) 172.16.8.10:2377
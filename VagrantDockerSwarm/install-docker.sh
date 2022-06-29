#!/bin/bash -e

echo Instalando Docker...
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

#!/bin/bash

#Insync
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
echo "deb http://apt.insynchq.com/ubuntu xenial non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list
sudo apt-get update
sudo apt-get --yes --force-yes install insync

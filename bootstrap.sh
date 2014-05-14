#!/bin/bash

apt-get update
apt-get install puppet -y --quiet

rm -rf /etc/puppet/manifests

ln -s /home/vagrant/manifests /etc/puppet/manifests

service puppet restart

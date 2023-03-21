#!/bin/bash

# Install Exim
sudo apt-get update
sudo apt-get install exim4 -y

# Configure Exim
sudo sed -i 's/dc_eximconfig_configtype=.*/dc_eximconfig_configtype=\'internet\'/g' /etc/exim4/update-exim4.conf.conf
sudo sed -i 's/dc_local_interfaces=.*/dc_local_interfaces=\'\'/g' /etc/exim4/update-exim4.conf.conf
sudo sed -i 's/dc_readhost=.*/dc_readhost=\'$HOSTNAME\'/g' /etc/exim4/update-exim4.conf.conf
sudo sed -i 's/dc_relay_domains=.*/dc_relay_domains=\'*\'/g' /etc/exim4/update-exim4.conf.conf
sudo sed -i 's/dc_minimaldns=.*/dc_minimaldns=\'false\'/g' /etc/exim4/update-exim4.conf.conf
sudo sed -i 's/dc_relay_nets=.*/dc_relay_nets=\'\'/g' /etc/exim4/update-exim4.conf.conf
sudo sed -i 's/dc_smarthost=.*/dc_smarthost=\'\'/g' /etc/exim4/update-exim4.conf.conf

# Restart Exim
sudo service exim4 restart

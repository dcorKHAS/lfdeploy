#!/bin/bash

# Install Exim4
apt update
apt install exim4 -y

# Generate Exim4 configuration
dpkg-reconfigure exim4-config

# Backup original Exim4 configuration
cp /etc/exim4/update-exim4.conf.conf /etc/exim4/update-exim4.conf.conf.orig

# Configure Exim4 to listen on all interfaces and send mail directly
sed -i 's/dc_eximconfig_configtype=.*/dc_eximconfig_configtype="internet"/' /etc/exim4/update-exim4.conf.conf
sed -i 's/dc_other_hostnames=.*/dc_other_hostnames="localhost"/' /etc/exim4/update-exim4.conf.conf
sed -i 's/dc_local_interfaces=.*/dc_local_interfaces='\\''0.0.0.0'\\''/' /etc/exim4/update-exim4.conf.conf
sed -i 's/dc_readhost=.*/dc_readhost='\\'''/ /etc/exim4/update-exim4.conf.conf
sed -i 's/dc_smarthost=.*/dc_smarthost='\\'''/ /etc/exim4/update-exim4.conf.conf
sed -i 's/dc_use_split_config=.*/dc_use_split_config='\\''false'\\''/' /etc/exim4/update-exim4.conf.conf

# Apply Exim4 configuration
update-exim4.conf

# Restart Exim4
systemctl restart exim4.service

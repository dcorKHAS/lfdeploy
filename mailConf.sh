#!/bin/bash

apt-get update
apt-get install -y exim4

sed -i 's/dc_eximconfig_configtype=.*/dc_eximconfig_configtype=\'internet\'/' /etc/exim4/update-exim4.conf.conf
sed -i 's/dc_local_interfaces=.*/dc_local_interfaces=\'0.0.0.0\'/' /etc/exim4/update-exim4.conf.conf

hostname=$(hostname)

sed -i "s/dc_relay_domains=.*/dc_relay_domains=\'$hostname:localhost\'/" /etc/exim4/update-exim4.conf.conf
sed -i "s/dc_other_hostnames=.*/dc_other_hostnames=\'$hostname\'/" /etc/exim4/update-exim4.conf.conf

update-exim4.conf
service exim4 restart

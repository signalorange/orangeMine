#!/bin/bash
source .env
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo iptables -I FORWARD -s ${SUBNET4} -j ACCEPT
sudo iptables -I FORWARD -d ${SUBNET4} -j ACCEPT
sudo iptables -A FORWARD -i ${ETH1} -o ${ETH2} -j ACCEPT
sudo iptables -A FORWARD -i ${ETH2} -o ${ETH1} -m state --state RELATED,ESTABLISHED -j ACCEPT
wget "https://gitlab.isc.org/isc-projects/kea/raw/Kea-$(echo "${KEA_VERSION}" | cut -d '.' -f 1).$(echo "${KEA_VERSION}" | cut -d '.' -f 2).$(echo "${KEA_VERSION}" | cut -d '.' -f 3)/src/share/database/scripts/pgsql/dhcpdb_create.pgsql" -O ./initdb/dhcpdb_create.sql
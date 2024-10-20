#!/bin/bash
source .env

# Enable routing on host
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf

# Add a routing table
echo "200 wg_route" | sudo tee -a /etc/iproute2/rt_tables
sudo ip route add default dev wg0 table wg_route
sudo ip rule add from 10.13.13.0/24 table wg_route
sudo ip route add default via ${ETH2_IP} dev ${ETH2} metric 100

# Edit iptables
sudo iptables -I FORWARD -s ${SUBNET4} -j ACCEPT
sudo iptables -I FORWARD -d ${SUBNET4} -j ACCEPT
sudo iptables -A FORWARD -i ${ETH1} -o ${ETH2} -j ACCEPT
sudo iptables -A FORWARD -i ${ETH2} -o ${ETH1} -m state --state RELATED,ESTABLISHED -j ACCEPT

# Set Up NAT
sudo iptables -t nat -A POSTROUTING -o ${ETH2} -j MASQUERADE


# Download Kea db template
wget "https://gitlab.isc.org/isc-projects/kea/raw/Kea-$(echo "${KEA_VERSION}" | cut -d '.' -f 1).$(echo "${KEA_VERSION}" | cut -d '.' -f 2).$(echo "${KEA_VERSION}" | cut -d '.' -f 3)/src/share/database/scripts/pgsql/dhcpdb_create.pgsql" -O ./initdb/dhcpdb_create.sql
sudo apt install openssh-server curl
## install tailscale
curl -fsSL https://tailscale.com/install.sh | sh
#activate route in tailscale web admin

## apt
sudo apt update
sudo apt install openssh-server curl wget ethtool net-tools autoconf iptables-persistent traceroute msmtp-mta mailutils clamav clamav-daemon build-essential coreutils htop ncdu python3 rsync unattended-upgrades apt-listchanges apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce
sudo apt upgrade
sudo snap remove docker

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

## set boot wait
sudo nano /etc/default/grub
# GRUB_RECORDFAIL_TIMEOUT=5
sudo update-grub

## install orangeMine
git clone https://github.com/signalorange/orangeMine
cd orangeMine

# configure orangeMine
cp example.env .env
cp wireguard/wg0.conf-example wireguard/wg0.conf
cp kea/kea-dhcp.conf-example kea/kea-dhcp.conf
source .env

## configure host interface LAN
sudo ip addr add ${GATEWAY4}/24 dev ${ETH1}
sudo ip link set dev ${ETH1} up

## enable routing
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -p /etc/sysctl.conf
sudo sysctl -w net.ipv4.conf.all.src_valid_mark=1 #for wireguard

## configure tailscale
sudo tailscale up --advertise-routes=${SUBNET4} --accept-routes
NETDEV=$(ip route show 0/0 | cut -f5 -d' ')
sudo ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off
printf '#!/bin/sh\n\nethtool -K %s rx-udp-gro-forwarding on rx-gro-list off \n' "$(ip route show 0/0 | cut -f5 -d" ")" | sudo tee /etc/networkd-dispatcher/routable.d/50-tailscale
sudo chmod 755 /etc/networkd-dispatcher/routable.d/50-tailscale

## disable systemd-resolved (orignial DNS)
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved

## edit resolver to point to cloudflared
sudo nano /etc/systemd/resolved.conf
#DNS=127.0.0.1
#DNSStubListener=no

## restart systemd-resolver
sudo systemctl start systemd-resolved
sudo systemctl enable systemd-resolved

# start services
#docker compose up -d
./setup.sh

# test services
./tests/dns.sh
./tests/wg.sh

# Disable apparmor ?
sudo systemctl stop apparmor
sudo systemctl disable apparmor

# Setup crontab to start setup.sh on boot
(sudo crontab -l 2>/dev/null || true; echo "@reboot cd $(pwd) && ./setup.sh y") | sudo crontab -

# format the nvme disk
# list disks
sudo fdisk -l
sudo mkfs.ext4 /dev/nvme0n1
# mount the disk
sudo mkdir /bitcoin
sudo mount /dev/nvme0n1 /bitcoin
# add to fstab
sudo nano /etc/fstab
# /dev/nvme0n1 /bitcoin ext4 defaults 0 0

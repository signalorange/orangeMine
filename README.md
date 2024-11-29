# orangeMine
![orangeMine Logo](image.png?raw=true "Logo")
orangeMine is a comprehensive software stack designed to empower bitcoin mine operators by giving them full control over their mining machines and configurations. Tailored for both professionals and plebs, orangeMine simplifies the setup, management, and monitoring of mining operations, making it easy to run efficient and autonomous mines. Its user-friendly interface and powerful tools ensure that anyone can set up and manage a mining operation, whether it's a small home setup or a larger industrial site. 

In the future, orangeMine will integrate seamlessly into orangeOS, a bitcoin-focused OS for small and medium businesses.

# Features
- Docker Compose based for easy deployment
- DHCP & DNS Server (Kea, DoH)
- Wireguard VPN for LAN traffic
- Tailscale container for remote access
- pyasic FastAPI Bridge
- PETAL control center (config, dashboards)
- OCEAN pool
- DATUM Gateway
- BTC Node (Knots) with automatic prune
- Lightning Node (OCEAN Payout)
- VPN & Tor tunnel for all the mine traffic
- Fail2Ban & Firewall

# Setup

## Prerequisites

- Two ETH interfaces
- Ubuntu 24.04 LTS
- Docker
- Docker Compose

## Configuration

1. Clone the repository:

2. Copy the exmaple files:
  - `cp example.env .env`
  - `cp kea/kea-dhcp4.conf kea/kea-dhcp4.conf-example`
  - `cp wireguard/wg0.conf-example wireguard/wg0.conf` or copy your WG config file

3. Edit the .env file to configure the services
4. Edit the `kea/kea-dhcp4.conf` file to configure the DHCP server
5. Edit the `bind/named.conf.options` file to configure the DNS server
6. run setup.sh
7. Run `docker-compose up -d` to start the services


# TODO

### Networking:

- [x] Setup Nat with dynamic docker interface
- [x] Save routes and iptables
- [x] Implement a working kea dhcp server
- [x] Add a Stork webserver
- [x] Implement a working dns-over-https/tls proxy
- [x] Implement a working wireguard vpn
- [x] Make all LAN (ETH1), Containers & Host traffic go through the VPN (ETH2)
- [x] Implement a working tailscale server for remote access
- [x] Investigate a VPN failover solution
- [x] Investigate a DNS-Over-Https failover solution
- [ ] Implement a fail2ban or other firewall (ETH2)
- [ ] Improve performance and security with an ipvlan/macvlan networking
- [ ] Add network traffic monitoring and bandwidth management
- [ ] Add a speedtest monitoring tool
- [ ] Email report if external IP is different than WG_ENDPOINT
- [ ] UptimeKuma for monitoring services

### Config/Housekeeping:

- [ ] Cleanup the configuration files
- [ ] Implement a more stable configuration/start process
- [ ] Document .env and other functions
- [x] find a way to easily split between hybrid (every services) and split (clients and control-center) easily -> Harvest/Orchard
- [ ] Implement a backup system
- [ ] Add automated database backups for Kea DHCP
- [ ] Add automated health checks for all services
- [x] build docker images for kea & stork
- [ ] List working features and future ones in the READNME.md

### Services and Features:

- [ ] Create an om-control-center PETAL webserver (to installl, configure, monitor, and manage the services) -> Harvest
- [x] Create a pyasic FastAPI bridge
- [ ] Implement a DATUM Gateway container -> docker-datum-gateway
- [ ] Create a sensors FastAPI/Phoenix container
- [ ] Implement a Prometheus/Grafana exporter
- [ ] GPS/GIS location tracking
- [ ] Electricty cost module (Add integration with power grid APIs for dynamic pricing)
- [ ] Temperature monitoring (inside and outside)
- [ ] Weather monitoring

### Harvest ideas (local client):

- [ ] Add power consumption optimization module
- [ ] Implement automated firmware management for miners
- [ ] Implement real-time hash rate optimization
- [ ] Create automated emergency shutdown procedures
- [ ] Add dynamic overclocking based on environmental conditions
- [ ] Implement automated ROI calculator per machine/rack
- [ ] Set up automated reboot scheduling based on performance metrics


## Orchard ideas (remote control center):

- [ ] Create an alert system for network/miner issues
- [ ] Create a maintenance scheduling system
- [ ] Add multi-site management capabilities
- [ ] Create automated reporting system for operations
- [ ] Implement predictive maintenance based on performance metrics
- [ ] Set up inventory management for spare parts
- [ ] Create maintenance log system with photo documentation

# Resources

- https://www.linuxserver.io/blog/routing-docker-host-and-container-traffic-through-wireguard
- https://stork.readthedocs.io/en/latest/install.html
- https://one.one.one.one/help/
- https://github.com/linuxserver/docker-wireguard
- https://github.com/JonasAlfredsson/docker-kea
- https://gitlab.isc.org/isc-projects/kea-docker/-/tree/master/kea-compose?ref_type=heads
- https://arstechnica.com/information-technology/2024/10/finally-upgrading-from-isc-dhcp-server-to-isc-kea-for-my-homelab/?comments-page=1#comments
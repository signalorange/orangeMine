# orangeMine
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
  - `cp kea/kea-dhcp4-example.conf kea/kea-dhcp4.conf`
  - `cp wireguard/wg0.conf-example wireguard/wg0.conf` or copy your WG config file

3. Edit the .env file to configure the services
4. Edit the `kea/kea-dhcp4.conf` file to configure the DHCP server
5. Edit the `bind/named.conf.options` file to configure the DNS server
6. run setup.sh
7. Run `docker-compose up -d` to start the services


# TODO

[ ] Implement a working kea dhcp server
[ ] Implement a working dns-over-https proxy
[ ] Implement a working wireguard vpn
[ ] MAke all LAN, Containers & Host traffic go through the VPN
[ ] Implement a working tailscale server for remote access
[ ] Add a Stork kea webserver
[ ] Cleanup the configuration files
[ ] Investigate a VPN failover solution
[ ] Investigate a DNS-Over-Https failover solution
[ ] Create an om-control-center PETAL webserver (to installl, configure, monitor, and manage the services)
[ ] Create a pyasic FastAPI bridge
[ ] Implement a fail2ban or other firewall
[ ] Implement a DATUM Gateway container
[ ] Create a sensors FastAPI container
[ ] Implement a Prometheus/Grafana exporter
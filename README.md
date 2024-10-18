# orangeMine
orangeMine is a comprehensive software stack designed to empower bitcoin mine operators by giving them full control over their mining machines and configurations. Tailored for both professionals and plebs, OrangeMine simplifies the setup, management, and monitoring of mining operations, making it easy to run efficient and autonomous mines. Its user-friendly interface and powerful tools ensure that anyone can set up and manage a mining operation, whether it's a small home setup or a larger industrial site. 

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

- Ubuntu 24.04 LTS
- Docker
- Docker Compose

## Configuration

1. Clone the repository:

2. Copy the exmaple files:
  - `cp example.env .env`
  - `cp kea/kea-dhcp4-example.conf kea/kea-dhcp4.conf`
  - `cp wireguard/wg0-example.conf wireguard/wg0.conf` or copy your WG config file

3. Edit the .env file to configure the services
4. Edit the `kea/kea-dhcp4.conf` file to configure the DHCP server
5. Edit the `bind/named.conf.options` file to configure the DNS server
6. run setup.sh
7. Run `docker-compose up -d` to start the services

#!/bin/bash
source .env
# IP to test (Google DNS)
TEST_IP="8.8.8.8"

# Interface for WireGuard
WG_INTERFACE=$(ip -br addr | grep "172.20.0.1" | awk '{print $1}')

# Fallback interface (eth2)
FALLBACK_INTERFACE=${ETH2}

# Check if WireGuard VPN is up by pinging through wg0
ping -I $WG_INTERFACE -c 2 $TEST_IP > /dev/null 2>&1

if [ $? -eq 0 ]; then
    # VPN is up, ensure default route through wg0 is set
    # ip route add default dev $WG_INTERFACE table wg_route 2>/dev/null
    echo "WG is up"
    echo "Traceroute:"
    traceroute google.com
    echo "IP: $(curl ifconfig.me)"
else
    # VPN is down, remove WireGuard route and fall back to eth2
    # ip route del default dev $WG_INTERFACE table wg_route 2>/dev/null
    echo "WG is down"
    echo "Traceroute:"
    traceroute google.com
    echo "IP: $(curl ifconfig.me)"
fi

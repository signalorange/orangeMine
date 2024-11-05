#!/bin/bash
set -e

# Your script logic here
echo "Container is starting..."

# You can still use CMD arguments
exec "$@"

# Start the Kea Control Agent
kea-ctrl-agent -c /etc/kea/kea-ctrl-agent.conf &

# Start the Stork Agent
stork-agent --use-env-file --env-file=/etc/stork/agent.env &

# Start the Kea DHCP server
kea-dhcp4 -c /etc/kea/kea-dhcp4.conf
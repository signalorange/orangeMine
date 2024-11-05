# Base image with Debian
FROM ubuntu:24.04

# Install system dependencies
RUN apt-get update \
    && apt-get install -y curl gnupg python3 python3-venv \
    && curl -1sLf 'https://dl.cloudsmith.io/public/isc/kea-2-6/setup.deb.sh' | bash \
    && curl -1sLf 'https://dl.cloudsmith.io/public/isc/stork/cfg/setup/bash.deb.sh' | bash \
    && apt-get update \
    && apt-get install -y isc-kea isc-stork-agent \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/lib/stork-agent/hooks

COPY config/agent.env /etc/stork/agent.env
# Start Stork server
#RUN stork-agent --use-env-file --env-file=/etc/stork/agent.env &

COPY config/*.conf /etc/kea/*.conf

#RUN kea-ctrl-agent -c /etc/kea/kea-ctrl-agent.conf &
#CMD ["kea-ctrl-agent", "-c", "/etc/kea/kea-ctrl-agent.conf"]

COPY config/start.sh /start.sh
RUN chmod +x start.sh
#CMD ["kea-dhcp4", "-c", "/etc/kea/kea-dhcp4.conf"]
#CMD ["kea-ctrl-agent", "-c", "/etc/kea/kea-ctrl-agent.conf"]
ENTRYPOINT ["/start.sh"]
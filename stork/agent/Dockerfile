# Base image with Debian
FROM ubuntu:24.04

# Install system dependencies
RUN apt-get update \
    && apt-get install -y curl gnupg python3 python3-venv \
    && curl -1sLf 'https://dl.cloudsmith.io/public/isc/stork/cfg/setup/bash.deb.sh' | bash \
    && apt-get update \
    && apt-get install isc-stork-agent \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/lib/stork-server/hooks

COPY agent.env /etc/stork/agent.env
# Start Stork server
CMD ["stork-agent", "--use-env-file", "--env-file=/etc/stork/agent.env"]
# Base image with Debian
FROM ubuntu:24.04

# Install system dependencies
RUN curl -1sLf 'https://dl.cloudsmith.io/public/isc/stork/cfg/setup/bash.deb.sh' | sudo bash
RUN apt-get update 
RUN apt-get install isc-stork-agent \
    && rm -rf /var/lib/apt/lists/*

COPY agent.env /etc/stork/agent.env
# Start Stork server
CMD ["stork-agent", "--use-env-file=/etc/stork/agent.env"]
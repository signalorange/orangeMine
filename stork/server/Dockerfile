# Base image with Debian
FROM ubuntu:24.04

# Install system dependencies
RUN curl -1sLf 'https://dl.cloudsmith.io/public/isc/stork/cfg/setup/bash.deb.sh' | sudo bash
RUN apt-get update 
RUN apt-get install isc-stork-server
    && rm -rf /var/lib/apt/lists/*

COPY stork-server.env /etc/stork/server.env
# Start Stork server
CMD ["stork-server", "--use-env-file=/etc/stork/server.env"]
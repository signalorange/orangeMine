# Base image with Debian
FROM ubuntu:24.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    wget \
    git \
    build-essential \
    golang \
    rake \
    ruby-dev \
    python3 \
    python3-venv \
    python3-sphinx-rtd-theme \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Install Rake
RUN gem install rake

# Set working directory
WORKDIR /stork

# Clone Stork repository
RUN git clone https://gitlab.isc.org/isc-projects/stork.git . && \
    git checkout v1.19.0

# Install backend dependencies and build
RUN rake build 
RUN rake install:server DEST=/home/user/stork

# Create necessary directories
RUN mkdir -p /var/lib/stork

# Copy configuration
#COPY stork-server.env /etc/stork/server.env

# Expose ports
EXPOSE 8080

# Set environment variables
ENV STORK_DATABASE_HOST=localhost \
    STORK_DATABASE_PORT=5432 \
    STORK_DATABASE_NAME=stork \
    STORK_DATABASE_USER_NAME=stork \
    STORK_DATABASE_PASSWORD=stork

# Start Stork server
CMD rake run:server
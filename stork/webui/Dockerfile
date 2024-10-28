# webui/Dockerfile
FROM node:18

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /stork

# Clone Stork repository
RUN git clone https://gitlab.isc.org/isc-projects/stork.git . && \
    git checkout v1.15.1


RUN rake build && \
    rake install:server
    
# Install and build frontend
WORKDIR /stork/webui
RUN npm install && \
    npm run build

# Install serve to host the built files
RUN npm install -g serve

# Expose UI port
EXPOSE 3000

# Start the UI server
CMD serve -s dist -l 3000
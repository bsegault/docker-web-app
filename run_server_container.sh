#!/bin/bash

set -euo pipefail
set -x


# Build image and name it bsegault/docker-http
# We tag it so we now what's inside without inspecting
docker build -t bsegault/docker-http:03_simple .

# -d: Run the container in detached mode
# -p: Map host port 8080 to container port 80
# Better: --name: give a name to the container to manage it
# Better: Start the image as a program: possible to give it arguments that must be documented
docker run -d \
    -p 8080:80 \
    --name docker_http \
    bsegault/docker-http:03_simple 2048

# Wait a bit
sleep 1

# Test it
curl http://localhost:8080

# Better: cleanup!
docker rm -f docker_http

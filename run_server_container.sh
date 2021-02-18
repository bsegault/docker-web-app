#!/bin/bash

set -euo pipefail
set -x


# Build image and name it bsegault/docker-http
# We tag it so we now what's inside without inspecting
docker build -t bsegault/docker-http:04_smart_env .

# -d: Run the container in detached mode
# -p: Map host port 8080 to container port 80
# --name: give a name to the container to manage it
# Better: --env: give options by env: no need to know the arguments taken by the app; we have the meaning by variable name
#   No need to even document the program, just detail env vars.
docker run -d \
    -p 8080:80 \
    --name docker_http \
    --env MAX_HEADER_SIZE=4096 \
    bsegault/docker-http:04_smart_env

# Wait a bit
sleep 1

# Test it
curl http://localhost:8080

# Cleanup!
docker rm -f docker_http

#!/bin/bash

set -euo pipefail
set -x


# Build image and name it bsegault/docker-http
# We tag it so we now what's inside without inspecting
docker build -t bsegault/docker-http:05_smarter_volumes .

# -d: Run the container in detached mode
# -p: Map host port 8080 to container port 80
# --name: give a name to the container to manage it
# --env: give options by env: no need to know the arguments taken by the app; we have the meaning by variable name
#   No need to even document the program, just detail env vars.
# Better: --mount: We can inspect logs by reading bind mount. Take care to re-use pre-defined bind mounts.
#   Here we mount it to a folder in source tree: take care to add this folder to .dockerignore
# Give log file location in bind mount as program argument:
#   Here we could argue that this should be part of the environment. This will be kept to illustrate various use-cases later on.
docker run -d \
    -p 8080:80 \
    --name docker_http \
    --env MAX_HEADER_SIZE=4096 \
    --mount "type=bind,src=${PWD}/logs,dst=/var/logs" \
    bsegault/docker-http:05_smarter_volumes --log-file /var/logs/docker_http.log

# Wait a bit
sleep 1

# Test it
curl http://localhost:8080

# Cleanup!
docker rm -f docker_http

# Better: watch logs even after container deletion
cat "${PWD}/logs/docker_http.log"

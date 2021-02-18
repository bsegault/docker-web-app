#!/bin/bash

set -euo pipefail
set -x


# Build image and name it bsegault/docker-http
# Better: we tag it so we now what's inside without inspecting
docker build -t bsegault/docker-http:02_dummy .

# -d: Run the container in detached mode
# -p: Map host port 8080 to container por 80
# Better: Start the image with its default command. No need to know what it is using and how it is built
docker run -d \
    -p 8080:80 \
    bsegault/docker-http:02_dummy

# Wait a bit
sleep 1

# Test it
curl http://localhost:8080

#!/bin/bash

set -euo pipefail
set -x


# Build image and name it bsegault/docker-http
docker build -t bsegault/docker-http .

# -d: Run the container in detached mode
# -p: Map host port 8080 to container por 80
# Run "node /index.js" from our bsegault/docker-http Docker image
docker run -d \
    -p 8080:80 \
    bsegault/docker-http node /index.js

# Wait a bit
sleep 1

# Test it
curl http://localhost:8080

FROM node:15-alpine

# Leave some public information for potential users
LABEL maintainer="Benjamin Segault <benjamin.segault@gmail.com>"
LABEL version="v0.0.6"
LABEL description="Simple HTTP server based on Node.js to illustrate Docker principles"

# Define current directory (created automatically)
WORKDIR /app

# Expose default port used by the container
EXPOSE 80

# Environment is used for configuring the app, with a default
# Users will know that they can configure this if they want
ENV MAX_HEADER_SIZE=4096

ENV NODE_ENV=production

# Better: default volume for log files: persitence even if user did not configured it
VOLUME ["/var/logs"]
# Better: inform that we want to use a bind mount for HTML assets
#    We cannot use the VOLUME instruction to set-up bind mount: this is a runtime operation
# Bind mount /app/html to your HTML asset folder that should be served by the app

COPY index.js package.json package-lock.json ./

# Install dependencies
RUN npm ci

# CMD to give default arguments
#    Here we could argue that this should be part of the environment.
CMD ["npm", "start", "--log-file", "/var/logs/docker-web-app.log"]

FROM node:alpine

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

COPY index.js package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Use of ENTRYPOINT to define default command that is not easily overriden
# Better: single definition of start command in package.json
ENTRYPOINT ["npm", "start"]

# CMD to give default arguments
#   Here we could argue that this should be part of the environment.
CMD ["--log-dir", "/var/logs"]

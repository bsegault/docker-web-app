FROM node:alpine

# Leave some public information for potential users
LABEL maintainer="Benjamin Segault <benjamin.segault@gmail.com>"
LABEL version="v0.0.5"
LABEL description="Simple HTTP server based on Node.js to illustrate Docker principles"

# Define current directory (created automatically)
WORKDIR /app

# Expose default port used by the container
EXPOSE 80

# Environment is used for configuring the app, with a default
# Users will know that they can configure this if they want
ENV MAX_HEADER_SIZE=4096

# Better: default volume for log files: persitence even if user did not configured it
VOLUME ["/var/logs"]

COPY index.js ./

# Use of ENTRYPOINT to define default command that is not easily overriden
ENTRYPOINT ["node", "index.js"]

# CMD to give default arguments
#   Here we could argue that this should be part of the environment.
CMD ["--log-dir", "/var/logs"]

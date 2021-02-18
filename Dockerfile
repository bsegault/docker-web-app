FROM node:15-alpine

# Leave some public information for potential users
LABEL maintainer="Benjamin Segault <benjamin.segault@gmail.com>"
LABEL version="v0.0.4"
LABEL description="Simple HTTP server based on Node.js to illustrate Docker principles"

# Define current directory (created automatically)
WORKDIR /app

# Expose default port used by the container
EXPOSE 80

# Better: environment is used for configuring the app, with a default
# Users will now that they can configure this if they want
ENV MAX_HEADER_SIZE=4096

COPY index.js ./

# Better: add default arguments to CMD
CMD ["node", "index.js", "4096"]

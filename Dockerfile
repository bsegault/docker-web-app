FROM node:alpine

# Better: leave some public information for potential users
LABEL maintainer="Benjamin Segault <benjamin.segault@gmail.com>"
LABEL version="v0.0.3"
LABEL description="Simple HTTP server based on Node.js to illustrate Docker principles"

# Define current directory (created automatically)
WORKDIR /app

# Expose default port used by the container
EXPOSE 80

COPY index.js ./

# Better: use of ENTRYPOINT to define default command that is not easily overriden
ENTRYPOINT ["node", "index.js"]

# Better: CMD to give default arguments
CMD ["4096"]

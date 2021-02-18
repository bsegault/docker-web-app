FROM node:15-alpine

# Better: leave some public information for potential users
LABEL maintainer="Benjamin Segault <benjamin.segault@gmail.com>"
LABEL version="v0.0.3"
LABEL description="Simple HTTP server based on Node.js to illustrate Docker principles"

# Define current directory (created automatically)
WORKDIR /app

# Expose default port used by the container
EXPOSE 80

COPY index.js ./

# Alternatively, we could use of ENTRYPOINT to make our image usable as an executable
# ENTRYPOINT ["node", "index.js"]
# And then use CMD to give default arguments
# Here it is does not make much more sense

# Better: add default arguments to CMD
CMD ["node", "index.js", "4096"]

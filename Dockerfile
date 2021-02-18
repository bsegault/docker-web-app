FROM node:alpine

# Better: define current directory (created automatically)
WORKDIR /app

# Better: Expose default port used by the container
EXPOSE 80

COPY index.js ./

# Better: CMD defined as array: explicit argument given, even with variables
CMD ["node", "index.js"]

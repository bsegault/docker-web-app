const http = require('http')

// Better: static config as a constant at beginning of code
// This should always be constant, so not really an issue to write here and in Dockerfile.
const port = 80

// Better: server config can be retrieved from environment. Use a default to avoid early failure if value is not set
const maxHeaderSize = Number.parseInt(process.env.MAX_HEADER_SIZE || 4096)

// Better: start log message
console.log(
  `Starting server on port ${port}; maxHeaderSize is ${maxHeaderSize}\n`
)

http
  .createServer({ maxHeaderSize: maxHeaderSize }, (req, res) => {
    res.write('Hello World!\n')
    res.end()

    // Better: some log messages
    console.log(`Request from ${req.socket.localAddress}; Sent ${message}\n`)
  })
  .listen(port)

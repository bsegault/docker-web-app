const fs = require('fs')
const http = require('http')

// Static config as a constant on top of app
// This should always be constant, so not really an issue to write here and in Dockerfile.
const port = 80

// Server config can be retrieved from environment. Use a default to avoid early failure if value is not set
const maxHeaderSize = Number.parseInt(process.env.MAX_HEADER_SIZE || 4096)

// Better: parameter to define optional log file
// Here we could argue that this should be part of the environment.
let logFile = 2 // 2 is stdout
let logFileArgIndex = process.argv.indexOf('--log-file')
if (logFileArgIndex !== -1) {
  logFile = fs.openSync(process.argv[logFileArgIndex + 1], 'w')
}

// Start log message
fs.writeSync(
  logFile,
  `Starting server on port ${port}; maxHeaderSize is ${maxHeaderSize}\n`
)

http
  .createServer({ maxHeaderSize: maxHeaderSize }, (req, res) => {
    const message = 'Hello World!\n'
    res.write(message)
    res.end()

    // Some log messages
    // Better: log to a file meant to be readable outside of Docker
    fs.writeSync(
      logFile,
      `Request from ${req.socket.localAddress}; Sent ${message}\n`
    )
  })
  .listen(port)

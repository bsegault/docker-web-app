const fs = require('fs')
const http = require('http')

// Rely on third-party module express rather than built-in Node.js "http" module.
const express = require('express')

const app = express()

// Static config as a constant on top of app
// This should always be constant, so not really an issue to write here and in Dockerfile.
const port = 80

// Server config can be retrieved from environment. Use a default to avoid early failure if value is not set
const maxHeaderSize = Number.parseInt(process.env.MAX_HEADER_SIZE || 4096)
const htmlFolder = process.env.HTML_FOLDER || "./html"

const helloWorldMessage = 'Hello World!\n'

// Parameter to define optional log file
// Here we could argue that this should be part of the environment.
let logFile = 2 // 2 is stdout
let logFileArgIndex = process.argv.indexOf('--log-file')
if (logFileArgIndex !== -1) {
  logFile = fs.openSync(process.argv[logFileArgIndex + 1], 'w')
}

// Better: Log function
const logRequest = (req, res, next) => {
  // Some log messages
  // Log to a file meant to be readable outside of Docker
  fs.writeSync(logFile, `[${new Date().toDateString()}] Request from ${req.socket.localAddress}: ${req.url}\n`)
  next()
}

// Go through log function before anything
app.use(logRequest)

// Sample custom route: /hello
app.get('/hello', (req, res) => {
  fs.writeFileSync(logFile, `Sending ${helloWorldMessage}`)
  res.send(helloWorldMessage)
  res.end()
})

// Allow to serve static html content: index.html is served by default when requesting /
app.use(express.static(htmlFolder))

http.createServer({ maxHeaderSize: maxHeaderSize }, app).listen(port, () => {
  // Start log message
  fs.writeSync(
    logFile,
    `[${new Date().toDateString()}] Starting server on port ${port}; maxHeaderSize is ${maxHeaderSize}\n`
  )
})

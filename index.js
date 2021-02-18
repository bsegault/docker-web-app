const http = require('http')

// Better: set server option to the need of our potential users (only as an example here)
http
  .createServer({ maxHeaderSize: 8192 }, (req, res) => {
    res.write('Hello World!\n')
    res.end()
  })
  .listen(80)

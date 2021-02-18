const http = require('http')

// Better: server option not hard-coded
const maxHeaderSize = process.argv && Number.parseInt(process.argv[2])

http
  .createServer({ maxHeaderSize: maxHeaderSize }, (req, res) => {
    res.write('Hello World!\n')
    res.end()
  })
  .listen(80)

const http = require('http')

http
  .createServer((req, res) => {
    res.write('Hello World!\n')
    res.end()
  })
  .listen(80)

const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.setHeader("Content-Type", "text/html; charset=utf-8");
  res.send('Test App Working.');
})

if (require.main === module) {
  app.listen(port, () => {
    console.log(`Test app listening at http://localhost:${port}`)
  });
}

module.exports = app;

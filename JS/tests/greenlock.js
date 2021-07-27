const greenlock = require("greenlock-express");
const app = require('./index.js');

app.get("/hello", function(req, res) {
  res.end("Hello, Encrypted World!");
});

greenlock.init({
  packageRoot: __dirname,
  configDir: "./greenlock.d",

  maintainerEmail: "********@gmail.com",
  agreeToTerms: true,
  sites: {
    "live.******.com": {
      "subject": "live.******.com",
      "altnames": ["live.******.com", "******.com"]
    }
  },
  cluster: false
}).serve(app);
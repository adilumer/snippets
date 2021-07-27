/***************************************************************
 * July 26th, 2021                             M. Adil Umer    *
 *                                                             *
 * A small piece to use for SSL handling when multiple domains *
 * are being hosted on the same server with their own SSL      *
 * certificates; probably behind a VHOST ¯\_(ツ)_/¯            * 
 *                                                             *
 *  Dependencies:                                              *
 *     "express": "^4.17.1"                                    *
 *                                                             *
****************************************************************/

/** 
Sample creds.json:
{
  "contextCollection":[
    {
      "domain":"api.example.com",
      "title": "example.com - API",
      "cert": "api_example_com.crt",
      "key": "api_example_com.key",
      "ca": ["rootCA.crt"]
    },
    {
      "domain":"api.other-example.com",
      "title": "other-example.com - API",
      "cert": "api_other-example_com.crt",
      "key": "api_other-example_com.key",
      "ca": ["rootCA.crt", "other_rootCA.crt"]
    }
  ]
}
*****/


var fs = require('fs');
var path = require('path');
var http = require('http');
var https = require('https');
var express = require('express');
var app = express();

var SSL_ROOT = "../credentials/ssl"; // Directory with ssl files
var credentials = require("../credentials/creds.json"); // Credentials and ssl definitions
var contextCollection = credentials.contextCollection; // import contexts defined in credentials
var httpServer = http.createServer(app);
var httpsServer;
var sslCollection = [];
var faultyContexts = 0;
var ports = {
  secure: 4430,
  nonSecure: 8080
}

contextCollection.forEach((context, index)=>{
  if(!context.domain || !context.cert || !context.key || (context.ca && !Array.isArray(context.ca))){
    console.log('Faulty context object: ', context);
    faultyContexts += 1;
    return;
  }
  // Build ssl object with context
  var contextCredentials = {
    key : fs.readFileSync(path.join(SSL_ROOT, context.key), 'utf8'),
    cert: fs.readFileSync(path.join(SSL_ROOT, context.cert), 'utf8'),
    ca: context.ca.map((certAuth)=>{
      return fs.readFileSync(path.join(SSL_ROOT, certAuth), 'utf8')
    })
  }

  sslCollection.push(contextCredentials);

  // Define the https server with default ssl, the first in context collection. Add remaining domains as other contexts.
  if(index == 0){
    httpsServer = https.createServer(sslCollection[0], app);
  }else{
    httpsServer.addContext(context.domain, contextCredentials);
  }
  
  // Start the server if all contexts have been accounted for
  if((sslCollection.length + faultyContexts) == contextCollection.length){
    initServer();
    
  }
});

// Dummy request handler
app.all('*', (req, res) => {
  var hostname = req.hostname
  console.log(`Request for ${hostname} recieved.`);
  res.status(200).send({message: 'Hello World!', host: hostname});
});

function initServer(){
  httpsServer.listen(ports.secure, () => {
    console.log('HTTPS Server running on port', ports.secure);
  });
  
  httpServer.listen(ports.nonSecure, () => {
    console.log('HTTP Server running on port', ports.nonSecure);
  });
}

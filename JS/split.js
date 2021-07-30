const splitFile = require('split-file');
const commandlineArgs = process.argv.slice(2);
var file = commandlineArgs[0];
var maxSize = commandlineArgs[1] || 102400000;


function split(){
	if (!file){
		console.log('Please specify the file to split.');
		return
	}

  splitFile.splitFileBySize(file, maxSize)
  .then((names) => {
  	console.log('The file has been split into:')
    console.log(names);
  })
  .catch((err) => {
    console.log('Error: ', err);
  });

}

split();
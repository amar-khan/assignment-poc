// 'Hello World' nodejs6.10 runtime AWS Lambda function
exports.handler = (event, context, callback) => {
    // console.log('Hello, logs!');

    // callback(null, 'great success');



const https = require('https');

https.get('https://blockchain.info/latestblock', (resp) => {
  let data = '';

  // A chunk of data has been received.
  resp.on('data', (chunk) => {
    data += chunk;
  });

  // The whole response has been received. Print out the result.
  resp.on('end', () => {
    console.log(JSON.parse(data));

        var responseBody = {
        "latestblock": JSON.parse(data)

    };

    var response = {
        "statusCode": 200,
        "body": JSON.stringify(responseBody),
        "isBase64Encoded": false
    };
    callback(null, response);

  });

}).on("error", (err) => {
  console.log("Error: " + err.message);
});
}



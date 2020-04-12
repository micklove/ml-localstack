'use strict'

const handler = (payload, context, callback) => {
  console.log(`Function handler called with payload ${JSON.stringify(payload)}`);
  callback(null, {
    statusCode: 201,
    body: JSON.stringify({
      message: 'Hello World'
    }),
    headers: {
      'X-Custom-Header': 'ASDF'
    }
  });
}

module.exports = {
  handler,
}
# Notes on Node.js


## Express.js


### Wrap async handlers

This is a simple wrapper to enable the use of async route handlers in express:

```javascript
const wrapAsyncHandler = (fn) => {
  return (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  }
}
```

To use it:
```javascript
app.get('/some/url', wrapAsync(async(req, res) => {
  try {
    const ret = await someAsyncOperation(req.query.param1, req.query.param2);
    return res.send({ success: true, result: ret });
  } catch(err) {
    console.log('Error: ', err);
    return res.send({ success: false, error: err });
  }
}));
```


### Middleware for protecting handlers

```javascript
const protectedHandler = (req, res, next) => {
  const tok = getToken(req);
  if (!tok || !verifyToken(tok)) {
    return res.send({ success: false, error: 'Invalid auth' });
  }
  // Set some protected value if needed
  res.locals.protectedResourceId = ...
  return next();
}
```


### Middleware for recording response times

```javascript
const recordElapsedTime = (req, res, next) => {
  const timeStart = process.hrtime();
  res.on('finish', () => {
    const elapsedTime = process.hrtime(timeStart);
    const elapsedTimeMs = elapsedTime[0] * 1000 + elapsedTime[1] / 1e6;
    console.log(`Elapsed time for ${req.path} = ${elapsedTimeMs}`);
  });
  next();
}
app.use(recordElapsedTime);
```


## Event Emitters

### Direct use

```javascript
const EventEmitter = require('events');

let ee = new EventEmitter();

ee.on('some-event', () => {
  console.log('Event handler 1');
});

ee.on('some-event', () => {
  console.log('Event handler 2');
});

ee.on('some-event', (param1) => {
  console.log('Event handler 3, param1: ', param1);
});

ee.emit('some-event', 'This is param1');
```


### Inheriting from `EventEmitter`

```javascript
const EventEmitter = require('events');

class SomeHandler extends EventEmitter {
  // ...
}


let someHandler = new SomeHandler();
someHandler.on('handle-event', (param1) => {
  console.log('On handle-event, param1: ', param1);
});

someHandler.emit('handle-event', someParam);
```


### Asynchronous use

Wrap the handler in `setImmediate`:

```javascript
someHandler.on('handle-event', (param1) => {
  setImmediate(() => console.log('On handle-event async, param1: ', param1));
});
```


## Worker Threads

For CPU-intensive work, not IO-bound work.

### Separate file or inline eval

```javascript
const { Worker } = require('worker_threads');

// Instantiate from a file
const aWorker = new Worker('some_file.js');

// Load directly via eval
const anotherWorker = new Worker(`
  console.log('anotherWorker worker thread');
`, { eval: true });
```


### Instantiate from the same file

```javascript
const { Worker, isMainThread } = require('worker_threads');

if (isMainThread) {
  const aWorker = new Worker(__filename);
  // Do main thread work
  // ...
} else {
  console.log('aWorker worker thread');
  // ...
}
```


### Pass data when initializing worker threads

```javascript
const { Worker, isMainThread, workerData } = require('worker_threads');
if (isMainThread) {
  const aWorker = new Worker(__filename, {
    workerData: {
      someData: 'Something',
      moreData: 42,
    }
  });
  // ...
} else {
  console.log('aWorker worker thread');
  console.log('someData: ', workerData.someData);
  // ...
}
```


### Communicating between threads

```javascript
const { Worker, isMainThread, parentPort } = require('worker_threads');

if (isMainThread) {
  const aWorker = new Worker(__filename);

  aWorker.on('message', (msg) => {
    console.log('aWorker posted: ', msg);
  });
  // ...
  aWorker.postMessage('Hello from the main thread.');
} else {
  parentPort.on('message', (msg) => {
    console.log('Parent posted: ', msg);
  });
  parentPort.postMessage('aWorker starting.');
  // ...
  parentPort.postMessage('aWorker completed.');
}
```

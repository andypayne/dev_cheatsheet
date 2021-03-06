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


## Modules


### Exporting groups of constants that build on each other

Sometimes it's useful to export some values that reference each other, for
example components of URLs. Components like prototypes and hostnames can be
defined, and then those can be used to build multiple URLs. This can be done
with `Object.freeze` and defining accessors with `get`:

```javascript
module.exports = Object.freeze({
  PROTO:       'https',
  HOST:        'example.com',
  PARAM:       'foo',
  get URL1()   { return `${this.PROTO}://${this.HOST}/path/to/something` },
  get URL2()   { return `${this.PROTO}://${this.HOST}/another/path/?param=${this.PARAM}` },
});
```


## `npm`/`fsevents` error

Error: `Unsupported platform for fsevents`

`fsevents` is a darwin-specific lib. To get around this, install with the force
flag:
```shell
npm i -f
```


## `npm audit`

It's annoying that `npm audit` doesn't have an option for only displaying high or critical vulnerabilities. It does have an option for failing the audit if a given level of vulnerability is found, but it happily returns all the issues found. That's not useful for triage.

For example:
```shell
npm audit --audit-level=critical

found 907 vulnerabilities (888 low, 18 moderate, 1 high) in 1866 scanned packages
  run `npm audit fix` to fix 592 of them.
  315 vulnerabilities require manual review. See the full report for details.
```

To display only high and critical vulnerabilities:
```shell
npm audit | grep -E "(High | Critical)" -B3 -A10

# Run  npm update http-proxy --depth 4  to resolve 1 vulnerability
┌───────────────┬──────────────────────────────────────────────────────────────┐
│ High          │ Denial of Service                                            │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ Package       │ http-proxy                                                   │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ Dependency of │ react-scripts                                                │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ Path          │ react-scripts > webpack-dev-server > http-proxy-middleware > │
│               │ http-proxy                                                   │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ More info     │ https://npmjs.com/advisories/1486                            │
└───────────────┴──────────────────────────────────────────────────────────────┘
```


## Jest

To [troubleshoot jest](https://jestjs.io/docs/en/troubleshooting):

```shell
node --inspect-brk node_modules/.bin/jest --runInBand
```

Then open Chrome/Chromium, enter `chrome://inspect`, and click `Open Dedicated
DevTools for Node`. Then resume the debugger, which is automatically paused at a
breakpoint.


### beforeEach async

If you have an async activity to setup in `beforeEach`, you can either use the `done` parameter, or return a value from `beforeEach`:

```javascript
beforeEach(async () => {
  const someObj = await anActivity();
  return someObj;
});
```


### Run test code in an arbitrary file

Sometimes you might have tests you want to run in a file that doesn't match Jest's default test regex pattern (perhaps because it's not in the `test/` directory. You can work around this by specifying a pattern that matches the file you want to run. For example, if you have a file called `some-tests.js` in your project's root that you want to run, you can do that with:

```shell
jest --testRegex=some-tests ./some-tests.js
```


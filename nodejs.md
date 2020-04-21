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


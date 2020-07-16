
To make a call in a serial/iterative fashion and use the results of each call
as input to the next call, one way is to use a loop with await inside an
[IIFE](https://en.wikipedia.org/wiki/Immediately_invoked_function_expression):

```javascript
const fun = () => {
  return Math.trunc(10 * Math.random());
}

const looper = (x0) => {
  return new Promise((resolve, reject) => {
    const x = fun();
    resolve(x0 + x);
  });
}

void async function() {
  let x = 0;
  let i = 0;
  let finished = false;
  while (!finished) {
    x = await(looper(x));
    console.log(`[${i}]: ${x}`);
    i += 1;
    if (i > 10) {
      finished = true;
    }
  }
}();
```

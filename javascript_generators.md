
```javascript
function *genFn() {
  console.log('Generator fn running');
  let x = 42;
  yield x;
  x += 1;
  return x;
}

let iter = genFn();
console.log(iter.next());  // Object { value: 42, done: false }
console.log(iter.next());  // Object { value: 43, done: true }
console.log('Finished');
```

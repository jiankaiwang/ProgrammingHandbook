# Making a Promise Object



The Promise object requires two callbacks, `resolve` and `reject`. Here we create a promise object and it takes parameter time to start a resolve callback, or start a reject callback if the parameter is not a number.



```javascript
delay(1000)
  .then(() => printMsg("Hello world, making a promise in javascript."))
  .catch((err) => console.error(err));

function delay(time) {
  return new Promise((resolve, reject) => {
    if(isNaN(time)) {
      reject(new Error("need a valid number"));
    }
    setTimeout(resolve, time);
  });
}

function printMsg(msg) {
  console.log(msg);
}
```


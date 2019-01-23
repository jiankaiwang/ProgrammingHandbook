# Async and Await



## Simple Example

We can `await` a function till its resolving or rejecting. We also need to `async`  the body containing the awaited function. Of course, the `await` function requires Promise type.

```javascript
delayES8(1000)
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

async function delayES8(time) {
  await delay(time);
  // await fun1 ...
  // await fun2 ...
  return;
}
```



## Advanced Example

The sequential callback via Promise object is also equal to the sequential `await` functions in `async` body.

```javascript
/*
  promise state: pending, fulfill, reject
  then(fulfill), catch(reject) 
*/

function ajax(url) {
  return new Promise(function(resolve, reject) {
    $.ajax(url).done(resolve).fail(reject);
  });
}

// origin sequential (== sequential_async())
function sequential() {
  ajax("data.json")
    .then(function(data) {
      var select = Math.random();
      if (select <= 0.5) {
        // the object passing to the next step (.then)
        // must be also the promise object
        // using return to pass the promise object
        return ajax(data["opts"][0] + ".json");
      } else {
        return ajax(data["opts"][1] + ".json");
      }
    })
    .then((data) => $('#msg').html(data["name"]))
    .catch((err) => console.log(err));
}


// equal to the async and await (== sequential())
async function sequential_async() {
  let json1 = await ajax("data.json");
  
  var select = Math.random();
  var json2 = "";
  if (select <= 0.5) {
    json2 = await ajax(json1["opts"][0] + ".json");
  } else {
    json2 = await ajax(json1["opts"][1] + ".json");
  }
  $('#msg').html(json2["name"]);
}

sequential_async();
```






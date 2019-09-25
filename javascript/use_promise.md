# Using Promise



The Promise declaration is a good solution solving sequential callbacks. 

The Promise object has three states, pending, fulfilling and reject. Fulfilling means function working complete and successful. Reject means function raising an error or exception occurs.

In sequential callbacks, each promise can be passed into the next promise object using `.then()` to continue executing the next step and using `.catch()` to handle the error situation.

The following is the simple example using promise.

```javascript
function getData(url) {
    // ...
}

// assign as a promise object
let promise = getData(data);
promise.then(fulfill);
promise.catch(reject);

function fulfill(data) {
  console.log(data);
}
function reject(err) {
  console.log(err);
}
```

The above script can be shorten into the following one.

```javascript
function getData(url) {}

// equals to
getData(data).then(fulfill).catch(reject);

function fulfill(data) {}
function reject(err) {}
```

The shorten script does the same thing as the following one.

```javascript
getData(data)
  .then(function(data) {
    // using a anonymous function
    console.log(data);
  }).catch(function(err) {
    // using a anonymous function
    console.log(err);
  });
```

We can further shorten the anonymous functions.

```javascript
// equals to
getData(data)
  .then((data) => console.log(data))
  .catch((err) => console.log(err));
```



The following are examples using promise, including html webpage, example.js and json data. 

```html
<html>
  <head></head>
  <body>
    <p id="msg"></p>
      
    <script
      src="https://code.jquery.com/jquery-2.2.4.min.js"
      integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
      crossorigin="anonymous"></script>
    <script src="example.js"></script>
  </body>
</html>
```

`example.js`
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
```

`data.json`
```json
{
  "len": 2,
  "opts": [ "type1", "type2"]
}
```

`type1.json`
```json
{
  "name": "type1"
}
```

`type2.json`
```json
{
  "name": "type2"
}
```
# Using Promise.all()



We can use `Promise.all()` to keep the all promise objects executed in sequential. 



## Situtation

Assume we need a sequential execution that requires fetching data.json, type1.json and type2.json in order. The following is a simple way.

```javascript
function ajax(url) {
  return new Promise(function(resolve, reject) {
    $.ajax(url).done(resolve).fail(reject);
  });
}
```

```javascript
/**
 * You might see ...
 *
 * data
 * type1
 * type2
 *
 * or
 *
 * type1
 * data
 * type2
 *
 * ...
 */
function no_promise_all() {
  ajax("data.json")
    .then((data) => $("#msg").html($("#msg").html() + data["name"] + "<br>"))
    .catch((err) => console.error(new Error(err)));

  ajax("type1.json")
    .then((data) => $("#msg").html($("#msg").html() + data["name"] + "<br>"))
    .catch((err) => console.error(new Error(err)));

  ajax("type2.json")
    .then((data) => $("#msg").html($("#msg").html() + data["name"] + "<br>"))
    .catch((err) => console.error(new Error(err)));
}
no_promise_all();
```



## Promise.all()

After the above execution, the result might change time by time you refresh the webpage. Now, we can promise.all to keep the sequential execution in order.

```javascript
function promise_all() {
  var promise_list = [ajax("data.json"), ajax("type1.json"), ajax("type2.json")];
  Promise.all(promise_list)
  .then((results) => {
    var catMsg = "";
    for(var i=0; i < results.length; i++) {
      catMsg += results[i]["name"] + "<br>";
    }
    $("#msg2").html(catMsg);
  })
  .catch((err) => console.error(new Error(err)));
}
promise_all();
```



## Error Handling

**But promise.all() catch one of the promise object failures, so we need define try ... catch ... in each promise objects.**

```javascript
function ajax_try(url) {
  // we use null as the returning message while error occured
  return ajax(url)
  .then((data) => { return(data); })
  .catch((err) => { return({name: null}); });
}

function promise_all() {
  var promise_list = [ajax_try("data1.json"), ajax_try("type1.json"), ajax_try("type2.json")];
  Promise.all(promise_list)
  .then((results) => {
    var catMsg = "";
    for(var i=0; i < results.length; i++) {
      // here we detect `null` as the error occured
      if(results[i]["name"] !== null) {
        catMsg += results[i]["name"] + "<br>";
      }
    }
    $("#msg2").html(catMsg);
  })
  .catch((err) => console.error(new Error(err)));
}
promise_all();
```


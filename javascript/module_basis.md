# Module



Browser now supports ES6 modules. We can use script tag with `type="module"` to make browser importing scripts in the type of ES6 module. The following is a simple example.



## Example



*   `index.html`

```html
<!DOCTYPE html>
<html>
  <head></head>
  <body>
    <span id="msg"></span>

    <script type="module">
      import {hello} from "./index.js";
      import * as m from "./index2.js";
      
      window.onload = function() {
        document.getElementById("msg").innerHTML = hello(prompt("Input your name: "));
      };

      // view the result via browser's developer tool
      console.log(m.add(3, 2));
      console.log(m.sub(3, 2));
    </script>
  </body>
</html>
```



*   `index.js`

```js
function hello(name) {
  return "Hello World, ES6. Welcome " + name + "!";
}

export {hello};
```



*   `index2.js`

```javascript
function add(a, b) {
  return a+b;
}

function sub(a, b) {
  return a-b;
}

export {add, sub};
```


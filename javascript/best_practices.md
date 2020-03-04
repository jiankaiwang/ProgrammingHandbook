# Best Practices in Javascript



### Item.1: Using Event Listener instead of Inline handler

It had better using an event listener instead of an inline handler while a DOM object event was triggered. The following was an example demonstrating the event handler.

```js
// better practices in javascript
document.addEventListener("DOMContentLoaded", function() {
  function eventHandler() {
    let para = document.createElement('p');
    para.textContent = 'You clicked the button!';
    document.body.appendChild(para);
  }

  const buttons = document.querySelectorAll('button');

  for(let i = 0; i < buttons.length ; i++) {
    buttons[i].addEventListener('click', eventHandler);
  }
});
```

```html
<!-- html doc -->
<button>Submit</button>
```

You would possibly see the inline handler, that is some javascript code existing inside a part of the HTML document. 

```html
<!-- html doc, not recommended  -->
<button onclick="javascript: eventHandler()">Submit</button>
```

The way adding an inline handler into the HTML document is not recommended.

* You should keep the HTML document clarified, not contaminated with other languages.
* It is hard to maintain or to develop, the same inline handler is required to be written on each DOM objects.
* A strength to the event listener is really easy maintainable while the target DOM was removed out of the HTML document.



### Item.2: Script Loading Strategies via async and defer

Script loading is also an issue. For example, if the script handling DOM is loaded before its complete, the HTML document would possibly fail. You should use `async` or `defer` to tell the HTML analyzer the order of script loading and HTML DOM.

* The flag `async` is used when loading scripts that are not dependent on other scripts.

```html
<script async src="jquery.js"></script>
<script async src="script1.js"></script>
<script async src="script2.js"></script>
```

* The flag `defer` is used when loading scripts that are dependent on other scripts and should loaded in a sequence.

```html
<script defer src="jquery.js"></script>
<script defer src="script1.js"></script>
<script defer src="script2.js"></script>
```

You should see that a traditional way is appending the script loading process at the end of the body tag in an HTML document. However, the way trying to load the script after the DOM loading completely is not a good practice. It causes slow performance.

```html
<!-- html doc, not recommended  -->
<html>
  <head></head>
  <body>
    ...
    
    <script src="jquery.js"></script>
    <script src="script1.js"></script>
   	<script src="script2.js"></script>
  </body>
</html>
```










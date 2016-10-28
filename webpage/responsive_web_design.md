# Responsive Web Design

<script type="text/javascript" src="../js/general.js"></script>

### 透過 resize 事件與 rendering 函式來達成
---

* 原 html 架構

```html
<div id="linechartContainer" style="width: 100%; height: 100%;">
	<div id="linechartBody" style="width: 100%; height: 100%;">
    <!-- svg image -->
    </div>
</div>
```

* RWD By javascript

```javascript
/*
    desc : RWD 
*/
function rendering() {
  if(window.jQuery && $('#linechartContainer').length > 0 && $('#linechartBody').length > 0) {
    // clear the image
    Plotly.d3.select('#linechartBody svg').html('');

    // set layout options
    layout["height"] = parseInt(Plotly.d3.select("#linechartContainer").style("height"), 10);
    layout["width"] = parseInt(Plotly.d3.select("#linechartContainer").style("width"), 10);
    layout["autosize"] = false;

    // try to plot a new one image
    Plotly.newPlot('linechartBody', data, layout);
  }
}

// listen to the resize event
Plotly.d3.select(window).on('resize', rendering);
```

### allow multiple resize events
---

* 透過 namespace 來達成，需要注意的是需要每個 resize event 都有 namespace 定義，如下 API 說明及範例

| 註解 |
| -- |
| If an event listener was already registered for the same type on the selected element, the existing listener is removed before the new listener is added. To register multiple listeners for the same event type, the type may be followed by an optional namespace, such as "click.foo" and "click.bar". |

```javascript
// ...

// listen to the resize event 1
Plotly.d3.select(window).on('resize.event1', rendering);

// listen to the resize event 2
Plotly.d3.select(window).on('resize.event2', rendering);

// ...
```



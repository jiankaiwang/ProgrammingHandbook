# Javascript vs. jQuery

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

###取得 JSON 資料
---
* 假定使用的 JSON 資料內容與 html code

```Javascript
[
	{
		"subject":"math",
		"score":"100",
		"term":"final"
	},
	{
		"subject":"physics",
		"score":"100",
		"term":"final"
	}
]
```

目的將取得的 JSON 資料加入 menu 中，

```Html
<ul id="menu">
	<li>Ori</li>
</ul>
```

最後的呈現結果如下；

```Html
* Ori
* 0->math
* 0->100
* 0->final
* 1->physics
* 1->100
* 1->final
```

* jQuery : 透過 $.getJSON 方式

底下為使用方法

```Javascript
<script type="text/javascript">
$.getJSON('data.json', 
function(data) {
	for(var collection in data) {
		for(var element in data[collection]) {
			$("#menu").append("<li>" + collection + "->" + data[collection][element] + "</li>");
		}
	}
});
</script>
```

* jQuery : 透過 $.ajax 方式

```Javascript
<script type="text/javascript">
// success 與 error 為 callback function
$.ajax({
	type: "GET",
	dataType: "json",
	url: 'data.json',
	async: false,
	success: function(data) {
		for(var collection in data) {
			for(var element in data[collection]) {
				$("#menu").append("<li>" + collection + "->" + data[collection][element] + "</li>");
			}
		}
	}
	//error: callback
});
</script>
```

* 非 jQuery : 透過 XMLHttpRequest 實作出 ajax，此方法能配合 web worker 來多執行緒取得 json data

```Javascript
<script type="text/javascript">
// 自定義的 ajax
var ajax = function(url, data, callback, type) {
	var data_array, data_string, idx, req, value;
	if (data == null) {
		data = {};
	}
	if (callback == null) {
		callback = function() {};
	}
	if (type == null) {
		//default to a GET request
		type = 'GET';
	}
	data_array = [];
	for (idx in data) {
		value = data[idx];
		data_array.push("" + idx + "=" + value);
	}
	data_string = data_array.join("&");
	req = new XMLHttpRequest();
	req.open(type, url, false);
	req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	req.onreadystatechange = function() {
		if (req.readyState === 4 && req.status === 200) {
		  return callback(req.responseText);
		}
	};
	req.send(data_string);
	return req;
};

ajax('data.json',null,function(data){
	// 需要透過 json.parse 將資料型態為 string 的 json 內容轉換成 json object
	var jsonData = JSON.parse(data);
    
	for(var collection in jsonData) {
		for(var element in jsonData[collection]) {
			$("#menu").append("<li>" + collection + "->" + jsonData[collection][element] + "</li>");
		}
	}
},'GET');
</script>
```

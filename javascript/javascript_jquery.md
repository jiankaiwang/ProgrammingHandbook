# Javascript vs. jQuery


###取得 JSON 資料 (GET)
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
	// 可以透過 json.parse 將資料型態為 string 的 json 內容轉換成 json object
    // 此 json.parse 需要 jQuery library
	var jsonData = JSON.parse(data);
    
	for(var collection in jsonData) {
		for(var element in jsonData[collection]) {
			$("#menu").append("<li>" + collection + "->" + jsonData[collection][element] + "</li>");
		}
	}
},'GET');
</script>
```

###傳送與接收 JSON 資料 (POST)
---

* 一般而言，透過 jQuery library 中 $.ajax 能夠簡單的將資料 POST 到 web method 的服務中，然後取得回傳的 JSON 資料，如下；

```Javascript
// 檔名為 native-ajax-post.js
$.ajax({
    type: "POST",
    url: "webmethod or api url (router)",
    data: "{key-1: 'value-2', key-2: 'value-2'}",
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    success: function (data) {
        // get the data after sending data by "POST"
        dealWith(data);
    },
    beforeSend: function () {
        $('#waiting-logo').show();
    },
    complete: function () {
        $('#waiting-logo').hide();
    },
    error: function (xhr, ajaxOptions, thrownError) {
        alert(xhr.status);
        alert(thrownError);
    }
});
```

* 但在一些不支援的環境下，如 worker 執行緒等不支援 window 物件 (即 jQuery 無法使用下)，就必須透過 native 的 XMLHttpRequest() 方式達成這件事，如下；

```Javascript
// define XMLHttpRequest() function
function postJsonAjax(url, sentdata, success) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', url);
    xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
    xhr.onload = function () {
        if (xhr.status === 200) {
            return success(xhr.responseText);
        }
    }
    xhr.send(JSON.stringify(sentdata));
}
```

* 在可以用 window 物件 (即可使用 jQuery 下)，使用 native post method

```Javascript
var sentData = { key-1: 'value-2', key-2: 'value-2' };
var getData = null;

postJsonAjax("webmethod or api url (router)", sentData, function (data) {
        getData = JSON.parse(data);
});
```

* 在 ** shared worker ** 使用 native post method，需要注意的是在 shared worker 中使用全域變數需要透過 self 來存取。

```Javascript
var sentData = { key-1: 'value-2', key-2: 'value-2' };
var getData = null;

onmessage = function (e) {
    // 確認來自 top (或稱 parent) 的變數是否與目前參數値相同
    // 不同進行 ajax 取得 json 資料；若相同則回傳相同內容即可
    if (e.data[0] != self.sentData.key-1 || e.data[1] != self.sentData.key-2) {
        self.sentData.key-1 = e.data[0];
        self.sentData.key-2 = e.data[1];

        postJsonAjax("webmethod or api url (router)", self.sentData, function (data) {
            self.getData = JSON.parse(data);
            self.postMessage(self.getData);
        });
    } else {
        self.postMessage(self.getData);
    }
}
```

而在 top (或 parent) 頁面，可以透過下列方式與 shared worker 溝通；

```Html
<script type="text/javascript">
var fetchData = null;

if (window.Worker) {
    var nativePostWorker = new SharedWorker('Scripts/webworker/native-ajax-post.js');
    
    // send JSON object to the shared worker for "POST"
    nativePostWorker.port.postMessage(['value-1','value-2']);
    
    // get JSON data from shared worker
    nativePostWorker.port.onmessage = function (e) {
        fetchData = JSON.parse(e.data);
    }
}

// do something ...
</script>
```

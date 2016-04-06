# dedicated worker

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

Dedicated worker 僅能被產生它的檔案來存取，底下的範例為傳入一個含有 2 個數值與 1 筆文字的串列 (list) 傳入 worker，並透過 worker 進行相成與相加，文字則是不作處理，然後在前端頁面顯示出這些結果。

###偵測瀏覽器是否支援 Worker 功能
---

因 web worker 在早期流覽器並無法支援，因此可以透過下列程式碼進行確認是否支援；

```Javascript
if (window.Worker) {
  // ...
}
```

###產生 dedicated worker
---

透過呼叫 Worker() 建構子，並傳入 .js 檔案的 URL 便可以產生一個 worker 執行緒。

```Javascript
var myworker = new Worker('dworker.js');
```

###向 dedicated worker 傳送訊息
---

* 前端頁面 (或稱父頁面) 可以透過 postMessage() 方法向 worker 執行緒傳送訊息 (即必要傳入參數值)。
* 前端頁面 (或稱父頁面) 則可透過 onmessage() 方法取得來自 worker 執行後的結果 (即取得結果)。

```Javascript
if(window.Worker) {
    // send the worker values
	myworker.postMessage([2,5,"text"]);
	alert('post message');
	
    // get values from the worker
	myworker.onmessage = function(e) {
		alert('message from dwork : ' + e.data);
	}
}
```

然後我們可以在 worker 執行緒中實作處理來自前端頁面的參數値；

* **透過 onmessage() 接收訊息，並進行處理**
* **執行完後，在透過 postMessage() 傳送訊息回去給前端，並由前端的 onmessage() 取得來自 worker 的資料**
* **當然，此 worker 執行緒亦可以引用不同的 javascript 函式庫，並可以透過 ** importScripts() ** 來引用；底下為被 worker 引用的函式庫的內容 (檔名為 lib.js)；**

```Javascript
// 此內容存放在名為 lib.js 的檔案中
function mulValue(num1, num2) {
	return (num1+num2);
}
```

底下為實作 worker 內容的方法 (檔名為 dworker.js )；

```Javascript
// 引用不同的 javascript 檔案
importScripts('lib.js');

// worker 執行的結果
onmessage = function(e) {
	console.log('Message from main script');
	var workerResult = 'Multiply : ' + (e.data[0] * e.data[1]) + ' ; msg is ' + e.data[2] + ' ; Plus : ' + mulValue(e.data[0], e.data[1]);
	console.log('Post message to main script');
	postMessage(workerResult);
}
```

| 註解 |
| -- |
| 需要注意的是，不論是 (1) 由前端傳入 worker 的參數值或是 (2) 取得來自 worker 的計算結果，皆是將資料 (包含傳入資料與取得資料) 內容存放在 data 屬性中，且不論傳入或是取得資料，皆是以複製的方式進行，而非分享方式 (即傳值非傳址)。 |

###結束 dedicated worker
---

* 方法一：可以在前端頁面中呼叫 ** terminate() ** 來結束 worker，如下；

```Javascript
myWorker.terminate();
```

* 方法二：在 worker 執行緒中，可以自己呼叫 ** close() ** 方法來結束執行緒，如下；

```Javascript
close();
```

| 註解 |
| -- |
| 需要注意的是不論 worker 正在執行的運算完成與否，一但呼叫結束指令後，worker 便會終止。 |

###引用程式腳本與函式庫 (library)
---
Worker 執行緒能透過 importScripts() 來存取一個全域函數或載入外部資源，如下範例；

```Javascript
// 引用單一個 js 腳本檔案
importScripts('example.js');                

// 引用多個 js 腳本檔案
importScripts('lib.js', 'example.js');      
```

###完整範例程式碼
---


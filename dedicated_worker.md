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

| 註解 |
| -- |
| 需要注意的是，不論是 (1) 由前端傳入 worker 的參數值或是 (2) 取得來自 worker 的計算結果，皆是將資料 (包含傳入資料與取得資料) 內容存放在 data 屬性中，且不論傳入或是取得資料，皆是以複製的方式進行，而非分享方式 (即傳值非傳址)。 |







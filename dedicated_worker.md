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


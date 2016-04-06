# Web Workers

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

Web Workers 提供一個簡單的方法讓網頁能在背景執行緒 (Thread) 中執行程式，而不干擾前端使用者介面的運作。Worker 亦可利用 XMLHttpRequest 執行輸入或輸出 (但 ResponseXML 和 Channel 這兩個屬性為 null)。一般而言，一個 worker 可以藉由事件處理器來和 Web Worker 互相傳送訊息及內容。

根據 Worker 的運作模式，可以更細分成 dedicated worker, shared worker 及 embedded worker。Dedicated worker 只能被產生它的檔案存取，shared worker 則能夠被多個程式腳本存取，包含能跨越不同 window、iframe 或 worker 等，而 embedded worker 則可以透過資料區塊將此 worker 嵌入頁面中。


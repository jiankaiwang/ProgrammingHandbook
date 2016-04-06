# Web Workers

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

###簡介
---
Web Workers 提供一個簡單的方法讓網頁能在背景執行緒 (Thread) 中執行程式，而不干擾前端使用者介面的運作。Worker 亦可利用 XMLHttpRequest 執行輸入或輸出 (但 ResponseXML 和 Channel 這兩個屬性為 null)。一般而言，一個 worker 可以藉由事件處理器來和 Web Worker 互相傳送訊息及內容。

根據 Worker 的運作模式，可以更細分成 dedicated worker, shared worker 及 embedded worker。Dedicated worker 只能被產生它的檔案存取，shared worker 則能夠被多個程式腳本存取，包含能跨越不同 window、iframe 或 worker 等，而 embedded worker 則可以透過資料區塊將此 worker 嵌入頁面中。

Web Workers 提供一個能夠多執行緒的解決方案，因 javascript 為單核心執行的程式語言，若是需要讀取不同的檔案，如 JSON 等，便為依序讀取的不同來源，但此會造成效率不彰，尤其在硬體資源充沛的狀況下，多執行緒的解決方案能夠大大改善此序列讀取的問題。

| 註解 |
| -- |
| 並非所有的瀏覽器皆能使用 Web Workers。 可以透過 ** if(window.Worker) ** 來確認是否支援。 |

###Web Workers API
---
* 可以透過 worker 建構子 (如 worker()) 來產生 worker 物件，並於此物件中執行 javascript 內容 (亦包含可以執行 javascript 檔案)。

* Worker 運行的 Javascript 不同於視窗 (window) 下的執行環境，所以在 worker 中存取全域物件應該要透過 self，若是透過 window 便會發生錯誤；意即透過 $(window) 的方式會出錯。

* Dedicated worker 只能被產生它的檔案來存取，DedicatedWorkerGlobalScope 物件代表其執行環境；而 Shared worker 則能夠被不同的檔案存取，SharedWorkerGlobalScope 物件代表其執行環境。

* 一般而言，Worker 能執行任何事情，例如 WebSockets、IndexedDB 等，但大部分直接存取 DOM 或是 window 物件的方法或屬性則是不被允許。

* **主執行緒 (例如 UI) 和 worker 執行緒之間透過 postMessage() 方法發送訊息，然後透過 onmessage 事件接受訊息 (訊息存在 Message 事件的 data 屬性之中)，而被傳誦的資料是透過複製一份的方式，而非共享。**

* worker 亦可以產生新的 worker，只要 worker 的來源 (origin) 和父頁面相同即可。




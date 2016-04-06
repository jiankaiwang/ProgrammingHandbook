# shared worker

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

shared worker 能夠被多個程式腳本存取，包含 window、iframe 或其他 worker 執行緒，底下範例與 dedicated worker 範例類似，傳入一個含有 2 個數值與 1 筆文字的串列 (list) 傳入 worker，並透過 worker 進行相成與相加，文字則是不作處理，然後在前端頁面顯示出這些結果。


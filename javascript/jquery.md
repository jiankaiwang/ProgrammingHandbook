# jQuery

<script type="text/javascript" src="../js/general.js"></script>

存取 iframe 中的元素，可使用 .contents() 取得 content 後，再透過 .find() 來找尋物件；
如果是呼叫 iframe 中定義的方法時，可用 .contentWindow 再透過 [.<function name>] 來呼叫函式。

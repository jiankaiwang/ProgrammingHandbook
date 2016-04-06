# shared worker

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

shared worker 能夠被多個程式腳本存取，包含 window、iframe 或其他 worker 執行緒，底下範例實作兩種狀況；
1. 當其中一個前端頁面傳入參數值給 shared worker 並經過其執行後，會將計算後的値同步傳回給 **所有** 註冊 (透過 port 的形式) 於該 shared worker 的前端頁面。
2. 當第一個前端頁面創造一個 shared worker，此 worker 便會自行計算與執行，其他前端頁面便可以直接取得已計算的結果，不需重新計算或傳入參數。(** 第一個前端頁面不需要傳入參數 **)


| 註解 |
| -- |
| 需要注意底下幾點；<br>(1) 範例中含有兩份 HTML 頁面，各自都利用** 同一個 worker **處理運算<br>(2) shared worker 無法在一般瀏覽模式與隱私流覽模式間共享資料。 |

###


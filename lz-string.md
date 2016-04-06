# lz-string

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

* lz-string 是一套跨平台的壓縮工具，包含 C#、Python 與 Javascript。對於傳輸大型資料，以 JSON、XML 等格式傳輸提供一個提升傳輸效率的解決方法。

* 因 lz-string 提供跨越不同平台的函式庫，因此對於開發者而言有相當大的彈性能夠交互使用。

* 此 ls-string 的授權方式為 WTFPL (Do What The Fuck You Want To Public License)，目前已被自由軟體基金會認證為相容於 GPL 的自由軟體授權條款。

###主要使用函式 : 各平台函式庫皆有支援
---

* in-valid UTF-16 : 產生一個類似(不完整) UTF-16 編碼的壓縮字串，僅能儲存於 webkit 的瀏覽器記憶體中
  * string compress(string uncompressed)
  * string decompress(string compressed)


* ASCII UTF-16 : 將原始以 Base64 編碼的字串壓縮產生一個 ASCII UTF-16 編碼的字串，在某些 JSON 格式的資料中能提供大幅的資料壓縮率
  * string compressToBase64(string uncompressed)
  * string decompressFromBase64(string compressed)


* valid UTF-16 : 趕生一個符合 UTF-16 編碼的壓縮字串，因此大部分的主流瀏覽器都能支援
  * string compressToUTF16(string uncompressed)
  * string decompressFromUTF16(string compressed)


* Unit8Array
  * string compressToUint8Array(string uncompressed)
  * string decompressFromUint8Array(string compressed)


* ASCII string encoded in Base64 to make URI safe
  *  string compressToEncodedURIComponent(string uncompressed)
  *  string decompressFromEncodedURIComponent(string compressed)

| 註解 |
| -- |
| 需要注意的底下幾點；<br>(1) 每組壓縮與解壓縮函式為相對應的函式，不能誤用到其他函式<br>(2)** 雖然 lz-string 能提供跨平台的優點，但某些壓縮函式僅管使用相同編碼，在不同的平台間傳輸，仍會有解壓失敗的狀況發生，此需注意 **。 |

###Javascript 使用
---
* 先載入必要的 js library，可以透過 [lz-string Github repository (link)](https://github.com/pieroxy/lz-string/) 進行下載。

```Html
<script type="text/javascript" src="lz-string.js" ></script>
```

* 選擇適當的壓縮編碼，底下範例使用「**valid UTF-16**」來進行壓縮與解壓縮；

```Javascript
// string 為準備進行壓縮的字串
var string = "This is the compression test.";
alert("Size of sample is: " + string.length);

// 將 string 透過 valid UTF-16 進行壓縮
// 回傳結果為 string 資料型態
var compressed = LZString.compressToUTF16(string);
alert("Size of compressed sample is: " + compressed.length);

// 將剛已被壓縮的 string 透過相對應的解壓縮函式進行解壓縮
string = LZString.decompressFromUTF16(compressed);
alert("Sample is: " + string);
```

###C-sharp 使用
---


###Python 使用
---


###Javascript 與 C-sharp 交互使用
---






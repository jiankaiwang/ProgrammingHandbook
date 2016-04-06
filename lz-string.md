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

###Javascript 使用
---


###C-sharp 使用
---


###Python 使用
---
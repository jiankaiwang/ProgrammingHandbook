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
* 先載入必要的 cs library，可以透過 [lz-string Github repository (link)](https://github.com/jawa-the-hutt/lz-string-csharp) 進行下載，再於專案中加入剛下載到的 lzstring.cs；

```
開啟 Visual studio 的專案 (.sln) > 對專案名稱點擊右鍵 > 加入現有項目 > 選擇剛下載的 「lzstring.cs」
```

加入外部資源成功並打開，會出現下列部份程式碼；

```C#
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace lz_string_csharp
{
    public class LZString
    {
        private class Context_Compress
        {
            public Dictionary<string, int> dictionary { get; set; }
            public Dictionary<string, bool> dictionaryToCreate { get; set; }
            public string c { get; set; }
            public string wc { get; set; }
            public string w { get; set; }
            public int enlargeIn { get; set; }
            public int dictSize { get; set; }
            public int numBits { get; set; }
            public Context_Compress_Data data { get; set; }
        }
        // ...
```

而因為 lz-string 中的 namespace 為 ** lz_string_csharp **，故於主程式中需要加入下列程式碼來使用此外部函式庫；

```C#
using lz_string_csharp;
```

而在 C-sharp 中使用 lz-string 函式的方法如下，舉使用編碼「** ASCII UTF-16 **」為例；

```C#
// 創建一個 LZString 的物件
LZString lzObj = new LZString();

// 假設要被進行壓縮的字串如下
string compressString = "This is a compression string.";

// 進行 ASCII UTF-16 進行壓縮為例
string getCompStr = lzObj.compressToBase64(compressString);
Console.WriteLine(getCompStr);

// 將已透過 ASCII UTF-16 壓縮的內容進行解壓縮
string getDeCompStr = lzObj.decompressFromBase64(getCompStr);
Console.WriteLine(getDeCompStr);
Console.ReadLine();
```

###Python 使用 : 需要注意　Python 需為 3.0 版本以上
---
* 先下載必要的 .py script，可以透過 [lz-string Github repository (link)](https://github.com/eduardtomasek/lz-string-python) 進行下載，再置於和主程式相同的路徑底下，可以透過兩種方式來使用此函式庫；

1. 直接開啟含有　lz-string 物件的檔案，並直接延伸進行使用
2. 假設定義 lz-string 類別檔案名稱為 lzString.py，則可以於主程式上方透過下列程式碼將此類別匯入使用

```Python
import lzString
```

底下舉第一種使用方法及使用 「** ASCII UTF-16 **」 為例；

```Python
# 產生一個 LZString 類別的物件
compObj = LZString()

# 準備要被壓縮的檔案
data = "This is a compression string."

# 進行壓縮
compressedData = compObj.compressToBase64(data)
print(compressedData)

# 解壓縮
decompressedData = compObj.decompresFromBase64(compressedData)
print(decompressedData)
```

另外，因大部分的狀況為將一檔案，如 JSON 檔案進行壓縮後傳輸，可以將資料先行毒入壓縮後寫出，如下；

```Python
# 定議資料來源與輸出資料位置
dataSrc = "source.json"
compSrc = "source_comp.json"

# 以 UTF-8 格式打開檔案
with open(dataSrc,"r", encoding="utf-8") as fin:
    compObj = LZString()
    
    # 以 binary 方式寫出檔案
    with open(compSrc,"wb") as fout:
        allData = ''
        for line in fin:
            allData = allData + line
        compData = compObj.compressToUTF16(allData)
        
        # 需要注意 python 3.0 以上需要使用 bytearray 來寫出 binary 資料串流
        fout.write(bytearray(compData, encoding="utf-16"))
```

###Javascript 與 C-sharp 交互使用
---
範例情境說明如下，

「透過 c-sharp 中 lz-string 函式將一個 JSON 型態的資料進行壓縮並寫出 binary 的檔案，然透放置於 server 中，當使用者透過瀏覽器查看頁面時，便會將此壓縮的檔案進行傳輸 (此步驟會節省時間與傳輸效率)，然後再透過 Javascript 中相對應的 lz-string 解壓函式將此內容進行解壓。」

* 原 JSON 檔案內容

```Javascript
{
	"subject":"math",
	"score":"100",
	"term":"final"
}
```

* 透過 C-sharp lz-string 中 compressToUTF16 的壓縮

```C#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using lz_string_csharp;
using System.IO;

namespace lzstring_project
{
    class Program
    {
        static void Main(string[] args)
        {
            string fin = @"dataJson.json";
            string fout = @"compData_Csharp.json";
            if (File.Exists(fin))
            {
                // read single line in each time
                // use compressToUTF16
                string content = null, getCompData = null;
                LZString lzObj = new LZString();
                using (StreamWriter sw = new StreamWriter(fout))
                {
                    using (StreamReader sr = new StreamReader(fin))
                    {
                        while (sr.Peek() >= 0)
                        {
                            // must read all content
                            content = content + sr.ReadLine();
                        }
                        getCompData = lzObj.compressToUTF16(content);
                        sw.Write(getCompData);
                    }
                }
            }
            else {
                Console.WriteLine("Error: file not found.");
            }
            Console.WriteLine("Complete");
            Console.ReadLine();
        }
    }
}
```









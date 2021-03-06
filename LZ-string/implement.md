# lz-string



## Javascript 使用

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

* 原 JSON 檔案內容，檔名為 dataJson.json

```Javascript
{
	"subject":"math",
	"score":"100",
	"term":"final"
}
```

* 透過 C-sharp lz-string 中 compressToUTF16 的壓縮，作法為透過檔案開啟後一行一行讀入，然後依續壓縮後，以 streamwriter 方式寫出檔案

| 註解 |
| -- |
| 需要注意有加入 lz-string 於 visual studio project 中，詳細步驟可以參考上述。 |

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

之後便可以將檔案放在 server ，並透過 javascript 存取該壓縮檔案的 uri ，之後於 javascript 端進行解壓縮即可，如下範例將取得的資料依序加入 id 為 menu 的 list 中；

```Html
<head>
	<script src="jquery-1.11.1.min_ori.js" type="text/javascript"></script>
	<script src="lz-string.js" type="text/javascript"></script>
</head>
<body>
<ul id="menu">
	<li>Ori</li>
</ul>
<script type="text/javascript">
function getDataBody(getData) {
	for (var line in getData) {
		$("#menu").append("<li>" + line + "->" + getData[line] + "</li>");
	}
}

function decompressData(getCompressData) {
	// json.parse transform string into json object
	getDataBody(JSON.parse(LZString.decompressFromUTF16(getCompressData)));
}

$.ajax({
  dataType: "text",
  url: "compData_Csharp.json",
  success: function(Jdata) { decompressData(Jdata); }
});
</script>
</body>
```

當然，也可以透過 python 與 javascript 的結合亦可。在上述 C-sharp 的壓縮方法中，也可以有其他的壓縮函式可以轉換，而在 javascript 中亦使用相對應的函式即可 (但需注意並非所有的函式皆可以交叉使用)，如下範例為 c-sharp 使用 「**compressToBase64**」 方式來進行壓縮。

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
                // method.2: read single line
                string content = null, getCompData = null;
                byte[] byteArray = null;
                LZString lzObj = new LZString();
                using (FileStream fs = new FileStream(fout, FileMode.OpenOrCreate))
                {
                    using (BinaryWriter bw = new BinaryWriter(fs, Encoding.Unicode))
                    {
                        using (StreamReader sr = new StreamReader(fin))
                        {
                            while (sr.Peek() >= 0)
                            {
                                // must read all content
                                content = content + sr.ReadLine();
                            }
                            getCompData = lzObj.compressToBase64(content);
                            byteArray = System.Text.Encoding.Default.GetBytes(getCompData);
                            bw.Write(byteArray);
                        }
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







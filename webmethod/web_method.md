# Web Method

<script type="text/javascript" src="../gitbook/app.js"></script>
<script type="text/javascript" src="../js/general.js"></script>

Web Method 為 ASMX 技術的其中一種，與 Web API 概念類似，可以透過 Web Method (或是 Web Services) 對資源進行 CRUD。但此技術已為較舊有技術，因為 Web Method 方式並不適合用在以 http 或 https 協定的資源存取上，主要透過 ajax 方式對相同資源(主機)進行存取，隨著近幾年技術的更新，web method 常伴隨著許多資安議題，因此已不在推薦使用。

儘管如此，許多舊有系統是依賴在 web method 技術上開發，底下透過簡單的例子來建立 web method。

###新增一個 ASMX 類別
---

於專案中加入 ASMX 類別　(對專案點擊右鍵，加入新增項目，Web 服務　ASMX)，假設名為　json.asmx。

因為大部分　Web Method 方法皆由　AJAX 方式進行存取，因此需要取消預設的註解　Script Service，如下；

```C#
namespace _20160512_WebmethodTemplate
{
    /// <summary>
    ///json 的摘要描述
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    
    // 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
    // 已取消註解
    [System.Web.Script.Services.ScriptService]
    
    public class json : System.Web.Services.WebService
    {
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
    }
}
```

###新增一個 web method 方法
---

底下為 web method 實作方式，

```C#
[WebMethod]
public String jsonData(String getPara1, Dictionary<String, String> getPara2)
{
    // use dictionary to prepare json object
    Dictionary<String, String> jsonData = new Dictionary<String, String> { };

    // add parameters
    jsonData.Add("Parameter.1", "");
    jsonData.Add("Parameter.2", getPara2["enable"]);

    switch (getPara1) {
        case "01":
            jsonData["Parameter.1"] = "type.1";
            break;
        case "02":
            jsonData["Parameter.1"] = "type.2";
            break;
        case "03":
            jsonData["Parameter.1"] = "type.3";
            break;
        default:
            jsonData["Parameter.1"] = "default";
            break;
    }

    // prepare json data
    String retJsonData = JsonConvert.SerializeObject(jsonData, Formatting.Indented);

    return retJsonData;
}
```

###於前端的使用方式
---

透過 jquery 中 $.ajax 方式來行傳輸並取得 web method 處理後的 json 資料，如下；

```Html
<!-- 先引用 jQuery 函式庫 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>

<!-- 使用方式 -->
<script>
    var getJSONData;
    $(function () {
        $.ajax({
            type: "POST",
            url: "json.asmx/jsonData",
            data: '{ getPara1: "01", getPara2 : { "enable" : "true" } }',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                getJSONData = JSON.parse(data["d"]);
            },
            beforeSend: function () {
                console.log("beforesend");
            },
            complete: function () {
                console.log("complete");
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
                alert(thrownError);
            }
        });
    });
</script>
```






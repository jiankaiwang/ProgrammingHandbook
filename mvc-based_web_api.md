# MVC-based Web API

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

Restful API 為目前主流的資料傳輸方式之一，其 JSON 資料格式更有許多標準函式庫能直接進行處理。底下透過 MVC 設計方式，創建一個 Web API。

###開發環境
---
* Visual Studio 2015 Community
* ASP.NET 4.5.2

###開始一個 VS 專案
---
由「檔案」 > 「新增」 > 「專案」 > 選擇 Visual C-sharp 「Web」 > 「ASP.NET Web 應用程式」 > 選擇 「Web API」 > 右側「變更驗證」 > 「無驗證」

![](images/webapi-jsonnet-vs-create.png)

開啟後，可以直接點擊瀏覽器來執行，此時會出現下列畫面，其網址為 ** http://localhost:9000 **

![](images/webapi/webapi-jsonnet-vs-create-frontpage.png)

此時若是將網址改成 ** http://localhost:9000/api/values **，於 「** chrome **」中會出現下列 XML 內容；

```Xml
This XML file does not appear to have any style information associated with it. The document tree is shown below.
<ArrayOfstring xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
  <string>value1</string>
  <string>value2</string>
</ArrayOfstring>
```

但若是使用 「** Internet Explorer **」則會以下載的方式出現 「** values.json **」，其內容為 json 格式，並以 list 方式出現，如下；

```Javascript
["value1","value2"]
```

###初探 Web API
---
若是打開方案總管中的 ** Global.aspx **，會看到下方的內容；

```C#
// ...

namespace webapiJsonNet
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            
            // 註冊 Web API 的路由器內容，名為 WebApiConfig
            GlobalConfiguration.Configure(WebApiConfig.Register);
            
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}
```

其中一段 GlobalConfiguration 說明了 Web API 路由設定，接著打開 ** App_Start ** 資料夾中的 ** WebApiConfig.cs **，則會出現下列程式碼；

```C#
// ...

namespace webapiJsonNet
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API 設定和服務

            // Web API 路由
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
```

* 可以看見位於 App_Start 資料夾中的 WebApiConfig.cs 定義了 Web API 的路由器
* 其中一函式 **  config.Routes.MapHttpRoute() **說明了路由位址，即網路位址的 URL
* 其中 ** name ** 為路由器名稱 (不能重複)
* ** routeTemplate ** 為路由位址，與取得參數值的方式
* ** defaults ** 則是定義取得參數的方法或該設定

因此若打開 ** Controllers ** 資料夾中，會發現有 ** ValuesController.cs ** 的類別，此類別名稱 (Values，即是控制器的名稱)，便是在 ** WebApiConfig.cs ** 中路由器所定義 routeTemplate 的 controller 名稱，因此於網頁中便可以透過 http://localhost:9000/api/Values 來存取 api，而其內容便定義下列各項 CRUD 的操作方式；

```C#
// ...

namespace webapiJsonNet.Controllers
{
    public class ValuesController : ApiController
    {
        // GET api/values
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        public void Post([FromBody]string value)
        {
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}
```

而函式 Create, Read, Update 及 Delete 便是相對應為 Post(), GET(), Put() 與 Delete() 函式，此便是可以透過 $.ajax 與。而因為網頁預設為 GET() 內容，因此當以網頁瀏覽 http://localhost:9000/api/Values 時，會直接呼叫 GET() 函式。**其中函式 GET() 被重載，因此能夠依不同的參數值而有不同的處理。**當以網頁瀏覽 http://localhost:9000/api/Values/1 時，因為有傳入 id (在 WebApiConfig.cs 中被定義為 RouteParameter.Optional)，因此會回傳 Get(int id) 執行後的結果 (即 "value")。**因為 MVC 架構下，Controller 會直接將結果傳給 View 進行呈現，因此 Controller 直接透過 return 被視為將資料傳送至前端。**

###Controller 處理回傳給 View 的物件
---
在 MVC 架構下，controller 被視成流程管理員，介接在 data module 與 view 中，因此透過 controller 可以將來自 module 的資料進行準備，然後將之回傳給 View。

常用有數種 controller 方法來準備回傳給 View 的資料，如下數種；

* 透過 IEnumerable 將以 List (即本例) 的字串物件直接回傳給 View，或是透過 dictionary 的字串物件方式。

* 在 OData 中，透過 SingleResult<ODATA> 的方式回傳給 View。

* 透過 JSON.NET 中 JsonConvert.SerializeObject(dataTable, Newtonsoft.Json.Formatting.Indented) 方式，並以 StringContent 與 HttpResponseMessage 方式將此字串回傳給 View。

接下來將會透過第一種方式 IEnumerable 來準備不同的回傳資料。

* 回傳 dictionary 型態 (key,value) 的 JSON 資料，期望呈現結果如下；
 
```Javascript
{
  "key1":"value1",
  "key2":"value2",
  "key3":"value3"
}
```
 
則其實作方式如下；

```C#
public Dictionary<string, string> Get()
{
    // 以 dictionary 方式準備資料
    Dictionary<string, string> dict = new Dictionary<string, string> { };
    dict.Add("key1", "value1");
    dict.Add("key2", "value2");
    dict.Add("key3", "value3");
    return dict;
}
```

* 回傳 dictionary 的 list 型態資料，期望呈現結果如下 (此亦為最常見的 JSON 傳輸資料方法)；

```Javascript
[
    {
        "key1":"value1",
        "key2":"value2",
        "key3":"value3"
    },
    {
        "K1":"V1",
        "K2":"V2",
        "K3":"V3"
    }
]
```

則其實作方式如下；

```C#
public IEnumerable<Dictionary<string, string>> Get()
{
    Dictionary<string, string> dict1 = new Dictionary<string, string> { };
    dict1.Add("key1", "value1");
    dict1.Add("key2", "value2");
    dict1.Add("key3", "value3");
    Dictionary<string, string> dict2 = new Dictionary<string, string> { };
    dict2.Add("K1", "V1");
    dict2.Add("K2", "V2");
    dict2.Add("K3", "V3");
    return new Dictionary<string, string>[] { dict1, dict2 };
}
```

###設定回傳的資料格式 : 以 JSON 為主要資料型態
---
於 ** Global.asax ** 設定檔案之 Application_Start() 中加入下列其中一的方法，便可以在不同瀏覽器皆顯示出 JSON 型態的資料。

* 方法一：移除 XML 格式支援

```C#
GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Clear();
```

* 方法二：於 JSON 格式中加入 header 為 text/html

```C#
GlobalConfiguration.Configuration.Formatters.JsonFormatter.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/html"));
```

* 方法三：保留 XML 設定，但調整 JSON 格式為主要呈現內容

```C#
var appXmlType = GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.FirstOrDefault(t => t.MediaType == "application/xml");
GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Remove(appXmlType);
```

###透過 URL 及路由器傳入多項參數
---

可以透過下列兩個方式來設定路由器，便可以由 URL 取得多項參數，底下以傳入五項參數為例;

傳入的參數分別為
1. apikey (api 存取金鑰)
2. service (服務名稱)
3. date (選擇的日期)
4. month (日期區間)
5. datatype (存取格式)

使用 Web API GET() 方法的連結範例如下；

```Html
<!-- 路由設計 -->
http://localhost:9000/api/values/{apikey}/{service}/{date}/{month}/{datatype}

<!-- 使用範例 -->
http://localhost:9000/api/values/xoqpkhu7/service1/20160411/12/json
```

* 方法一：透過直接設定 ** Global.asax ** 方式，於** Application_Start() **函式中加入；

```C#
GlobalConfiguration.Configuration.Routes.MapHttpRoute(
    name: "multipleparas",
    routeTemplate: "api/{controller}/{apikey}/{service}/{date}/{month}/{datatype}"
);
```

其中，** name **為路由器名稱，不可以重複，** routeTemplate **則為路由器存取路徑

* 方法二：透過 ** App_Start ** 資料夾中 ** WebApiConfig.cs ** 底下的路由器註冊函式** Register(HttpConfiguration config) **來設定；

```C#
config.Routes.MapHttpRoute(
    name: "multipleparas",
    routeTemplate: "api/{controller}/{apikey}/{service}/{date}/{month}/{datatype}"
);
```

使用方法一或方法二皆可在準備定義使用此 API 的 controller 中進行下列實作來取得資料；

```C#
public Dictionary<string, string> Get(string apikey, string service, string date, string month, string datatype)
{
    Dictionary<string, string> dict = new Dictionary<string, string> { };
    dict.Add("FETCH_apikey", apikey);
    dict.Add("FETCH_service", service);
    dict.Add("FETCH_date", date);
    dict.Add("FETCH_month", month);
    dict.Add("FETCH_datatype", datatype);
    return dict;
}
```

| 註解 |
| -- |
| 需要注意的是於路由器的定義中， ** routeTemplate ** 的 ** URL 參數位址 (如前後順序)、參數數量等都必須與 controller 中實作的傳入參數相同。此外，在傳入參數的變數名稱，也必須相同，如 apikey 及 service 等。 ** |








# MVC 透過 JSON.NET 創建 Web API

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

Restful API 為目前主流的資料傳輸方式之一，其 JSON 資料格式更有許多標準函式庫能直接進行處理。底下透過 MVC 設計方式，例用 JSON.NET 方式創建一個實作 GET 的 Web API。

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

若是打開 ** Controllers ** 資料夾中












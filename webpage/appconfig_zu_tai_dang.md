# App.config 組態檔

<script type="text/javascript" src="../js/general.js"></script>

App.config 為 C# 等微軟環境 console-based 開發語言的組態檔，類似 Web.config 於 ASP.NET 的角色。

###App.config 內容
---

```Xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <connectionStrings>
    <add name="DbConnectionString" connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=employees;User ID=ExampleUser;Password=ExampleUser" providerName="System.Data.SqlClient" />
  </connectionStrings>
  <startup> 
      <supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.5.2" />
  </startup>
</configuration>
```

###於 C# 使用 App.config
---

* 需要先加入參考 System.Configuration (System.Configuration.dll)

* 加入引用函式庫

```C#
using System.Configuration;
```

引用 app.config 內容；

```C#
// 使用 connectionStrings
string connectStr = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;
```



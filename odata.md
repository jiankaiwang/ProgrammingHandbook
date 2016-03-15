# OData
###採用架構
---
* C#
* ASP.NET 4.5.2
* Web API 2.2
* MVC 5
* OData v4.0
* Web.Odata
* Entity Framework 6
  * Entity Framework (又稱ADO.NET Entity Framework) 是微軟以 ADO.NET 為基礎所發展出來的物件關聯對應 (O/R Mapping) 解決方案，早期被稱為 ObjectSpace，現已經包含在 Visual Studio 2008 Service Pack 1 以及 .NET Framework 3.5 Service Pack 1 以上發表。
  * ADO.NET Entity Framework 以 Entity Data Model (EDM) 為主，將資料邏輯層切分為三塊，分別為 Conceptual Schema, Mapping Schema 與 Storage Schema 三層，其上還有 Entity Client，Object Context 以及 LINQ 可以使用。
  * LINQ (Language Integrated Query)，是一項微軟技術，新增一種自然查詢的 SQL 語法到.NET Framework的程式語言中。
* OData.Edm 6.14.0 (至少 6.5.0 版本以上)

###常用指令
---
| 指令 | 說明 | 範例 |
| -- | -- | -- |
| top | 挑出最前面的幾筆 | 	?$top=3 |
| skip |略過幾筆。可用於分頁顯示 | ?$skip=10 |
| orderby | 排序 | ?$orderby=SupplierID,ProductID |
| filter | 篩選 |  |
|  | gt : > , 大於 | $filter=ProductID gt 10 |
|  | lt : < , 小於 | $filter=ProductID lt 10 |
|  | ge : >=, 大於等於 | $filter=ProductID ge 10 |
|  | le : <=, 小於等於 | $filter=ProductID le 10 |
|  | eq : =, 等於 | $filter=ProductID eq 10 |
|  | ne : <>, 不等於 | $filter=ProductID ne 10 |

###實作範例
---
#####透過 Web API MVC 連結資料庫並實作出 OData RESTful 介面。

###開始一個 VS 專案
---
* 檔案 > 新增 > 專案 > 範本 > Visual C# > Web > ASP.NET Web 應用程式
* 可以選擇是否採用 MVC 架構 : 本次採用 Web API 範本為例
  * Web API (已加入 MVC 及 Web API 核心參考) > 變更驗證 > 無驗證
  * Empty (至少需勾選 Web API 核心參考)
![](webapi_mvc.png)

###安裝所需 Packages
---
* 路徑 : 工具 > NuGet 封裝管理員 > 套件管理器主控台
* 使用 OData Packages : 
```Bash
Install-Package Microsoft.AspNet.Odata
```

* 使用 Web.Odata
```Bash
Install-Package Patches.System.Web.OData -Pre
```

* 使用 OData.Edm
```Bash
Install-Package Microsoft.OData.Edm -Version 6.14.0
```

* 使用 Entity Framework : 
```Bash
Install-Package EntityFramework
```

###加入 Model
---
微軟官網上定義 「A model is an object that represents a data entity in your application.」，指出 model 就是與資料處理個體有關。<br>
* 右鍵點擊 Models 資料夾 > 加入 > 類別 (C# Class) > 取名為 Product (Product.cs)

| 註解 |
| -- |
| 一般而言，處理資料模型會將 class 放置在 Models folder，但並不強制如此作法。 |

* 加入下方類別成員定義
```csharp
namespace ProductService.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Category { get; set; }
    }
}
```

  * 其中成員 Id 是搜尋物件的 Key，Clients 可以透過此 Key 進行 Query。舉例而言，要找到物件 Product 中 Id 為 5 的搜尋方式，可以透過 URI 為 /Products(5) 來達成，而 Id 亦是後端資料庫的主要 Key (Primary Key)。

###開啟 Entity Framework
---
本次的範例將會使用 Entity Framework (EF) Code 來產生後端資料庫

| 註解 |
| -- |
| Web API Odata 可以不需要 EF，而是可以使用任何能轉換資料庫成資料模型 (models) 的資料鍵階層 (data-access layer) 皆能做為 OData 使用的 entity。 |

* 若是使用 Entity Framework，需要確認已安裝所需 Package (如上述步驟安裝 Entity Framework)
```Bash
Install-Package EntityFramework
```

* 開啟 Web.config 檔案，將下列連接字串加入 Configuration 元素中，在 configSections 元素之後加入。
```Xml
<configuration>
  <configSections>
    <!-- ... -->
  </configSections>

  <!-- Add this: -->
  <connectionStrings>
    <add name="ProductsContext" connectionString="Data Source=(localdb)\v11.0; 
        Initial Catalog=ProductsContext; Integrated Security=True; MultipleActiveResultSets=True; 
        AttachDbFilename=|DataDirectory|ProductsContext.mdf"
      providerName="System.Data.SqlClient" />
  </connectionStrings>
```

* 這項設定透過一連接字串指示要連入本機端 DB (LocalDB)。這資料庫在運行本機 APP 時會被用到。

* 下一步，加入名為 ProductsContext (ProductsContext.cs) 類別入 Models 資料夾中，並加入下方類別定義。
```csharp
using System.Data.Entity;
namespace ProductService.Models
{
    public class ProductsContext : DbContext
    {
        public ProductsContext() : base("name=ProductsContext")
        {
        }
        public DbSet<Product> Products { get; set; }
    }
}
```
其中建構子 ProductsContext() 中定義 base 的 "name=ProductsContext" 需指向 connectionStrings。

###OData Endpoint 的組態設定
---
* 開啟檔案 App_Start/WebApiConfig.cs，加入下方使用的函式庫的程式碼
```csharp
using ProductService.Models;
using System.Web.OData.Builder;
using System.Web.OData.Extensions;
```

* 加入下方程式碼入 Register method 來註冊路由器
```csharp
public static class WebApiConfig
{
    public static void Register(HttpConfiguration config)
    {
        // New code:
        ODataModelBuilder builder = new ODataConventionModelBuilder();
        builder.EntitySet<Product>("Products");
        config.MapODataServiceRoute(
            routeName: "ODataRoute",
            routePrefix: null,
            model: builder.GetEdmModel());
    }
}
```











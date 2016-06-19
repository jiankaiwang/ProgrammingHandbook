# Query from SQL Server in C#

<script type="text/javascript" src="../js/general.js"></script>

範例檔案 : 

C# 與 SQL Server 為微軟開發環境下的傳承 C, C++ 及以 .NET 框架類別庫作為基礎的程式語言與輕量化資料庫伺服器，C# 可以透過 System.Data 函式庫取得 SQL Server 資料庫的資料。

底下為幾個 C# 連接 SQL Server 例子：
1. 以 DataTable 儲存 C# 取出 SQL Server Database 內的資料，並透過 JSON.NET 將資料轉換成 JSON 格式後回傳，說明 DataTable 用法。
2. 以 List 格式回傳每筆中特定欄位的內容，說明一筆一筆資料取得方法。
3. 以 DataSet 處理 C# 取出 SQL Server Database 內的資料，並透過簡單的排序模擬對取出的資料進一步分析並重新回傳整個資料集。

###App.config 設定
---

在 App.config 設定資料庫連接字串

```XML
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

###查詢 SQL Server 並將找出的資料轉成 JSON 格式回傳
---



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

###模擬資料庫伺服器
---

即為 employees database 中 employees 的內容：

```SQL
> select top 5 * from employees;
```

```text
/* example dataset */
emp_no  birth_date  first_name  last_name  gender    hire_date
10001   1953-09-02  Georgi      Facello      M      1986-06-26
10002   1964-06-02  Bezalel     Simmel       F      1985-11-21
10003   1959-12-03  Parto       Bamford      M      1986-08-28
10004   1954-05-01  Chirstian   Koblick      M      1986-12-01
10005   1955-01-21  Kyoichi     Maliniak     M      1989-09-12
```

###查詢 SQL Server 並將找出的資料轉成 JSON 格式回傳
---

函式設計如下：

```C#
/*
* @desc : query database by SqlDataAdapter and DataTable
* @return : json string by Json.Net (might use NuGet to install)
* @param : startDate, e.g 1960-06-01
* @param : endDate, e.g. 1960-06-20
*/
internal string fetchDBDataByDateRetJson(string startDate, string endDate)
{
    // 取得 App.config 內的連接字串
    string connectionString = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;

    // save json string prepared as returned one
    String jsonData = "";

    // connect to the database
    using (SqlConnection conn = new SqlConnection(connectionString))
    {

        // prepare the sql syntax
        // use parameter-based syntax to prevent SQL-injection attacks
        string sqlStr = "select * from dbo.employees where birth_date >= @StartDate and birth_date <= @EndDate;";
        SqlCommand sqlCmd = new SqlCommand(sqlStr, conn);
        sqlCmd.Parameters.AddWithValue("StartDate", startDate);
        sqlCmd.Parameters.AddWithValue("EndDate", endDate);

        // use sql data adapter to query the database
        SqlDataAdapter sda = new SqlDataAdapter(sqlCmd);

        try
        {
            // start connection
            conn.Open();

            // query data and load into a data table
            DataTable dt = new DataTable();
            sda.Fill(dt);

            conn.Close();

            // try to transfer SQL data to the data table by the JSON.NET
            // it might use Json.Net library
            jsonData = JsonConvert.SerializeObject(dt, Newtonsoft.Json.Formatting.Indented);
        }
        catch
        {
            // use a dictionary to save status
            Dictionary<string, string> statusLog = new Dictionary<string, string>();
            statusLog.Add("status", "Fetching SQL data is failure.");
            jsonData = JsonConvert.SerializeObject(statusLog, Newtonsoft.Json.Formatting.Indented);
        }

    }

    return jsonData;
}
```


















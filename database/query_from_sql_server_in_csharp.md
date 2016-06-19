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
class TSQLQuery
{
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
}
```

而使用方式為：

```C#
// generate a object
TSQLQuery tsqlquery = new TSQLQuery();

/*
* Example.1 : fetch sql data into a datatable and transform the data into the json string
*/
System.Console.WriteLine(tsqlquery.fetchDBDataByDateRetJson("1962-06-01", "1962-06-20"));
```

###Fetch Data row by row
---

函式設計如下：

```C#
class TSQLQuery
{
  /*
  * @desc : fetch each row of data to find the detail information, this example would save emp_no
  * @return : a list to employee whose first name is the same with parameter
  * @param : getFirstName is the name for ssearching
  */
  internal List<string> fetchDBDataByNameRetList(string getFirstName) {
      string connectionString = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;

      // Return as enum list
      List<string> objectList = new List<string> { };

      // connect to the database
      using (SqlConnection conn = new SqlConnection(connectionString))
      {

          // prepare the sql syntax
          string sqlStr = "select * from dbo.employees where first_name = @first_name;";
          SqlCommand sqlCmd = new SqlCommand(sqlStr, conn);
          sqlCmd.Parameters.AddWithValue("first_name", getFirstName);

          try
          {
              // start connection
              conn.Open();

              // use sql data reader to fetch data row by row
              SqlDataReader reader = sqlCmd.ExecuteReader();

              // search all rows
              while (reader.Read())
              {
                  // use index, e.g. reader[0], reader[1], to get corresponding contents
                  objectList.Add(string.Format("{0}",reader[0]));
              }

              conn.Close();
          }
          catch
          {
              objectList = null;
          }

      }

      return objectList;
  }
}
```

使用方式如下：

```C#
// generate a object
TSQLQuery tsqlquery = new TSQLQuery();

/*
* Example.2 : fetch sql data row by row
*/
List<string> ttlObjs = tsqlquery.fetchDBDataByNameRetList("Georgi");
int ttlEmts = ttlObjs.Count;
for (int eachEmployee = 0; eachEmployee < ttlEmts; eachEmployee++) {
    System.Console.WriteLine(string.Format("Item No. {0} is {1}.", eachEmployee, ttlObjs[eachEmployee]));
}
```

###Fetch SQL data as DataTable and Modify the data table
---

函式設計如下 : 

```C#
class TSQLQuery
{
  /*
  * @desc : fetch the sql data into a datatable in dataset, and modified the data into another datatable
  * @return : a dataset conserving two datatables, one is querying from sql server, second is the modified datatable
  * @param : getFirstName is the name for ssearching
  */
  internal DataSet fetchDBDataByDateAndCal(string getFirstName) {
      string connectionString = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;

      // Return as a complete data entry
      Dictionary<string, string> objectList = new Dictionary<string, string>{ };

      // save returned data
      DataSet ret_ds = new DataSet();

      // connect to the database
      using (SqlConnection conn = new SqlConnection(connectionString))
      {

          // prepare the sql syntax
          string sqlStr = "select * from dbo.employees where first_name = @first_name;";
          SqlCommand sqlCmd = new SqlCommand(sqlStr, conn);
          sqlCmd.Parameters.AddWithValue("first_name", getFirstName);

          try
          {

              // start connection
              conn.Open();

              // query the result and save into the table
              DataSet ds = new DataSet();
              SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
              da.Fill(ds);
              da.Dispose();

              // pick up the most earilest to the company but the youngest one
              ds.Tables[0].DefaultView.Sort = "hire_date asc, birth_date desc";

              // create a new table and get the sorting result
              DataTable newdt = ds.Tables[0].DefaultView.ToTable();
              newdt.TableName = "sortOrder";

              // add a new column and give a new id
              newdt.Columns.Add("id", typeof(string));
              for (int idIndex = 0; idIndex < newdt.Rows.Count; idIndex++) {
                  newdt.Rows[idIndex]["id"] = String.Format("{0}", idIndex);
              }

              // copy tables in the origin dataset into the returned dataset
              for (int dt_index = 0; dt_index < ds.Tables.Count; dt_index++) {
                  DataTable dt_add = ds.Tables[dt_index].Copy();
                  ds.Tables.RemoveAt(dt_index);

                  // notice it must be rename to prevent override the table by function add()
                  dt_add.TableName = string.Format("{0}", dt_index);

                  ret_ds.Tables.Add(dt_add);
              }

              // sort table must proceed again 
              ret_ds.Tables["0"].DefaultView.Sort = "hire_date asc, birth_date desc";

              // add the second table
              ret_ds.Tables.Add(newdt);

              conn.Close();
          }
          catch
          {
              objectList = null;
          }

      }

      return ret_ds;
  }
}
```

使用方式為 : 

```C#
// generate a object
TSQLQuery tsqlquery = new TSQLQuery();

/*
* Example.3 : DataSet conserving two data tables, one is origin and the other is modified table
*/
// use defaultview to get sorting results
DataSet ds = tsqlquery.fetchDBDataByDateAndCal("Georgi");

// use the DefaultView to see the sorting result
for (int i = 0; i < ds.Tables.Count; i++)
{
    System.Console.WriteLine(ds.Tables[i].TableName);
}

for (int eachEmplopee = 0; eachEmplopee < ds.Tables["0"].DefaultView.Count; eachEmplopee++) {
    if (eachEmplopee > 10) { break; }
    System.Console.WriteLine(string.Format("Item No. {0}, {1}, {2}.", ds.Tables["0"].DefaultView[eachEmplopee]["emp_no"], ds.Tables["0"].DefaultView[eachEmplopee]["hire_date"], ds.Tables["0"].DefaultView[eachEmplopee]["birth_date"]));
}

// use modified table, adding a new column, to show the result
for (int eachEmplopee = 0; eachEmplopee < ds.Tables[1].Rows.Count; eachEmplopee++) {
    if (eachEmplopee > 10) { break; }
    System.Console.WriteLine(string.Format("Item No. {0}, {1}, {2}, {3}.", ds.Tables["sortOrder"].Rows[eachEmplopee]["emp_no"], ds.Tables["sortOrder"].Rows[eachEmplopee]["hire_date"], ds.Tables["sortOrder"].Rows[eachEmplopee]["birth_date"], ds.Tables["sortOrder"].Rows[eachEmplopee]["id"]));
}
```







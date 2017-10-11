# Query from SQL Server in CSharp

<script type="text/javascript" src="../js/general.js"></script>

範例檔案 : 20160619_tsqlquery.rar

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

預期結果如下 :

```Javascript
[  
  {
    "emp_no": 499708,
    "birth_date": "1962-06-12T00:00:00",
    "first_name": "Piyush",
    "last_name": "Uehara",
    "gender": "M",
    "hire_date": "1989-08-12T00:00:00"
  },
  {
    "emp_no": 499857,
    "birth_date": "1962-06-05T00:00:00",
    "first_name": "Leszek",
    "last_name": "Tempesti",
    "gender": "M",
    "hire_date": "1995-12-12T00:00:00"
  }
]
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

預期結果如下 :

```text
...
Item No. 238 is 487557.
Item No. 239 is 488563.
Item No. 240 is 489024.
Item No. 241 is 490965.
Item No. 242 is 492725.
Item No. 243 is 492776.
Item No. 244 is 493075.
Item No. 245 is 495162.
Item No. 246 is 495355.
Item No. 247 is 495789.
Item No. 248 is 497046.
Item No. 249 is 497592.
Item No. 250 is 497609.
Item No. 251 is 498809.
Item No. 252 is 499814.
```

###Fetch SQL data as DataTable and Modify the data table
---

舉對 Table 的數個欄位進行排序，並依排序內容加上新 ID。函式設計如下 : 

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

需要注意如下：
* ds.Tables[0] 表式取出 dataset 中 index 為 0 的表，即第一張表。
* 排序 data table 可以透過 ds.Tables[0].DefaultView.Sort 來進行。但此排序並非真實將表內的資料進行排序，而是以 data view 方式呈現，因此若要取得此排序的 view ，需要透過 ds.Tables[0].DefaultView.ToTable() 將此 view 轉成 data table。
* 因透過 SqlDataAdapter 填入 data set 中的 data table 為唯讀，無法直接將新的 table 直接加入，因此需要透過一新資料及當作中繼儲存原始資料表與修改後資料表的內容，而複製資料表的方式如 for 迴圈所作。
* 需要注意當創立一個新 dataset 後，若要將"多"張資料表加入此資料集，需要修改資料表名稱，若無修改，則可能造成無法填入狀況，因為資料表名稱預設皆為 "Table"，當加入第二張表以上時會發生已有此表狀況。
* 複製資料表時，無法將其 DefaultView.Sort 的內容一併複製，需要重新排序。

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

// show DefaultView.Sort result
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

有數點需要注意 :
* 僅管有針對 Table 的 DefaultView 進行排序，但表本身的資料順序並無改變，因此若是直接透過 Rows[0], Rows[1], ... 取値，仍會取得未排序的內容；而若取得排序的的內容，則可以透過 DefaultView[0], DefaultView[1], ... 等方式來取得。
* 若是當入加入資料集時已有設定 table 名稱，則可以透過 Tables["資料表名稱"] 方式來取得資料表。

預期結果如下 :

```Bash
// DefaultView.Sort result
Item No. 233385, 1985/2/9 上午 12:00:00, 1952/3/23 上午 12:00:00.
Item No. 472197, 1985/3/7 上午 12:00:00, 1959/9/20 上午 12:00:00.
Item No. 272751, 1985/3/30 上午 12:00:00, 1963/9/30 上午 12:00:00.
Item No. 235773, 1985/4/18 上午 12:00:00, 1952/7/10 上午 12:00:00.
Item No. 10909, 1985/4/21 上午 12:00:00, 1954/11/11 上午 12:00:00.
Item No. 12157, 1985/6/4 上午 12:00:00, 1960/3/30 上午 12:00:00.
Item No. 201627, 1985/6/18 上午 12:00:00, 1963/7/8 上午 12:00:00.
Item No. 436486, 1985/7/6 上午 12:00:00, 1963/5/4 上午 12:00:00.
Item No. 262615, 1985/7/16 上午 12:00:00, 1961/3/22 上午 12:00:00.
Item No. 214633, 1985/7/17 上午 12:00:00, 1957/1/27 上午 12:00:00.
Item No. 229259, 1985/7/23 上午 12:00:00, 1954/3/18 上午 12:00:00.

// modified result
Item No. 233385, 1985/2/9 上午 12:00:00, 1952/3/23 上午 12:00:00, 0.
Item No. 472197, 1985/3/7 上午 12:00:00, 1959/9/20 上午 12:00:00, 1.
Item No. 272751, 1985/3/30 上午 12:00:00, 1963/9/30 上午 12:00:00, 2.
Item No. 235773, 1985/4/18 上午 12:00:00, 1952/7/10 上午 12:00:00, 3.
Item No. 10909, 1985/4/21 上午 12:00:00, 1954/11/11 上午 12:00:00, 4.
Item No. 12157, 1985/6/4 上午 12:00:00, 1960/3/30 上午 12:00:00, 5.
Item No. 201627, 1985/6/18 上午 12:00:00, 1963/7/8 上午 12:00:00, 6.
Item No. 436486, 1985/7/6 上午 12:00:00, 1963/5/4 上午 12:00:00, 7.
Item No. 262615, 1985/7/16 上午 12:00:00, 1961/3/22 上午 12:00:00, 8.
Item No. 214633, 1985/7/17 上午 12:00:00, 1957/1/27 上午 12:00:00, 9.
Item No. 229259, 1985/7/23 上午 12:00:00, 1954/3/18 上午 12:00:00, 10.
```





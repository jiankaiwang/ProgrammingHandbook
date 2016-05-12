# MVC 透過 JSON.NET 創建 Web API

<script type="text/javascript" src="gitbook/app.js"></script>
<script type="text/javascript" src="js/general.js"></script>

Restful API 為目前主流的資料傳輸方式之一，其 JSON 資料格式更有許多標準函式庫能直接進行處理。底下透過 MVC 設計方式，例用 JSON.NET 方式創建一個實作 GET 的 Web API。

範例檔案 : 20160512_WebAPIJsonNETTemplate.rar (http://pan.baidu.com/s/1miEQCUO)

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

###創建一個 Controller
---

於 Controllers 資料夾加入一個新的 Web API 2 的 controller ，此控制器名稱為「jsonnetController」。 可以選擇「具有讀取/寫入動作的 Web API 2 控制器」。如此一來會將 CRUD 的操作預先產生，如下；

```C#
namespace WebAPIJsonNETTemplate.Controllers
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

###連接資料庫並將資料用 JSON.NET 準備
---

假設資料庫名稱為 employees，要讀取的資料表為 employees，內容如下；

| id | emp_no | birth_date | first_name | last_name | gender | hire_date |
| -- | -- | -- | -- | -- | -- | -- |
| 1 | 10001 | 1953-09-02 | Geo | Fac | M | 1986-06-26 |
| 2 | 10002 | 1964-06-02 | Bez | Sim | F | 1985-11-21 |

可以簡單透過下列 sql 指令來取得 1990-01-01 後 2 日成為員工的資料；

```Sql
select * 
from employees 
where 
  CONVERT(VARCHAR(10),DATEADD(day,2,'1990-01-01'),112) >= CONVERT(VARCHAR(10), hire_date, 112) 
  and 
  CONVERT(VARCHAR(10), hire_date, 112) >= CONVERT(VARCHAR(10),'1990-01-01',112);
```

因此後續將以 api 路由器設定取得日期 (如 1990-01-01) 與天數 (如 2)，並用 JSON.NET 方式實作出 json data。

於 jsonnetController.cs 中加入實作連接資料庫、取得資料並將之透過 JSON.NET 轉成 json string 的函式，如下；

```C#
// must using libraries
using Newtonsoft.Json;
using System.Data;
using System.Data.SqlClient;
```

```C#
private String generateJsonString(String hire_date, int getday) {
    // prepare database connection
    string connectionString = "Data Source=.\\SQLEXPRESS;Initial Catalog=employees;Persist Security Info=True;User ID=ExampleUser;Password=ExampleUser";

    // save json String
    String jsonData = "";

    // connect to the database
    using (SqlConnection conn = new SqlConnection(connectionString)) {

        // prepare the sql syntax
        string sqlStr = "select * from employees where CONVERT(VARCHAR(10),DATEADD(day,@dp,@hdate),112) >= CONVERT(VARCHAR(10), hire_date, 112) and CONVERT(VARCHAR(10), hire_date, 112) >= CONVERT(VARCHAR(10),@hdate,112);";

        // prepare sql syntax and bind the sql parameter
        SqlCommand sqlCmd = new SqlCommand(sqlStr, conn);
        sqlCmd.Parameters.AddWithValue("hdate", hire_date);
        sqlCmd.Parameters.AddWithValue("dp", getday);

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

###透過回傳 HttpResponseMessage 將 JSON.NET 內容回傳給 View
---

於繼承 ApiController 類別的 jsonnetController 的類別中，加入新的 Read 方法，如下；

```C#
// include the library to use the HttpResponseMessage class
using System.Net.Http.Headers;
```

新增一個回傳資料型態為 HttpResponseMessage 的公開 GET API 函式，並以呼叫函式的方法取得 json string，如下；

```C#
// GET: api/jsonnet/1990-01-01/2
public HttpResponseMessage Get(String hireDate, int day)
{
    // asume fetch user-defined rows at the beginning of the data table are fetched
    // use String Content to get json string
    StringContent sc = new StringContent(generateJsonString(hireDate, day));

    // set the http header
    sc.Headers.ContentType = new MediaTypeHeaderValue("application/json");

    // create a new http request to send the data in "plain text" (string)
    HttpResponseMessage resp = new HttpResponseMessage();

    // set the content is from StringContent
    resp.Content = sc;

    // return the http response text
    return resp;
}
```

| 註解 |
| -- |
| 1. 需要注意 GET 回傳為 HttpResponseMessage 資料型態，因為 JSON.NET 已經為 http 傳輸格式，並非用 String 回傳，若用 String 回傳，則回傳內容中文字會多一組雙引號，如 ** "[\r\n  {\r\n    \"emp_no\": 10082,\r\n  ** |
| 2. 若要將傳輸方式改為下載，可以將 MediaTypeHeaderValue("application/json") 改成 MediaTypeHeaderValue("application/octet-stream") |
| 3. 因為 GET 為重載函式，若是傳入參數的數目與資料類型皆相同，則 server 會不清楚傳入哪一個公開 GET() 函式，此時可以 (1) 修改其中一個 GET() 的傳入參數資料型態或數目、(2) 將另一個 GET() 進行刪除。 |

###設定路由器
---

於 App_Start 資料夾下 WebApiConfig.cs 進行設定，將此新增的 GET() 函式進行註冊，如下；

```C#
// JSON.ENT router
config.Routes.MapHttpRoute(
    name: "jsonnet",
    routeTemplate: "api/{controller}/{hireDate}/{day}"
);
```

| 註解 |
| -- |
| 需要注意的事為 routeTemplate 內定義的變數名稱需要與 GET() 函式定義的變數數目、順序與名稱皆相同，如 hireDate 與 day。 |

###設定回傳資料型態
---

雖然使用 JSON.NET 來產生 json data，但部分瀏覽器仍會以 XML 的格式輸出，因此必須將回傳資料格式強制改成 json，可以於 App_Start 資料夾下 WebApiConfig.cs 進行設定，如下；

```C#
// force return as json data type
var appXmlType = GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.FirstOrDefault(t => t.MediaType == "application/xml");
GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Remove(appXmlType);
```

###使用此 API
---

開啟瀏覽器後，依照路由器的設定 「** api/{controller}/{hireDate}/{day} **」，可以於輸入 「** http://localhost:3330/api/jsonnet/1990-01-01/2 **」 來取得 json 資料，如下；

```javascript
[
  {
    "emp_no": 10082,
    "birth_date": "1963-09-09T00:00:00",
    "first_name": "Parviz",
    "last_name": "Lortz",
    "gender": "M",
    "hire_date": "1990-01-03T00:00:00"
  },
  {
    "emp_no": 11454,
    "birth_date": "1961-08-07T00:00:00",
    "first_name": "Yolla",
    "last_name": "Zedlitz",
    "gender": "M",
    "hire_date": "1990-01-02T00:00:00"
  },
  {
    "emp_no": 12645,
    "birth_date": "1955-04-01T00:00:00",
    "first_name": "Kyoichi",
    "last_name": "Decaestecker",
    "gender": "F",
    "hire_date": "1990-01-03T00:00:00"
  }
]
```





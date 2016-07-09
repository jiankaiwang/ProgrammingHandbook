# SQL Server (T-SQL)

###更新資料表
---

```Sql
/* format */
update [table] set [column=value] where [conditions];

/* eample */
update dbo.list set enable = 0 where msgType = 'Alert';
```

###取得表格更新時間
---

假設要查詢的資料庫為 DB1，資料表為 dbo.table1，則可以透過下列程式碼取得表格最近更新時間。

```Sql
select 
  object_name(object_id) as dbname, 
  last_user_update, 
  *
from sys.dm_db_index_usage_stats  
where 
  database_id = db_id('DB1')
  and 
  object_id = object_id('dbo.table1')
```
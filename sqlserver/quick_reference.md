# Quick Reference



## Basic Operations

```sql
/* Login */
> sqlcmd –H <host,1433> -U <acc> -P <pass>

/* List Database / Keyspace */
1> select * from sys.sysdatabases

/* Use Database / Keyspace */
1> use <db> 

/* List Table / Collections / Keys */
1> select * from information_schema.TABLES

/* Column Info */
1> select * from information_schema.COLUMNS where TABLE_NAME='<table>'
```



## Users

```sql
/* Create the User */
CREATE LOGIN dbuser WITH PASSWORD = 'dbpass' GO
CREATE USER dbuser FROM LOGIN dbuser;

/* Drop the User */
DROP LOGIN dbuser;
DROP USER dbuser;

/* Assign the database */
EXEC sp_addrolemember N'db_owner', N'dbuser';
```



## 更新資料表

```sql
/* format */
update [table] set [column=value] where [conditions];

/* eample */
update dbo.list set enable = 0 where msgType = 'Alert';
```



## 取得表格更新時間

假設要查詢的資料庫為 DB1，資料表為 dbo.table1，則可以透過下列程式碼取得表格最近更新時間。

```sql
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


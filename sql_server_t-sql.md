# SQL Server (T-SQL)

###更新資料表
---

```Sql
/* format */
update [table] set [column=value] where [conditions];

/* eample */
update dbo.list set enable = 0 where msgType = 'Alert';
```
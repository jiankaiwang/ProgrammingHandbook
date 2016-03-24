# MySQL

###查詢
---

```Sql
/* syntax */
select (column as name[,column2 as name]) 
from (table as name[, table2 as name]) 
where (condition = numeric value[, condition2 = 'string value']);

/* example */
select p.name as name, s.schname as school 
from school as s, person as p 
where s.id = p.id;
```
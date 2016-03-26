# MySQL

###創造資料庫
---

```Sql
/* basic syntax */
create database (database_name);

/* 同時定義編碼 
* utf8 同時亦需定義 collate, 若是為 utf8，則 COLLATE 為 utf8_unicode_ci
*/
create database scudb CHARACTER SET utf8 COLLATE utf8_unicode_ci;
```


###查詢資料內容
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

###查詢表格欄位定義
---

```Sql
SHOW FULL COLUMNS FROM (TABLE_NAME);
```

類似結果如下；

```Sql
+----------+--------------+-----------------+------+-----+---------+----------------+---------------------------------+---------+
| Field    | Type         | Collation       | Null | Key | Default | Extra          | Privileges                      | Comment |
+----------+--------------+-----------------+------+-----+---------+----------------+---------------------------------+---------+
| id       | int(11)      | NULL            | NO   | PRI | NULL    | auto_increment | select,insert,update,references |         |
| account  | varchar(50)  | utf8_unicode_ci | YES  |     | NULL    |                | select,insert,update,references |         |
| name     | varchar(50)  | utf8_unicode_ci | YES  |     | NULL    |                | select,insert,update,references |         |
| password | varchar(100) | utf8_unicode_ci | YES  |     | NULL    |                | select,insert,update,references |         |
| enable   | int(2)       | NULL            | YES  |     | NULL    |                | select,insert,update,references |         |
| type     | int(4)       | NULL            | YES  |     | NULL    |                | select,insert,update,references |         |
+----------+--------------+-----------------+------+-----+---------+----------------+---------------------------------+---------+
```

###修改編碼定義
---
修改表格欄位編碼定義

```Sql
/* syntax */
ALTER TABLE (TABLE_NAME) CONVERT TO CHARACTER SET (ENCODING) COLLATE (ENCODING-COLLATE);

/* 修改成 utf8 */
ALTER TABLE user CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci;
```


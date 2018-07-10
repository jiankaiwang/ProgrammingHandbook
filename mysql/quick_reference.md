# Quick Reference



## Basic Operations

```sql
/* Login */
$ mysql -h <host> -P <3306> -u <acc> -p

/* List Database / Keyspace */
show databases;

/* Use Database / Keyspace */
use <dbname>;

/* Logout */
\q
```



## Database Operations

```sql
/* basic syntax */
create database dbname;

/* 同時定義編碼 
* utf8 同時亦需定義 collate, 若是為 utf8，則 COLLATE 為 utf8_unicode_ci
*/
create database scudb CHARACTER SET utf8 COLLATE utf8_unicode_ci;

/* Create the Database / Keyspace */
create database dbname;

/* Drop the Database */
drop database dbname;
```



## 查詢資料內容

```sql
/* syntax */
select (column as name[,column2 as name]) 
from (table as name[, table2 as name]) 
where (condition = numeric value[, condition2 = 'string value']);

/* example */
select p.name as name, s.schname as school 
from school as s, person as p 
where s.id = p.id;
```



## 表格操作

```sql
/* show tables */
SHOW tables [from <db>];
SHOW FULL COLUMNS FROM (TABLE_NAME);

/* Create the Collection/Table/Key */
create table tbname (id INT NOT NULL AUTO_INCREMENT, name VARCHAR(75));

/* Drop the Collection/Table */
drop table tbname;
```

查詢表格類似結果如下；

```sql
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



## 修改編碼定義

修改整個資料庫定義

```sql
/* syntax */
ALTER DATABASE (DATABASE_NAME) CONVERT TO CHARACTER SET (ENCODING) COLLATE (ENCODING-COLLATE);

/* 修改成 utf8 */
ALTER DATABASE PERSON CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci;
```

修改表格欄位編碼定義

```sql
/* syntax */
ALTER TABLE (TABLE_NAME) CONVERT TO CHARACTER SET (ENCODING) COLLATE (ENCODING-COLLATE);

/* 修改成 utf8 */
ALTER TABLE user CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci;
```


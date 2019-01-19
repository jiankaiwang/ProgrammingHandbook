# RDBMS in Python



## MySQL

```python
import mysql.connector

with mysql.connector.connect(host = "xxx.net", port = "3306",
    user = "user", password = "pwd", database = "default") as conn:    
    cursor = conn.cursor()      

    # query sql command
    cursor.execute("select * from table where date = %s;", ("19991231", ))
    curInfo = [desc[0] for desc in cursor.description]
    rawData = cursor.fetchall()

    # non-query sql command
    cursor.execute(\
        "update table set value = %s where year = %s;", ('new_value', 2000)\
    )    
    conn.commit()
```



## SQL Server

```python
import pyodbc

with pyodbc.connect(\
    'DRIVER={ODBC Driver 13 for SQL Server};SERVER=localhost;PORT=1433' + \
    ';DATABASE=Example;UID=ExampleUser;PWD=exampleuser') as cnxn:
    cursor = cnxn.cursor()

    # query sql command
    cursor.execute("SELECT * from dbo.example;", ())
    dataInRow = cursor.fetchall()

    # non-query sql command
    cursor.execute(\
        'insert into table("att1","att2") values(?,?);', \
        ('data3','2017-09-15 11:24:00')\
    )
    cursor.commit()
```



## SQLite

```python
import sqlite3 as sqlite

# connection to a sqlite database, create one if it not exists
with sqlite.connect('example.sqlite') as conn:
    cur = conn.cursor()
    
    # query sql command
    cur.execute("select * from example where id = ?;", (1,))
    dataInRow = cur.fetchall()
    
    # non-query sql command, 
    # unlike others, no need to commit()
    cur.execute(\
        "insert into example(attr1,attr2) values(?,?);", \
        ("2017-09-20","data3")\
    )
```



## PostgreSQL

```python
import psycopg2

with psycopg2.connect("host=xxx.net " + "port=5432 " + "dbname=default " + \
        "user=user " + "password=pwd") as conn:
    cur = conn.cursor()
    
    # query sql command
    cur.execute("select * from table where date = %s;", ("19991231",))
    curInfo = [desc[0] for desc in cur.description]
    rawdata = cur.fetchall()
    
    # non-query sql command
    cur.execute(\
        "update table set date = %s where col = %s;", ("19991231","value")\
    )
    conn.commit()
```


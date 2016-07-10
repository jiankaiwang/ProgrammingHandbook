# Python access MySQL

<script type="text/javascript" src="../js/general.js"></script>

###Class-based definition
---

```python
# file name: GCS.def.py
# the object designed would be used on the entry
# -*- coding:utf-8 -*-

"""
tpoic: module, sql 資料規則與限制
date: 2013.08
description:
    (1) 針對 MySQL 中 db, table, column 進行定義
"""

#---------------------------------
# 使用其他 module
#---------------------------------
import MySQLdb
#---------------------------------

#---------------------------------
# global variables
# 供其他 module 來使用變數
# genome_attr 紀錄 genome(如 plasmids) 中有那些屬性(table)
# genome_count_attr 共有幾個欄位
# genome_attr_constraint 多維紀錄每個 table，及各 column 的名字與長度
#---------------------------------
genome_attr = []
genome_count_attr = {}
genome_attr_constraint = {}
#---------------------------------

class import_def:
    global genome_attr, genome_count_attr, genome_attr_constraint
    #---------------------------------
    # data members
    # getDbName 目前的 database name
    #---------------------------------
    getDbName = ""
    #---------------------------------
    
    #---------------------------------
    # constructor
    #---------------------------------
    def __init__(self,dbName):
        self.getDbName = dbName
        self.get_tables()     
        self.count_attrs_column()  
        self.get_attr_constraint()
    #---------------------------------
    
    #---------------------------------
    # input: None
    # output: 將 datebase plasmids 裡面的 table name 取出並記錄於 plasmids_attr
    #---------------------------------
    def get_tables(self):
        try:
            plasmids_db = MySQLdb.connect(host="localhost", user="root", passwd="JKW0620_MySQL")
        except:
            print "Error: Cann`t reach the mysql server."
            return ;
        
        plasmids_cur = plasmids_db.cursor()
        try:
            plasmids_cur.execute("USE " + self.getDbName)
        except:
            print "Error: Couldn`t get right databases " + self.getDbName
            plasmids_cur.close()
            plasmids_db.close()
            return ;
        plasmids_cur.execute("SHOW TABLES")
        getTables = plasmids_cur.fetchall()
        for tName in getTables:
            if tName[0] not in genome_attr:
                # 僅取出必要的 table name
                genome_attr.append(tName[0])
        print "State: Get total tables saved in genome_attr."
        plasmids_cur.close()
        plasmids_db.close()
    #---------------------------------
    
    #---------------------------------
    # input: genome_attr
    # output: 將 table 內所有的 column 數目紀錄於 genome_count_attr
    #---------------------------------
    def count_attrs_column(self):
        plasmids_db = MySQLdb.connect(host="localhost", user="root", passwd="JKW0620_MySQL", db = self.getDbName)
        plasmids_cur = plasmids_db.cursor()
        getCount = 0
        for tableName in genome_attr:
            plasmids_cur.execute("SELECT * FROM " + tableName)
            getAll = plasmids_cur.fetchall()
            for elements in getAll:
                getCount = len(elements)
                break
            genome_count_attr.setdefault(tableName, getCount)
        plasmids_cur.close()
        plasmids_db.close()
        print "State: The column counts of each tables were saved in genome_count_attr."
    #---------------------------------
    
    #---------------------------------
    # input: MySQL database
    # output: 將 table 內所有的 column 及其 constraint 紀錄於 genome_attr_constraint
    #---------------------------------
    def get_attr_constraint(self):
        plasmids_db = MySQLdb.connect(host="localhost", user="root", passwd="JKW0620_MySQL", db = self.getDbName)
        plasmids_cur = plasmids_db.cursor()
        getAttrconstraint = {}
        for tableName in genome_attr:
            getAttrconstraint = {}
            plasmids_cur.execute("SELECT * FROM " + tableName)
            getAll = plasmids_cur.description # 取得 constraint 及其大小限制
            for elements in getAll:
                getAttrconstraint.setdefault(elements[0],elements[3])
            genome_attr_constraint.setdefault(tableName, getAttrconstraint)
        plasmids_cur.close()
        plasmids_db.close()
        print "State: Both column name and constraint were saved in genome_attr_constraint."
    #---------------------------------
    
    #---------------------------------
    # input: genome_attr
    # output: 輸出此 database 中所有的 table name
    #---------------------------------
    def showDbAndTable(self):
        print "-----------------------"
        print "Database : " + self.getDbName
        print "This dataBase includes " + str(len(genome_attr)) + " tables."
        print "The following are all tables: "
        for eTables in genome_attr:
            print "\t" + eTables
        print "-----------------------"
    #---------------------------------
```

###Usage
---

* 底下是在 python 中產生物件的使用方法。

```python
# file name: GCSSeq.py
# this python entry would use the object designed above
# -*- coding: utf-8 -*-

"""
tpoic: 新增 seq 入 database 中(MySQL)
date: 2013.08
description:
    (1) 需要先 import GCSdef(.py) 來進行前置處理
"""

#---------------------------------
# 使用其他 module
#---------------------------------
import MySQLdb
import GCSdef
#---------------------------------

#---------------------------------
# 初始化必要資訊，以供後續使用
#---------------------------------
gnome_Name = raw_input("Enter a database name: ")
gcsInit = GCSdef.import_def(gnome_Name)
#---------------------------------
```





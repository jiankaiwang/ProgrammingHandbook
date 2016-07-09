# PDO access MySQL

<script type="text/javascript" src="../js/general.js"></script>

PDO (PHP Data Object) 是一套由 PHP 直接原生支援資料庫連結的 package，解決如 mysql, mysqli 等凌亂不堪連結資料庫的方式。底下則為實作方法；

###Query : 一次取得所有欄位及所有資料列
---
* 設定 PDO Connection

```Php
# connect to mysql
$dbhost = 'localhost';
$dbuser = 'dbuser';
$dbpass = 'dbpass';
$dbname = 'dbname';
$tbname = 'tbname';

# set pdo connection and set charset
$dbh = new PDO('mysql:dbname='.$dbname.';host='.$dbhost,$dbuser,$dbpass,array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''));
```

* SQL Command 與執行

```Php
# SQL Command : method.1
$sth = $dbh->prepare("SELECT * FROM user WHERE account = :acc or type = :typ ;");
$sth->bindParam(':acc', $_GET['u'], PDO::PARAM_STR);
$sth->bindParam(':typ', $_GET['t'], PDO::PARAM_INT);

# start to execute sql command
if($sth->execute()) {
  # when executing sql command is correct, do the operation
  // ...
} else {
  # executing sql command is error
  // ...
}
```

上列方法同時指定了參數的資料型態，亦可透過底下方法透過 array 方式鍵結參數

```Php
# SQL Command : method.2
$sth = $dbh->prepare("SELECT * FROM ".$tbname." WHERE account = :acc and type = :typ;");

# 繫結參數並執行 SQL
$sth->execute(array(':acc' => $_GET['u'], ':typ' => $_GET['t']));
```

* 透過 fetchAll() 將所有資料列取出

```Php
# PDO::FETCH_ASSOC 表示透過關聯性方式將資料取出，即 key 為欄位名稱，而 value 為該欄位的值
$getRes = $sth->fetchAll(PDO::FETCH_ASSOC);

for($i = 0 ;$i < count($getRes); $i++) {
	foreach($getRes[$i] as $key => $value) {
		echo $key."->".$value."<br>";
	}
}
```

| 註解 |
| -- |
| 注意若無指示透過 PDO::FETCH_ASSOC 方式來取得資料，則同時也會回傳以數字為 key 的資料，如下<br> Array (<br> [0] => Array ( <br>[id] => 1 [0] => 1 <br>[account] => account <br>[1] => account <br>[name] => name <br>[2] => name <br>[password] => password <br>[3] => password <br>[enable] => 1 <br>[4] => 1 <br>[type] => 1 <br>[5] => 1 <br>) ) |

* 亦可以透過 fetch() 方式來一次取得一筆資料

```Php
while($getRes = $sth->fetch(PDO::FETCH_ASSOC))
{
       foreach($getRes as $key => $value) {
               echo $key."->".$value."<br>";
       }  
}
```

而完整的程式內容如下；

```Php
<?php
# connect to mysql
$dbhost = 'localhost';
$dbuser = 'dbuser';
$dbpass = 'dbpass';
$dbname = 'dbname';
$tbname = 'tbname';

# set pdo connection and set charset
$dbh = new PDO('mysql:dbname='.$dbname.';host='.$dbhost,$dbuser,$dbpass,array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''));
$sth = $dbh->prepare("SELECT * FROM user WHERE account = :acc or type = :typ ;");
$sth->bindParam(':acc', $_GET['u'], PDO::PARAM_STR);
$sth->bindParam(':typ', $_GET['t'], PDO::PARAM_INT);

if($sth->execute()) {
  # when executing sql command is correct, do the operation
  $getRes = $sth->fetchAll(PDO::FETCH_ASSOC);
  
  for($i = 0 ;$i < count($getRes); $i++) {
    foreach($getRes[$i] as $key => $value) {
        echo $key."->".$value."<br>";
    }
  }
  
} else {
  # executing sql command is error
  // ...
}
?>
```

###insert, update 與 delete
---

透過 PDO 方式連接 MySQL 並透過參數方式綁定 SQL 指令是相當方便的處理方法，而在 insert, update 與 delete 的 SQL 指令亦是相當類似的作法，底下為三種類型的 SQL 指令；

假設使用的 Table 為 usedTb，而此 Table 的 column schema 如下；

```Bash
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| account    | varchar(50)  | YES  |     | NULL    |                |
| author     | varchar(200) | YES  |     | NULL    |                |
| accyear    | varchar(50)  | YES  |     | NULL    |                |
| journal    | varchar(150) | YES  |     | NULL    |                |
| columnName | varchar(150) | YES  |     | NULL    |                |
| topic      | varchar(300) | YES  |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)
```

而 insert, update 與 delete 的 SQL 語法於 PDO 的準備如下；

```Php
<?php
# 使用的 table
$usedTb = 'usedTb';

# insert command
$insertSth = $dbh->prepare("insert into ".$usedTb."(account,author,accyear,journal,columnName,topic) values(:account,:author,:accyear,:journal,:columnName,:topic);");

# update command
$updateSth = $dbh->prepare("update ".$usedTb." set topic = :topic where account = :acc and journal = :jal");

# delete command
$deleteSth = $dbh->prepare("delete from ".$usedTb." where account = :acc;");
?>
```

而完整的執行範例如下，以 insert 為例；

```Php
<?php
# connect to mysql
$dbhost = 'localhost';
$dbuser = 'dbuser';
$dbpass = 'dbpass';
$dbname = 'dbname';
$tbname = 'tbname';

$usedTb = 'usedTb';
$dbh = new PDO('mysql:dbname='.$dbname.';host='.$dbhost,$dbuser,$dbpass,array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''));

# 在 SQL Prepare 中，可以變換 insert, update 或 delete 的 SQL 語法
$insertSth = $dbh->prepare("insert into ".$usedTb."(account,author,accyear,journal,columnName,topic) values(:account,:author,:accyear,:journal,:columnName,:topic);");

# bind parameters
$insertSth->bindParam(':account', $usedUserAcc, PDO::PARAM_STR);
$insertSth->bindParam(':author', $_POST['research-author'], PDO::PARAM_STR);
$insertSth->bindParam(':accyear', $_POST['research-year'], PDO::PARAM_STR);
$insertSth->bindParam(':journal', $_POST['research-journal'], PDO::PARAM_STR);
$insertSth->bindParam(':columnName', $_POST['research-column'], PDO::PARAM_STR);
$insertSth->bindParam(':topic', $_POST['research-topic'], PDO::PARAM_STR);

# 執行 SQL 指令
if(!($insertSth->execute())) {
  // SQL 執行錯誤處理 ...
}
?>
```







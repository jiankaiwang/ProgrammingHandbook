# PDO access MySQL

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





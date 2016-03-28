# PDO access MySQL

PDO (PHP Data Object) 是一套由 PHP 直接原生支援資料庫連結的 package，解決如 mysql, mysqli 等凌亂不堪連結資料庫的方式。底下則為實作方法；

* Query : 一次取得所有欄位及所有資料列

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
$sth->execute();
```
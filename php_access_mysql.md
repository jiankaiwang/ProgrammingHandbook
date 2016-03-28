# PHP access MySQL

網頁取得資料庫內容一直都是常會遇見的情境，底下實作數種 PHP 連接資料庫的方式。

###透過 mysqli 方式
---

* Query : fetch several columns

```Php
# connect to mysql
$dbhost = 'localhost';
$dbuser = 'dbuser';
$dbpass = 'dbpass';
$dbname = 'dbname';
$tbname = 'tbname';

# use mysqli, set charset and db
$connCheck = mysqli_connect($dbhost, $dbuser, $dbpass) or die('Error with MySQL connection');
mysqli_set_charset($connCheck,'utf8');
#printf("Initial character set: %s\n", mysqli_character_set_name($connCheck));
mysqli_select_db($connCheck,$dbname);

# parameter-based method to prevent SQL injection
$sql = mysqli_prepare($connCheck, "SELECT name,password,enable FROM ".$tbname." WHERE account = ? and type = ?;");
mysqli_stmt_bind_param($sql,'si',$_GET["u"],$_GET["t"]);

# execute sql
$executeBody = mysqli_stmt_execute($sql);

# bind results, the same with the sql command and have to list all variables output
mysqli_stmt_bind_result($sql, $name, $password, $enable);

# continue fetching the result and save as eachCol dictionary into eachData list
$eachData = array();
while(mysqli_stmt_fetch($sql)) {
    $eachCol = array();
    $eachCol["name"] = $eachData;
    $eachCol["password"] = $password;
    $eachCol["enable"] = $enable;
    array_push($eachData,$eachCol);
	echo $name.",".$password.",".$enable."<br>";
}

# close statment and free the execute
mysqli_stmt_close($sql);	
mysqli_free_result($executeBody);

# close the mysql connection
mysqli_close($connCheck);
```

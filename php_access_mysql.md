# PHP access MySQL

網頁取得資料庫內容一直都是常會遇見的情境，底下實作數種 PHP 連接資料庫的方式。

###透過 mysqli 方式
---

* Query : fetch several columns

```Php
<?php
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
?>
```

* Query : fetch all columns<br>
很多時候當欄位數很多時，若一個一個取出欄位實在不太可取，且容易有問題，因此透過 mysqli_fetch_assoc 進行關連性連結 (直接將欄位名稱當作 key，內容當作 value) 資料。

```Php
<?php
$dbhost = 'localhost';
$dbuser = 'dbuser';
$dbpass = 'dbpass';
$dbname = 'dbname';
$tbname = 'tbname';

# set the connection to the database
$con = mysqli_connect($dbhost,$dbuser,$dbpass,$dbname);
mysqli_set_charset($con,'utf8');

# Check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

# set the sql command
$sql = "SELECT * FROM ".$tbname." WHERE account = 'account' and type = 1;";

# start to query the result
$result = mysqli_query($con,$sql);

# Associative array
$row = mysqli_fetch_assoc($result);
printf ("%s (%s)\n",$row["name"],$row["enable"]);

# Free result set
mysqli_free_result($result);
mysqli_close($con);
?>
```

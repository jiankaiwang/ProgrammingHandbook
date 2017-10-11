# Curl Function

<script type="text/javascript" src="../js/general.js"></script>

###Background
---

* Many services available http/https protocol and access by browser constructed on the basis of PHP. But, software engineer may acquire another method connecting the web services without the browser. There are many other programming languages providing such services, like perl. 

* However, lots of them may suffer the web services built on the POST function, not the GET function making them easier accessing the information. The PHP Curl function could solve such problems.

###Fetch web info built on GET
---

* GET 是 php 一項很常被使用在靜態 http 傳遞訊息的方式，但 GET 會受到許多的限制，包含明文顯示在 url，長度限制等。底下便是一個利用 php 進行取得遠端資料的 curl function。

```php
<?php
# ----------------------------
# use curl to GET
# ----------------------------
# start the connection session
$ch = curl_init();

# set the connection option
curl_setopt($ch, CURLOPT_URL, "http://140.112.52.89/dynapho/core/record_body.php");

# execute to fetch the web content
curl_exec($ch);

# close the connection session
curl_close($ch);
?>
```

###Fetch web info built on POST
---

* Method.1 : 除了 GET 之外，另一種為 POST，POST 更常用在表單傳送結果中，相較於 GET，POST 因為隱藏資訊，且傳送大小，長度較長，是較為廣泛使用在傳送大量資料的方法中，底下提出第一種方法。

```php
# ---------------------------
# use curl to POST
# ---------------------------
# set the url web site
$url = 'http://140.112.52.89/dynapho/core/record_body.php';

# if the button 'name' of the form exists, the submit button must exist 'on'
$data = array('setIDText' => 'lQ5zkhs96f', 'setNewIDBtn' => 'on');

# set the text content
$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data),
    ),
);

# start to create the context
$context  = stream_context_create($options);

# start to fetch the result after post action
$result = file_get_contents($url, false, $context);

# start deal with the data
var_dump($result);
```

* Method.2 : 上例雖然可以正常取得將資料送交給 web services 並獲得結果回傳值，但並非利用 curl function，而是透過 stream_context_create 與 file_get_contents 達成傳送與接受，底下為透過 curl function 送出資料給利用 POST 來完成的 services 的網站，並取得執行完的結果。

```php
# ---------------------------
# post another example by curl
# ---------------------------
# the result web site
$toURL = "http://140.112.52.89/dynapho/core/record_body.php";

# the data sent
$post = array('setIDText' => 'lQ5zkhs96f', 'setNewIDBtn' => 'on');

# start the curl functino
$ch = curl_init();

# the context body
$options = array(
        CURLOPT_URL=>$toURL,
        CURLOPT_HEADER=>0,
        CURLOPT_VERBOSE=>0,
        CURLOPT_RETURNTRANSFER=>true,
        CURLOPT_USERAGENT=>"Chrome/38.0 (compatible;)",
        CURLOPT_POST=>true,
        CURLOPT_POSTFIELDS=>http_build_query($post),
);

# the curl option
curl_setopt_array($ch, $options);

# get curl result
$result = curl_exec($ch);

# end and close session
curl_close($ch);

# show the result
echo $result;
```






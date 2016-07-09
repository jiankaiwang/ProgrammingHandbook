# Regular Expression

###Match and Test a String
---

PHP 為動態語言，共同特色為取得使用者的輸入，文字數字的輸入為常見的方法，但單純的文字數字輸入常伴隨許多問題，如 sql injection，ajax attack 等；此外，為了能取得必要的資料，亦希望能針對有固定格式的資料進行分析或測試。而 regular expression 便是依常用的方法。

```php
<?php
# test a string whether it is meets motif_(character)_(number).png
function checkFormat($getStr) {
	if(preg_match("/motif_(\S)_(\d*).png/",$getStr)) { return true; } 
	else { return false; }
}

# usage
if(checkFormat("motif_S_1.png")) { ... }
?>
```   

###Extract from the string
---

從一文字數字組成的字串中，取出固定格式的內容。

```php
<?php
# extract the number whether it is meets motif_(character)_(number).png
function extractFormat($getStr) {
	preg_match("/motif_(\S)_(\d*).png/",$getStr,$matches);
	return $matches[2];
}

# usage, number is 7
echo "The number is: ".extractFormat("motif_S_7.png");
?>
```
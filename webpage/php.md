# PHP

<script type="text/javascript" src="../js/general.js"></script>

###List structure
---

* PHP 與 為動態語言，其變數在程序執行中，不需要固定型態別，概念雖和 C++, Java 相似，但極大的不同為
  1. 內容資料型態不一定相同，
  2. 記憶體位址不一定固定，
  3. 幾乎可以在記憶體足夠下，無限串加元素

```php
# declear a list
$newList = array();

# push a element into a list
array_push($newList,"newElements");

# pop a element from a list
$getElement = array_pop($newList);

# exists in a list or not
if(in_array("checkEles", $newList)) { ... }

# return index of the element
$count = 0;
foreach ($newList as $eachEle) {
	if($eachEle == "wanted") { break; }
	$count = $count + 1;
}

# the length of a list
print count($newList);
```

###Hash/Dictionary structure
---

* 和 list 相同，hash 資料結構在動態語言中亦是相當重要的一環，和 list 不同，hash 提供的是 "鎖" 與 "鑰匙" 的概念，利用一 "key" 可以找到相對應的 "value"，但需要注意的是，此 "key" 不能重複。此外因為是雜湊函數的概念建立的資料結構，大部分動態語言的 hash key 的排序不會和加入的順序相同，若是需要有順序的使用 key，則通常需要將過 sort 或 order。

```php
# declear a hash
$emptyHashList = array();
$newHashList = array("key1"=>"value1", "key2"=>"value2");
$preparedForDelete = array("k4"=>"v4", "k5"=>"v5");

# show the whole content of the hash
var_dump($newHashList);

# key exists in the list or not
if(array_key_exists("key1", $newHashList)) { echo "Exist"; }

# add a pair of key => value into a hash
if(! array_key_exists("new_key", $newHashList)) {
        $newHashList["new_key"] = "new_value";
}

# modify the value of special key
$preparedForDelete["k5"] = "new_v5";

# delete a pair of key => value from the hash
unset($preparedForDelete["k4"]);

# delete the whole Hash
unset($preparedForDelete);

# show the whole key of the hash
$getAllKey = array_keys($newHashList);

# the length of the hash
echo count(array_keys($newHashList));
```

###Function declear
---

```php
# function declear
function getString($str1, $str2) {
	# in php, string concatenating is achieved by '.'
	return($str1.$str2);
}

# function usage
echo getString("Hello "."world.");
```





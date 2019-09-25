# List and Dictionary


###List structure
---

* Javascript 為動態語言，其變數在程序執行中，不需要固定型態別，概念雖和 C++, Java array 相似，但極大的不同為
1. 內容資料型態不一定相同，
2. 記憶體位址不一定固定，
3. 幾乎可以在記憶體足夠下，無限串加元素

```javascript
# declear a list
var newList = new Array(10,20,30);
var newList = [10,20,30];

# push a element into a list
newList.push(100);

# pop a element from a list
var getEle = newList.pop();

# exists in a list or not
if(newList.indexOf("notShowed") > -1) { ... //exists }
else { ... //does not exist }

# return index of the element
var index = newList.indexOf(10);

# delete the element based on the special position
newList.splice(newList.indexOf(10),1);

# the length of a list
print newList.length;
```

###Hash/Dictionary structure
---

* 和 list 相同，hash 資料結構在動態語言中亦是相當重要的一環，和 list 不同，hash 提供的是 "鎖" 與 "鑰匙" 的概念，利用一 "key" 可以找到相對應的 "value"，但需要注意的是，此 "key" 不能重複。此外因為是雜湊函數的概念建立的資料結構，大部分動態語言的 hash key 的排序不會和加入的順序相同，若是需要有順序的使用 key，則通常需要將過 sort 或 order。

```javascript
// declear a hash
var hash = {};
var newHash = {};
newHash["key1"] = "value1";

// key exists in the list or not
var boolRes = "key1" in newHash;

// add a pair of key => value into a hash
newHash["key2"] = "value2";

// modify the value of special key
newHash["key1"] = "new_value1";

// delete a pair of key => value from the hash
delete newHash["key2"];

// show the whole key of the hash and its length
var hashLength = 0;
for (var name in newHash) {
	if (newHash.hasOwnProperty(name)) {
		hashLength += 1;
		// use name ...
	}
}
```
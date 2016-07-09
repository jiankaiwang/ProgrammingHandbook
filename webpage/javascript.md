# Javascript

<script type="text/javascript" src="../js/general.js"></script>

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
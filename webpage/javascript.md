# Javascript

<script type="text/javascript" src="../js/general.js"></script>

###List
---

| desc | api |
| -- | -- |
| declear a list | var newList = [10,20,30]; |
| push a element | newList.push(100); |
| pop a element | var getEle = newList.pop(); |
| index of the element | var index = newList.indexOf(10); |
| exists in a list | if(newList.indexOf("notShowed") > -1) |
| delete the element | newList.splice(newList.indexOf(10),1); |
| the length of a list | var listlen = newList.length; |

###Dictionary
---

| desc | api |
| -- | -- |
| declear a list | var newList = [10,20,30]; |
| push a element | newList.push(100); |
| pop a element | var getEle = newList.pop(); |
| index of the element | var index = newList.indexOf(10); |
| exists in a list | if(newList.indexOf("notShowed") > -1) |
| delete the element | newList.splice(newList.indexOf(10),1); |
| delete the element | newList.splice(newList.indexOf(10),1); |


###Function declear
---

```javascript
//method.1
function getString = function(str1,str2,str3) {
	return (str1 + str2 + str3);
}

//method.2
var getNum = function(num1,num2,num3) {
	return (Math.log(num1 * num2 * num3));
}

//method.3 compare to method.2
var getSimilar = getNum;
var getRes = getSimilar(1,2,4);	// 7
```


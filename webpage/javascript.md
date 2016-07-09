# Javascript

<script type="text/javascript" src="../js/general.js"></script>

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


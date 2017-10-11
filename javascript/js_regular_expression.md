# Regular expression

<script type="text/javascript" src="../js/general.js"></script>

###Match and Test a String
---

* PHP 與 Javascript 為動態語言之一，共同特色為取得使用者的輸入，文字數字的輸入為常見的方法，但單純的文字數字輸入常伴隨許多問題，如 sql injection，ajax attack，等；此外，為了能取得必要的資料，亦希望能針對有固定格式的資料進行分析或測試。而 regular expression 便是依常用的方法。

```javascript
// test e-mail whether it fits correct format
function validateEmail(email) {
	var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	return re.test(email);
}

// usage
if(validateEmail("test@test.com")) { ... }
```

###Extract from the string
---

* 從一文字數字組成的字串中，取出固定格式的內容。

```javascript
// set the data
var testStr = "hcode	d31b3c06a976a59bbba785d88b72124b543059ed321cfff118fc9be8d2965dd3";

// regular expression extraction
var getHcodeTtl = testStr.match(/hcode\t(\S*)/i);

// getHcode == "d31b3c06a976a59bbba785d88b72124b543059ed321cfff118fc9be8d2965dd3"
var getHcode = getHcodeTtl[1];
```
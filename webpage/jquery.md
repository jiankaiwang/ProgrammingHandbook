# jQuery

<script type="text/javascript" src="../js/general.js"></script>

###Background
---

* JQuery 是一套 Javascript 使用的 library。JQuery 亦有額外的擴充元件，可以參考 JQuery UI。

* JQuery 主要用於 Document Object Model (DOM) 文件的操作 (參考 HTML DOM 快速導覽)，針對物件的操作，如
  1. 文件物件、
  2. 元素物件、
  3. 事件物件、
  4. html 元素事件處理、
  5. windows 物件、
  6. 樣式設定物件、
  7. 樣式設定物件 style、
  8. html 元素物件等。

* 舉例而言，可以快速選取多個物件，並針對這些物件進行處理，並且加強了 Ajax (非同步傳輸)與事件 (Event) 的功能。

###使用 jQuery
---

* 下載 jQuery 的 .js file。有許多的公司都有出 jQuery 的版本，如 Google、Microsoft ... 等。目的是要取得 jQuery 的檔案即可，然後加入以下的 html code 於 head section 中。

```Javascript
<script src="https://dl.dropboxusercontent.com/u/45600165/elements/jquery/jquery-1.11.1.min.js"></script>
```

* 初試
  1. $ 記號是 jQuery 用來取得 html document 中的物件，而此例為所有 "div" 的元件。之後根據 JS 新增物件的方式，將所有的 div 物件加上 special 這的 class。而利用此方法便可以針對某些元件來做某些事。
  2. 而 JQuery 是針對大量批次的 div 進行處理，傳統上在 Javascript 中需要裡用迴圈來達成 事實上 $ 即為 jQuery 的意思，表示函數的方式。故 jQuery 可以寫成第二種的形式。

```Javascript
// first type
$("div").addClass("special");

// second type
jQuery("div").addClass("special");
```

* 選取元素

```html
<!-- 以下是一段簡單的 html -->
<div id="body">
  <h2>Some Header</h2>
  <div class="contents">
    <p>p1</p>
    <p>p2</p>
  </div>
</div>
```

```html
* 可以用 $("div") 選取所有的 div
* 可以用 $("#body") 選取 id 為 body 的元件
* 可以用 $("div#body") 選取標籤 div 中辨識名為 body 的物件，此與 css 的做法類似
* 可以用 $("div.contents p") 選取標籤 div 中辨識類別名為 contents 下，子標籤為 p 的物件
* 可以用 $("div > div") 選取 <div> 範圍下一層的 <div>
* 相反的，可以用 $("div:has(div)") 選取至少有包含一個 <div> 的 <div>
```

###針對物件進行處理
---

* 當我們可以選取要處理的元素時，可以有下列幾種功能
  1. 對 DOM 進行操作
  2. 增加事件處理
  3. 做一些美觀操作與設計
  4. 利用 Ajax 傳送表單內容與取得遠端文件

* 範例一：加入文字

原始 html code
```html
<a href="http://jsgears.com">jsGears</a>
<a href="http://google.com" target="_blank">Google</a>
<a href="http://amazon.com" target="_blank">Amazon</a>
```

利用 jQuery 的方法加入新的文字
```javascript
$("a[target]").append(" (New window)");
```

修改後，會呈現類似以下的 html code
```html
<a href="http://jsgears.com">jsGears</a>
<a href="http://google.com" target="_blank">Google (New window)</a>
<a href="http://amazon.com" target="_blank">Amazon (New window)</a>
```

* 範例二：選取 id 為 showBody 的物件，並修改兩個 css 的屬性

原始 html code
```html
<div id="showBody">
	<h3>This is the section.</h3>
	...
</div>
```

利用 jQuery 的方法進行圖層的修改
```javascript
$("#showBody").css({ border: "1px solid green", background: "rgba(255,128,0,0.5)" });
```

修改後的狀況
```html
<div id="showBody" style="border: 1px solid green; background: rgba(255,128,0,0.5);">
	<h3>This is the section.</h3>
	...
</div>
```

需要注意的是 jQuery、CSS 與 html style 的寫法皆不同，有些許變化，如下
```html
<!-- jQuery 寫法為 --> 
({ border: "1px solid green", background: "rgba(255,128,0,0.5)" });

<!-- CSS 寫法為 --> 
{ border: 1px solid green; background: rgba(255,128,0,0.5); };

<!-- html style 寫法為 --> 
style="border: 1px solid green; background: rgba(255,128,0,0.5);";
```

* 範例三：表單送出及輸入資料判斷

下列的原始碼，利用 .submit() 及一個新的 function 來進行表單送出資料的判斷
```html
<head>
	<style type="text/css">
		#tip { display:none; }
	</style>
	<script src="jquery-1.11.1.min_ori.js"></script>
</head>
<body>
	<form>
		請輸入姓名 
		<input type="text" id="username" name="username">
		<span id="tip">欄位必填</span>
	</form>
	<script type="text/javascript">
        // event 的 preventDefault 用於避免欄位恢復成一開始的狀態
        // .val() 用來取出 input 內的資料
		$("form").submit(function(event) {
			if($("#username").val() == "") {
				$("span#tip").show();
				event.preventDefault();
			}
		});
	</script>
</body>
```













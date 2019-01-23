# Basic jQuery


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
        // --------------------------------------------------
        // event 的 preventDefault 用於避免欄位恢復成一開始的狀態
        // .val() 用來取出 input 內的資料
        // --------------------------------------------------
		$("form").submit(function(event) {
			if($("#username").val() == "") {
				$("span#tip").show();
				event.preventDefault();
			}
		});
	</script>
</body>
```

* 範例三-二：表單送出及輸入資料判斷

```html
<head>
	<script src="jquery-1.11.1.min_ori.js"></script>
</head>
<body>
	<form action="javascript:alert( 'success!' );">
	  <div>
		<input type="text">
		<input type="submit">
	  </div>
	</form>
	<span></span>
	<script type="text/javascript">
		$( "form" ).submit(function( event ) {
		  if ( $( "input:first" ).val() === "correct" ) {
			$( "span" ).text( "Validated..." ).show();
			return;
		  }
		  // ---------------------------------------------------
          // 表示字會出現一秒後再消失
          // ---------------------------------------------------
		  $( "span" ).text( "Not valid!" ).show().fadeOut( 1000 );
		  event.preventDefault();
		});
	</script>
</body>
```

* 範例四：利用 a 來點選選單，但利用 return false 來避免換頁，且能出現隱藏的內容

```html
<head>
	<style type="text/css">
		#menu { display: none; }
	</style>
	<script src="jquery-1.11.1.min_ori.js"></script>
</head>
<body>
	<a id="open" href="#">控制面板</a> 
	<ul id="menu">  
		<li><a href="#1">控制面板首頁</a></li>  
		<li><a href="#2">編輯個人資料</a></li>  
		<li><a href="#3">個人空間管理</a></li>  
	</ul> 
	<script type="text/javascript">
		$("a#open").click(function() {
			$("#menu").show();
			return false;
		});
	</script>
</body>
```

* 範例五：利用 fastdown 來創造出類似下拉選單的效果

```html
<head>
	<style type="text/css">
		#menu { display: none; }
	</style>
	<script src="jquery-1.11.1.min_ori.js"></script>
</head>
<body>
	<a id="open" href="#">控制面板</a> 
	<ul id="menu">  
		<li><a href="#1">控制面板首頁</a></li>  
		<li><a href="#2">編輯個人資料</a></li>  
		<li><a href="#3">個人空間管理</a></li>  
	</ul> 
	<script type="text/javascript">
		$("a#open").click(function() {
			$("#menu").slideDown("fast");
			return false;
		});
	</script>
</body>
```

* 範例六：利用 animate 進行區域的動畫特效

```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
	<style type="text/css">
		A:link {color: black; text-decoration: none; font-family: Microsoft JhengHei, monospace, serif; font-weight:bold;}
		A:visited {text-decoration: none; color: black;}
		A:active {text-decoration: none}
		A:hover {color: blue;}
	</style>
</head>
<body>
	<div style="width: 100px; border: 1px solid red">
		<center><a href="http://www.google.com.tw"><span>Google</span></a></center>
	</div>
	<script>
		$("div").animate({
			width: '300px',
			padding: '20px'
		},'slow');
	</script>
</body>
```

* 範例七：利用 hide 與 $(this) 產生 self callback 的效果

```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<div style="width: 200px; border: 1px solid red">
		The first section
	</div>
	<div style="width: 200px; border: 1px solid red">
		The second section
	</div>
	<script>
		$("div").hide(1000, function() {
			$(this).show(1000);
		});
	</script>
</body>
```

* 範例八：可以利用 load 來取得外部資源，並應用於此文件中

  1. 外部資源可以是 html file 或是 xml 等資源
  2. 存取的原則是利用階層關係，如 div > h1，即表示為標籤 div 下的 h1 子標籤項目

原 html：準備被加入外部資源的對象
```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<div id="body"></div>
	<script>
		$("div").load("https://dl.dropboxusercontent.com/u/45600165/editJS/p3_insert.xml div > h1");
	</script>
</body>
```

外部資源 xml：內含有需要加入的資源 (檔名為：p3_insert.xml)
```html
<div>
	<h1>1st H1</h1>
	<h2>1st H2</h2>
	<h3>1st H3</h3>
	<h1>2nd H1</h1>
</div>
```

此種引用外部資源的方式類似於底下 html code
```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<div id="body">
		<h1>1st H1</h1>
		<h1>2nd H1</h1>
	</div>
</body>
```

* 範例九：可以利用 getJSON() function 來取得 JSON 格式的資源，並應用於此文件中

  1. $.getJSON() 即為 jQuery 定義用來取得 JSON format file 的函式

JSON 檔案 (名稱為：p4_JSON.json)
```javascript
[
	"outer item 1",
	"outer item 2",
	"outer item 3"
]
```

原始程式碼
```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<ul id="menu">
		<li>inner item 1</li>
	</ul>
	<script type="text/javascript">
		//the way to get JSON format file
		$.getJSON("https://dl.dropboxusercontent.com/u/45600165/editJS/p4_json.json",
		function(data) {
			for (var line in data) {
				$("#menu").append("<li>" +  data[line] + "</li>");
			}
		});
	</script>
</body>
```

此外部取用 JSON 格式檔案的方法類似底下的 html code
```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<ul id="menu">
		<li>inner item 1</li>
		<li>outer item 1</li>
		<li>outer item 2</li>
		<li>outer item 3</li>
	</ul>
</body>
```



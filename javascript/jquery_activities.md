# JQuery activities


###連續使用函式的特性
---

* jQuery 的特性之一，可以直接針對一個以選取的元件，進行多個函式的加成效果。簡單來說，便是針對一個物件連續性得進行多個函式。

* 範例一：連續性函式使用

一般而言，設計函式常依下列這種方式
```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<a href="#">show</a>
	<div id="menu">
		<span>1st line</span>
		<span>2nd line</span>
		<span>3rd line</span>
	</div>
	<script type="text/javascript">
		$("a").click(function() {
			$("#menu").hide(1000);
			$("#menu").css("color","blue");
			$("#menu").slidedown(1000);
		});
	</script>
</body>
```

在 jQuery 中，可以使用連續函式來達成
```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<a href="#">show</a>
	<div id="menu">
		<span>1st line</span>
		<span>2nd line</span>
		<span>3rd line</span>
	</div>
	<script type="text/javascript">
		$("a").click(function() {
			$("#menu").hide(1000).css("color","blue").slidedown(1000);
		});
	</script>
</body>
```

JQuery 的架構下，大部分的函式在處理完後，會將執行完的物件再回傳回來，因此可以接下去執行後續的函式。

* 範例二: 特別函式的使用：end() 與 find()

  1. end()：會回傳上一層找到的元素
  2. find()：類似 $() 的用法，但是找到此階層下的目標物件，而非 global
  3. 底下便是一個例子

```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<ul class="open">
		<li>this 1</li>
		<li>this 2</li>
		<li>this 3</li>
		<li><a href="#">here 1</a></li>
		<li><a href="#">here 2</a></li>
		<li><a href="#">here 3</a></li>
	</ul>
	<ul>
		<li>another 1</li>
		<li>another 2</li>
		<li>another 3</li>
		<li><a href="#">another there 1</a></li>
	</ul>
	<script type="text/javascript">
		$("ul.open")				// global 中所有類別為 open 的 ul
			.children("li")			// 此 ul 底下的 li
			.addClass("subopen")	// 此 li 新增一類別為 subopen
			.end()					// 回到上一層: ul
			.find("a")				// 找到 ul 底下的 a
			.click(function() {		// 建立針對 a click 的函式
				$(this).next().toggle();
				return false;
			})
			.end();					// 回到 a 的上一層，即為 ul
		// 此類似 stack 的資料結構，先 push ul，再 push li
		// 而後 pop li，內剩下 ul，再 push a，而後 pop a，內剩下 ul
	</script>
</body>
```

###Document 事件
---

* 在處理頁面時，會遇到當 html 文件下載完成，或是進入頁面時，需要直接引發某些事件。先前有許多方法來完成，利用 window.onload，在 body 之後寫上 onload="javascript" 來達成。

* 而在 jQuery 方面，仍有提供類似的功能，但與先前的技術不同，jQuery 的事件是遵循 W3C DOM 標準下的 DOMContentLoaded 事件。

* 而與 window.onload 不同為 DOM 僅需文件下載完成後即可觸發，而 window.onload 則是需要文件下載及內部文件、圖檔等下載都完成才會觸發。

* 很多時候，我們不需要整份 html 文件全部都載入才引發，舉例而言，當網路連線效能不佳便是一個例子。

* 此外，DOMContentLoaded 與 window.onload 另一個不同為 window.onload 並無法要求執行多個函式。

舉例如下，

```javascript
<script type="text/javascript">
	window.onload = function() {
		alert('1st message');
	};
	window.onload = function() {
		alert('2nd message');
	};
</script>
```

而 DOMContentLoaded 的方法則可以避免此類狀況發生

```javascript
<script type="text/javascript">
	$(document).ready(function() {
		alert('1st message');
	});
	$(document).ready(function() {
		alert('2nd message');
	});
</script>
```

此外， ** $(document).ready(function() ...) ** 亦可以精簡成 ** $(function() ...) **

###$() 的別名 : 相同的執行
---

* 事實上 $() 等於 jQuery() 的意義，因此可以將 $("a") 改成 jQuery("a")、$("div") 改成 jQuery("div") 或 $(document) 改成 jQuery(document) 等。但是在一些狀況下，可能無法使用 $()，例如使用其他的 javascript libraries，此時 $() 別名則可用於重新定義。jQuery 提供一個方法來處理類似的事件，利用 noConflict() 函式來處理。


常見方式如下，
```javascript
<script>
	jQuery.noConflict();
	jQuery(document).ready(function() {
		alert("No conflict");
	});
</script>
```

另外，亦可自行設定別名的方式如下
```javascript
<script>
	var $nj = jQuery.noConflict();
	$nj(document).ready(function() {
		alert("Alias name");
	});
</script>
```

###more about getJSON function
---

* Get JSON file in array(list) data

```javascript
// JSON input1
[
	"subject",
	"score",
	80
]
```

```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
	<ul id="menu">
		<li>Ori</li>
	</ul>
	<script type="text/javascript">
	$.getJSON("https://dl.dropboxusercontent.com/u/45600165/editJS/JSON_20140810_input1.json",
	// only input data in the format list array
	function(data) {
		for (var line in data) {
			$("#menu").append("<li>" + data[line] + "</li>");
		}
	});
	</script>
</body>
```

* Get JSON file in Hash:Value data

```javascript
// JSON input2
{
	"subject":"math",
	"score":"100",
	"term":"final"
}
```

```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
  <ul id="menu">
      <li>Ori</li>
  </ul>
  <script type="text/javascript">
  var num = 0;
  $.getJSON("https://dl.dropboxusercontent.com/u/45600165/editJS/JSON_20140810_input2.json",
  // only input data in the format hash:key
  function(data) {
      for (var line in data) {
          $("#menu").append("<li>" + line + "->" + data[line] + "</li>");
      }
  });
  </script>
</body>
```

* Get JSON file in both array and Hash:Value data

```javascript
//JSON input3
[
	[
		"first",
		"second",
		"third",
		"fourth",
		"fifth"
	],
	{
		"subject":"English",
		"country":"USA",
		"abbr.":"en"
	}
]
```

```html
<head>
	<script src="../libs/jquery-1.11.1.min_ori.js" type="text/javascript"></script>
</head>
<body>
<ul id="menu">
	<li>Ori</li>
</ul>
<script type="text/javascript">
$.getJSON("https://dl.dropboxusercontent.com/u/45600165/editJS/JSON_20140810_input3.json",
function(data) {
	for (var index in data) {
		// index 此時為 0,1,2,3,4,5,6,7,8,9,10 ...，可以用底下程式碼來檢查
		$("#menu").append("<li>" + index + "->" + data[index] + "</li>");
		
		switch(index) { 
        // 儘管是以 0,1,2,3,4,5,6,7,8,9,10, ... , 但仍是以 string-type 方式呈現，需用 "0"，而非 0
			case "0":
				//list type
				for(var content in data[0]) {
					$("#menu").append("<li>" + (data[index])[content] + "</li>");
				}
				break;
			case "1":
				//hash:value type
				for(var sndIndex in data[index]) {
				//sndIndex 此時為 0,1,2,3,4,5,6,7,8,9,10 ...
					$("#menu").append("<li>" + sndIndex + " -> " + (data[index])[sndIndex] + "</li>");
				}
				break;
		}
	}
});
</script>
</body>
```

###Environment condition
---

* 底下例子，可以取得包含畫面、瀏覽器與視窗的長度與寬度。

```html
<html>
	<head>
		<script type="text/javascript" src="./jquery-1.11.1.min_ori.js"></script>
		<style type="text/css">
			ul { list-style:none; }
		</style>
	</head>
	<body>
		<ul id="showSize">
			<li>Method.1 jQuery</li>
		</ul>
		<script type="text/javascript">
			$(window).resize(function() {
				$("ul#showSize li.show").remove();
				$("ul#showSize").append("<li class=\"show\">Browser viewport in height: " + $(window).height() + "</li>");
				$("ul#showSize").append("<li class=\"show\">Browser viewport in width: " + $(window).width() + "</li>");
				$("ul#showSize").append("<li class=\"show\">Html document in height: " + $(document).height() + "</li>");
				$("ul#showSize").append("<li class=\"show\">Html document in width: " + $(document).width() + "</li>");
				$("ul#showSize").append("<li class=\"show\">Screen size in height: " + screen.height + "</li>");
				$("ul#showSize").append("<li class=\"show\">Screen size in width: " + screen.width + "</li>");
			});
		</script>
	</body>
</html>
```

###Slide Vertically/Horizontally
---

* Animate Vertically : 底下的例子，可以將選單用垂直的方式移動到 tag 的位置。

```html
<html>
<head>
	<script type='text/javascript' src="./jquery-1.11.1.min_ori.js"></script>
	<script type='text/javascript'>
	// move to special section
	$(function() {
		$("#moveTOP").click(function() {
			$('html,body').animate({scrollTop: '0px'},1000);
		});
		$("#moveMIDDLE").click(function() {
			$('html,body').animate({scrollTop: $('#MIDDLE').offset().top},1000);
		});
		$("#moveEND").click(function() {
			$('html,body').animate({scrollTop: $('#END').offset().top},1000);
		});
	});
	</script>
	<style type='text/css'>
		div { clear:both; }
		div#TOP, div#MIDDLE, div#END { height: 500px; }
	</style>
</head>
<body>
	<div>
		<div id="moveTOP">TOP</div>
		<div id="moveMIDDLE">MIDDLE</div>
		<div id="moveEND">END</div>
	</div>
	<p>
	<div id="TOP">Abstract</div>
	<div id="MIDDLE">Body</div>
	<div id="END">Summary</div>
</body>
</html>
```

* Animate Horizontally : 底下的例子可以促使畫面進行水平移動。

```html
<html>
<head>
	<script type='text/javascript' src="./jquery-1.11.1.min_ori.js"></script>
	<script type='text/javascript'>
	// move to special section
	$(document).ready(function(){
		var docw = 100;
		$("#moveRight").click(function(){
			$("#view").animate({
				scrollLeft: $("#view").scrollLeft() + docw
			}, 500,function(){});   
		});
		$("#moveLeft").click(function(){
			$("#view").animate({
				scrollLeft: $("#view").scrollLeft() - docw
			}, 500,function(){});   
		});
	});
	</script>
	<style type='text/css'>
		div.btn, div#view { clear: both; }
		div.left { float:left; }
		div#body { width:500px; } /* equal to contain all components inline */
		div#view { margin: 0px auto; overflow: hidden; width: 100px; height: 100px; }
	</style>
</head>
<body>
	<div class="btn">
		<input type="button" id="moveLeft" value="<"/>
		<input type="button" id="moveRight" value=">"/>
	</div>
	<div id="view">
		<div id="body">
			<div class="left"><img src="new_facebook.png" width="100px" /></div>
			<div class="left"><img src="new_google.png" width="100px" /></div>
			<div class="left"><img src="new_googleSite.png" width="100px" /></div>
			<div class="left"><img src="new_name.png" width="100px" /></div>
			<div class="left"><img src="new_ntu.png" width="100px" /></div>
		</div>
   </div>
</body>
</html>
```

###time interval function
---

* 底下的例子，透過 jQuery 進行 time period 的控制。

```html
<html>
<head>
	<script type='text/javascript' src="./jquery-1.11.1.min_ori.js"></script>
	<script type='text/javascript'>
	// move to special section
	var count = 0;
	setInterval(
		function(){
			count += 1;
			if(count == 5) {
				$("#view").animate({
					scrollLeft: $("#view").scrollLeft() - 100*count
				}, 2000,function(){});
				count = 0;
			}
			else {
				$("#view").animate({
					scrollLeft: $("#view").scrollLeft() + 100
				}, 1000,function(){});  				
			}
		}, 3000);
	</script>
	<style type='text/css'>
		div.btn, div#view { clear: both; }
		div.left { float:left; }
		div#body { width:500px; } /* equal to contain all components inline */
		div#view { margin: 0px auto; overflow: hidden; width: 100px; height: 100px; }
	</style>
</head>
<body>
	<div id="view">
		<div id="body">
			<div class="left"><img src="new_facebook.png" width="100px" /></div>
			<div class="left"><img src="new_google.png" width="100px" /></div>
			<div class="left"><img src="new_googleSite.png" width="100px" /></div>
			<div class="left"><img src="new_name.png" width="100px" /></div>
			<div class="left"><img src="new_ntu.png" width="100px" /></div>
		</div>
   </div>
</body>
</html>
```










# AngularJS

一套由 Google 主力開發的 Javascript 架構，其關注的議題為 CRUD 的操作。而 AngularJS 有數項特性；

  * 宣告式語法 (Directives)
  * DOM Templates
  * 雙向資料繫結 (Two Way Data-Binding) :
在 View 與 Model 之間，AngularJS 架構會監控 (Watch) Model 物件的任何變化，並隨時反映到 View 上面；反之亦然。

  * 相依性注入 (Dependency Injection)
  * 支援 MVC :
在 Controllers (控制器)、Views (檢視器) 之間的切割很完整，並搭配 Modules (模組) 與 Dependency Injection (相依性注入) 方式達成分工的概念，如同 Factory (工廠)、 Service (服務)、 Provider (提供者) 與 Values (常數值) 等。

而 AngularJS 創造的目的為 CRUD 的操作，其對於 jQuery 的支援，如 DOM 操作便不是重點，儘管 AngularJS 中內建 [jqLite](http://docs.angularjs.org/api/angular.element)，但仍非主要操作模式。

### AngularJS 特性範例
---
* 先加入 AngualrJS 的函式庫

```Javascript
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.0/angular.min.js"></script>
```

* 加入宣告式語法 (Directives)，說明此份 html context 皆使用 AngularJS 的操作模式，加入 ng-app 入 html tag

```html
<!DOCTYPE html>
<html ng-app>
  <head>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.0/angular.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <title></title>
  </head>
  <body>
  </body>
</html>
```

| 註解 |
| -- |
| ng-app 當然不一定只有放在 html 屬性來控制整個 context，也可以置於 div 等；此外，亦可以指定是哪一個 ng-app 變數，如 ng-app="example" 等。 |

* Angular 表示式：呈現類似 Javascript，但不全然是 Javascript，透過 \{\{ 及 \}\} 包起來表示式。

  * 數字與字串表示式 : 加入下方內容於 &lt;body&gt; 中

```Javascript
{{ 99 }}
<br>
{{ 99 + 1 }}
<br>
{{ 99 * 2 }}
<br>
{{ 'Hello world ! AngularJS !' }}
```

  * Filter 特性 : 加入下方內容於 &lt;body&gt; 中

```Javascript
{{ 99 }}
<br>
{{ 99 + 1 | number : 2 }}
<br>
{{ 99 * 2 | currency }}
<br>
{{ 'Hello world ! AngularJS !' | uppercase }}
```

  * 資料繫結 : 加入下方內容於 &lt;body&gt; 中，並進行簡易操作。

```html
<input type="number" ng-model="quantity" ng-init="quantity = 10">
 <br>
<input type="number" ng-model="price" ng-init="price = 950">
 <br>
總價 : {{ quantity * price }}
```
透過 ng-model 標籤宣告成 Model，此 ng-model 屬性的內容則為變數的名稱。type 屬性定義此為數字。ng-init 則為初始這個 Model 的值。若是此時我們透過 jQuery 方式進行 DOM 操作更改此 input 標籤內的值，如下方程式碼

```html
<!DOCTYPE html>
<html ng-app>
<head>
  <script src="https://code.jquery.com/jquery-2.1.4.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.0/angular.min.js"></script>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
</head>

<body>
  <input type="number" ng-model="quantity" ng-init="quantity = 10" id="jqu">
   <br>
  <input type="number" ng-model="price" ng-init="price = 950">
   <br>
  總價 : {{ quantity * price }}

  <script type="text/javascript">
  $("#jqu").val("100");
  </script>
</body>
</html>
```
則 id 為 jqu 的 input 欄位不會有所反應，因目前這個欄位受到 Angular 的控制。所以當 quantity 或 price 兩個欄位任一沒有預設值，因為雙向繫結的關係，總價欄位不會出現任何資料，因此需要注意要透過 ng-init 來指定 Model 的預設值。







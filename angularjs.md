# AngularJS

一套由 Google 主力開發的 Javascript 架構，其關注的議題為 CRUD 的操作。而 AngularJS 有數項特性；

  * 宣告式語法 (Directives)
  * DOM Templates
  * 雙向資料繫結 (Two Way Data-Binding) : <br>
在 View 與 Model 之間，AngularJS 架構會監控 (Watch) Model 物件的任何變化，並隨時反映到 View 上面；反之亦然。

  * 相依性注入 (Dependency Injection)
  * 支援 MVC : <br>
在 Controllers (控制器)、Views (檢視器) 之間的切割很完整，並搭配 Modules (模組) 與 Dependency Injection (相依性注入) 方式達成分工的概念，如同 Factory (工廠)、 Service (服務)、 Provider (提供者) 與 Values (常數值) 等。

而 AngularJS 創造的目的為 CRUD 的操作，其對於 jQuery 的支援，如 DOM 操作便不是重點，儘管 AngularJS 中內建 [jqLite](http://docs.angularjs.org/api/angular.element)，但仍非主要操作模式。

###AngularJS 特性範例
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

* Angular 表示式：呈現類似 Javascript，但不全然是 Javascript，透過 \{\{ 及 \}\} 包起來表示式。


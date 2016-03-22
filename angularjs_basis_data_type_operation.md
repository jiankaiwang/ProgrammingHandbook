# 不同資料型態的操作
###記得加入 Javascript Framework
---

```html
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
```

###基本操作
---
* 可以透過 ng-bind 方式將此 view 中的物件進行資料繫結，如同下方程式碼

```html
<div ng-app="" ng-init="firstName='John'">
  <p>The name is <span ng-bind="firstName"></span></p>
</div>
```

* 承上，也可以透過 prefix (前綴) 'data-' 加入 ng-app 之前，此為另一種寫法，如下

```html
<div data-ng-app="" data-ng-init="firstName='John'">
  <p>The name is <span data-ng-bind="firstName"></span></p>
</div>
```

* 基本資料表示式，透過 \{\{ 與 \}\} 將內容表示出來，如下程式碼

```html
<div ng-app="">
  <p>My first expression: {{ 5 + 5 }}</p>
</div>
```

* 輸入內容 : 需將此物件進行繫結，並將之轉成 model，才能夠使用 AngularJS，如下

```html
<div ng-app="">
  <p>input: <input type="text" ng-model="name"></p>
  <p>這是 input: {{name}}</p>
</div>  
```

###AngularJS 應用程式
---
* AngularJS modules 定義了 AngularJS 的應用程式內容
* AngularJS controllers 則是控制此 AngularJS 應用程式流程
* ng-app 宣告式定義了此應用程式作用範圍，ng-controller 宣告了此應用程式所使用的流程處理為和

```html
<div ng-app="myApp" ng-controller="myCtrl">
  First Name: <input type="text" ng-model="firstName"><br>
  Last Name: <input type="text" ng-model="lastName"><br>
  <br>
  Full Name: {{firstName + " " + lastName}}
</div>

<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope) {
    $scope.firstName= "John";
    $scope.lastName= "Doe";
});
</script>
```


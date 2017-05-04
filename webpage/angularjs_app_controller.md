# Apps and Controllers in AngularJS

<script type="text/javascript" src="js/general.js"></script>

### Multiple Controllers within One App
---

```html
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width">
	<script type='text/javascript' src="/resource/jquery/1.12.4/jquery-1.12.4.min.js"></script>
	<script type='text/javascript' src="/resource/angularjs/1.6.4/angular.min.js"></script>
</head>
<body>

<!-- define multiple controllers within one ng-app -->
<div ng-app="myApp">
	<div ng-controller="myCtrl">
		First Name: <input type="text" ng-model="firstName"><br>
		Last Name: <input type="text" ng-model="lastName"><br>
		<br>
		Full Name: {{ firstName + " " + lastName }}
	</div>
	
	<hr />
	
	<div ng-controller="myCtrl2">
		<input type="number" ng-model="quantity" />
		<br>
		<input type="number" ng-model="price" />
		<br>
		Total : {{ quantity * price }}
	</div>
</div>

<script>
var app = angular.module('myApp', []);

app.controller('myCtrl', function($scope) {
	$scope.firstName= "John";
	$scope.lastName= "Doe";
});

app.controller('myCtrl2', function($scope) {
	$scope.quantity= 200;
	$scope.price= 30;
});
</script>

</body>
</html>
```

### Multiple Controllers related with Multiple Apps
---

* It is necessary to `bootstrap` the module for other ng-apps.

```html
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width">
	<script type='text/javascript' src="/resource/jquery/1.12.4/jquery-1.12.4.min.js"></script>
	<script type='text/javascript' src="/resource/angularjs/1.6.4/angular.min.js"></script>
</head>
<body>

<!-- First ng-app and controller -->
<div ng-app="myApp">
	<div ng-controller="myCtrl">
		First Name: <input type="text" ng-model="firstName"><br>
		Last Name: <input type="text" ng-model="lastName"><br>
		<br>
		Full Name: {{ firstName + " " + lastName }}
	</div>
</div>
	
<hr />

<!-- Second ng-app and controller -->
<div id="app2" ng-app="myApp2">
	<div ng-controller="myCtrl2">
		<input type="number" ng-model="quantity" />
		<br>
		<input type="number" ng-model="price" />
		<br>
		Total : {{ quantity * price }}
	</div>
</div>

<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope) {
	$scope.firstName= "App2 - John";
	$scope.lastName= "App2 - Doe";
});


var app2 = angular.module('myApp2', []);
app2.controller('myCtrl2', function($scope) {
	$scope.quantity= 300;
	$scope.price= 40;
});

// bootstrap the modules to have multiple ng-app 
angular.bootstrap(document.getElementById("app2"), ['myApp2']);
</script>

</body>
</html>
```
# Circle, Triangle, Rectangle, Hexagonal in CSS

<script type="text/javascript" src="../js/general.js"></script>

###Circle
---

```html
<style type="text/css">
/* circle */
#cirShape { 
	height: 40px;
	float: left;
	margin-left: 5px;
}
#cirImage { 
	height: 30px;
	margin-left: 15px;
	text-align: center;
	clear: both;
}
#cirRight { 
	width: 40px;
	height: 40px;
	position: relative;
	float: left;
	border-radius: 20px;
	-webkit-border-radius: 20px;
	-o-border-radius: 20px;
	-moz-border-radius: 20px;
	-ms-border-radius: 20px;
	background: #f1f1f1;
	/* Old browsers */
	background: -moz-linear-gradient(left,  #f1f1f1 0%, #f1f1f1 49%, #ffffff 50%, #ff0000 51%, #ff0000 100%);
	/* FF3.6+ */
	background: -webkit-gradient(linear, left top, right top, color-stop(0%,#f1f1f1), color-stop(49%,#f1f1f1), color-stop(50%,#ffffff), color-stop(51%,#ff0000), color-stop(100%,#ff0000));
	/* Chrome,Safari4+ */
	background: -webkit-linear-gradient(left,  #f1f1f1 0%,#f1f1f1 49%,#ffffff 50%,#ff0000 51%,#ff0000 100%);
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(left,  #f1f1f1 0%,#f1f1f1 49%,#ffffff 50%,#ff0000 51%,#ff0000 100%);
	/* Opera 11.10+ */
	background: -ms-linear-gradient(left,  #f1f1f1 0%,#f1f1f1 49%,#ffffff 50%,#ff0000 51%,#ff0000 100%);
	/* IE10+ */
	background: linear-gradient(to right,  #f1f1f1 0%,#f1f1f1 49%,#ffffff 50%,#ff0000 51%,#ff0000 100%);
	/* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f1f1f1', endColorstr='#ff0000',GradientType=1 );
	/* IE6-9 */
}
#cirText { 
	height: 10px;
	clear: both;
}
#cirShape, #cirImage, #cirText { 
	width: 70px;
	text-align: center;
}
</style>

<div id="cirShape">
	<div id="cirImage">	
		<div id="cirRight"></div>
	</div>
	<div id="cirText">circle</div>
</div>
```

###Triangle
---






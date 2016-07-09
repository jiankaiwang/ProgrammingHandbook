# PHP

<script type="text/javascript" src="../js/general.js"></script>

###Array
---

| desc | api |
| -- | -- |
| declear a list | $newList = array(); |
| push a element | array_push($newList,"newElements"); |
| pop a element | $getElement = array_pop($newList); |
| exists in a list | if(in_array("checkEles", $newList)) |
| the length of a list | $listLen = count($newList); |

###Function declear
---

```php
# function declear
function getString($str1, $str2) {
	# in php, string concatenating is achieved by '.'
	return($str1.$str2);
}

# function usage
echo getString("Hello "."world.");
```



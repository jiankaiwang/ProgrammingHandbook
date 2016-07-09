# Javascript

<script type="text/javascript" src="../js/general.js"></script>

| label | desc |
| -- | -- |
| self | self-constructed functions |


###List
---

| desc | api |
| -- | -- |
| declear a list | var newList = [10,20,30]; |
| push a element | newList.push(100); |
| pop a element | var getEle = newList.pop(); |
| index of the element | var index = newList.indexOf(10); |
| exists in a list | if(newList.indexOf("notShowed") > -1) |
| delete the element | newList.splice(newList.indexOf(10),1); |
| the length of a list | var listlen = newList.length; |

###Dictionary
---

| desc | api |
| -- | -- |
| declear a hash | var newHash = { }; |
| add the pair | newHash["key1"] = "value1"; |
| delete a pair | newHash.splice("key2",1); |
| key exists in hash | var boolRes = "key1" in newHash; |
| modify the value | newHash["key1"] = "new_value1"; |
| length of dictionary [self] [EnhancedJS.js] | var dictLen = getDictionaryLength(newHash); |

###Function declear
---

| desc | api |
| -- | -- |
| declear a function | function funName = function(parm1, param2) { return (); } |
| declear a function | var funName = function(parm1, param2) { return (); } |
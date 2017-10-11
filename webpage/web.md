# Javascript

<script type="text/javascript" src="../js/general.js"></script>

| label | desc |
| -- | -- |
| self | self-constructed functions |

###List
---

| desc | api |
| -- | -- |
| declear a list | var newList = [ ]; |
| push a element | newList.push(100); |
| pop a element | var getEle = newList.pop(); |
| index of the element | var index = newList.indexOf(10); |
| exists in a list | if(newList.indexOf(10) > -1) |
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

###Regular expression
---

| desc | api |
| -- | -- |
| Regular Expression | var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i; |
| Test a String | var boolRes = re.test(var testString); |
| Extract from the string | var getHcodeTtl = "hcode d31b3".match(/hcode\t(\S\*)/i); |


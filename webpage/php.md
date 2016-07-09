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

###Dictionary
---

| desc | api |
| -- | -- |
| declear a hash | $emptyHashList = array(); |
| key exists in list | if(array_key_exists("key1", $newHashList)) |
| add a pair | $newHashList["new_key"] = "new_value"; |
| modify the value of the key | $preparedForDelete["k5"] = "new_v5"; |
| delete a pair | unset($preparedForDelete["k4"]); |
| delete the whole Hash | unset($preparedForDelete); |
| show the whole key | $getAllKey = array_keys($newHashList); |

###Regular Expression
---

| desc | api |
| -- | -- |
| Match and Test a String | if(preg\_match("/motif\_(\S)\_(\d\*).png/",$getStr)) |
| Extract from the string | preg\_match("/motif\_(\S)\_(\d\*).png/",$getStr,$matches\_in\_array); |

###Function declear
---

| desc | api |
| -- | -- |
| declear a function | function funName($str1, $str2) { return ($var); } |


# Python

<script type="text/javascript" src="../js/general.js"></script>

###Data type
---

| api | desc |
| -- | -- |
| var = 100 | define a variable |
| varToStr = str(var) | to string |
| var = "100" | define a string |
| varToInt = int(var) | to integer |
| varToFloat = float(var) | to float |

###Loop
---

```python
# for loop-index
for i in range(1,10,1):
  ...
```

```python
# for loop similar with foreach
for element in ["a string","123","1.37"]:
  ...
```

```python
# while loop
while True:
  ...
```

###Function
---

```python
# declear function
def getString(str1, str2, str3):
  return str1 + str2 + str3
```

```python
# use function
getRes = getString("This ","is ","a string.")
```

###System interaction
---

* library

```python
import sys
```

* parameter

```python
# count the parameters passed
total = len(sys.argv)	
```

* get each parameters

```python
# show the parameters, start from 0(file name)
# 1-n: passed parameters
for i in range(0,len(sys.argv),1):
  print sys.argv[i]
```

###List
---

| api | desc |
| -- | -- |
| aList = [123,"A","the string"] | declear a list |
| aList.append("newOne") | push a element |
| getEle = aList.pop() | pop a element |
| if "the string" in aList: | exists in a list |
| aList.index("element") | index of the element |
| len(aList) | length of a list |

###Dictionary
---

```python
newDict = { key1 : value1, key2 : value2 }                # declear a dictionary
getKeys = newDict.keys()                                  # all keys
getValues = newDict.values()                              # all values
print newDict["k1"]                                       # find a value by key
if newDict.has_key("testKey"):                            # key exists
len(newDict.keys())                                       # dictionary length
newDict.setdefault("newKey","newValue")                   # add a pair
del newDict["newKey"]                                     # delete the pair
```

###File I/O
---

* File Input

```python
# Read file, named data, line by line
fin = open("data","r")
with fin as inputObject:
  for line in fin:
    print line
fin.close()

# Read by character
while True:
  chunk = sys.stdin.read(1)
  if chunk == '':
    break
```

* File Output

```python
# Write into file named output.txt
fout = open("output.txt","w")
fout.write( ... )
fout.close()
```

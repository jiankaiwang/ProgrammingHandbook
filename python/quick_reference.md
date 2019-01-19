# Quick Reference



## Data Type Conversion 

```python
# type of object
type(object)

# number to string
strVar = str(100)

# integer number to float number
floatNum = float(100)

# float number to integer number
num = int(math.ceil(3.14))
num = int(math.floor(3.14))

# float to string
strVar = str(3.14)
# string to integer number
num = int("100")
# integer number to float number
floatNum = float("3.14")
```



## System Interaction 

```python
# call the python script
C:\> "C:\path\python\bin\python.exe" script.py paras
$ /path/python script.py paras    # linux/mac

# passed parameters
import sys
len(sys.argv)
sys.argv[index]

# passed arguments
# (f) turn on/off switcher
# (i: or o:) (exists :) with a parameters
# (help) use as –help
# (paras=) use as –paras=value
# (opts) -f -i -o --help= --paras=
# (args) others
import sys, getopt
opts, args = getopt.getopt(\
	sys.argv[1:], "fi:o:", ["help", "paras="])
```



## String

```python
# variable declaration
strVar = "abcde"
strVar = 'abcde'

# variable declaration for multiple line
multiLineStr = """
This is first line.
This is second line.
"""

# define unicode string
strVar = u"This is the unicode string."

# components of the string
strVar[index]
strVar[startIndex : endIndex+1]
strVar[startIndex : endIndex+1 : increment ]

# concatenate the string
conStr = "This is the " + "replaced" + " " + "string."
conStr = ("There are {} {} words.").format(2,"replaced")
conStr = ("The string of number is %5.2f to fixed" % 3.14)

# count-based functions
len(str)
str.count("findStr", beg = 0, end = len(str))

# operation with the string
str.decode(encoding = "UTF-8")     # only in python 2
str.encode(encoding = "UTF-8")     # only in python 2
str.find("findStr", beg = 0, end = len(str))
str.replace(old, new)
str.split(str = "splitStr")
str.upper()
str.lower()

# test with True/False
str.isalnum()
str.isalpha()
str.isdigit()
str.islower()
str.isnumeric()
str.isupper()
```



## Branch

```python
# True / False
if state == condtion.1 :
  # run condition.1 transaction
elif state == condition.2 :
  # run condition.2 transaction
else:
  # run the other transaction
```



## Loops

```python
# for loop by the index
for index in range(start, end, increment):
  if start == 0:
    # continue statement
continue  

# for loop by the item
for item in ["item-1", "item-2", "item-3"]:
    # pass statement : nothing to do
    pass 

# while
while statement == True:
  if condition == True:
    # break statement
    break

# for loop to iteration
for key, value in ({ "val": 3.14 }).iteritems():
  # iteritems() in dictionary type

for item1, item2 in [["val", 3.14]]:
  # used in list, tuple
```



## Operators

```shell
# arithmetic
10 + 5
20 – 5
10 * 2
20 / 4
50 % 3
2 ** 3
10 // 3    # floor division

# comparison
10 == 10
2 != 3
5 > 2
4 < 6
6 >= 6
3 <= 3

# assignment
val = 10
val += 5
val -= 4
val *= 2
val /= 3
val %= 3
val **= 2
val //= 3

# bitwise (e.g. a = 8 = 1000, b = 4 = 0100)
a & b
a | b
a ^ b    # XOR
~a
a << 2   # binary left shift
a >> 2   # binary right shift

# membership
'abc' in ['abc', 'def']
100 not in [200, 300, 400]

# identity
a is b    # id(a) ?= id(b)
a is not b
```



## Numbers

```python
# variable declaration and number type conversion
val = 10         # signed integers
val = 10L        # long integers (unlimited size)
val = 2.5E2      # floating point real values
val = 1 + 2J     # complex numbers
val = int("10")         # signed integers
val = long("10L")       # long integers (unlimited size)
val = float("2.5E2")    # floating point real values
val = complex(1 + 2J)   # complex numbers
val = complex(1, 2)     # complex numbers

# built-in functions
val = abs(x)
val = cmp(x, y)   # python 2 ; -1(x<y), 0(x==y), 1(x>y)
val = max(x1, x2, ...)
val = min(x1, x2, ...)
val = pow(x, y)   # the same as x**y, xy
val = round(x, y) # round(3.1415926, 2) ~= 3.14

# math package (import math firstly)
val = math.ceil(3.14)   
val = math.floor(3.14)
val = math.exp(x)                 # ex
val = math.log(x)                 # loge(x)
val = math.log10(x)               # log10(x)
(floatVar, intVar) = math.modf(x) # (-0.3,-2) = modf(-2.3)
val = math.sqrt(x)
math.sin(x)
math.cos(x)
math.tan(x)
math.asin(x)
math.acos(x)
math.atan(x)
math.atan2(x)
math.hypot(x, y)  # calculate the Euclidean norm
math.degrees(x)   # from radians to degrees (3.14 ~= 179)
math.radians(x)   # from degrees to radians (179 ~= 3.14)

random number functions (import random firstly)
random.choice(x)      # x : list, tuple, string
random.randrange(start, stop, step)
random.random()       # between 0 ~ 1
random.seed(x)        # generate random numbers
random.shuffle(x)     # x : list or string, pass by ref
```



## Tuples

```python
# variable declaration and type conversion
tupVal = ('abc', 10, 3.14)
tupVal = (10, )                  # single element
tupVal = tuple(['abc', 10, 3.14])

# access values in the tuple
tupVal[index]
tupVal[start:end:step]
tupVal[-index]
tupVal[1:]

# update values in the tuple by reassignment
tupVal = ('def',) + tupVal[1:]   # update tupVal[0]

# concatenate the tuples
tupVal = tupVal.1 + tupVal.2

# delete the element in the tuple
tupVal = tupVal[0:1] + tupVal[2:] # del tupVal[1]

# length of the tuple
len(tupVal)

# repetition of the tuple
(1,2,3) * 4

# element in the tuple
(10) in (10, 3.14, 'abc')
```



## Lists

```shell
# variable declaration and type conversion
listVar = ["abc", "def", 10, 3.14]
listVar = ("ab,cd,10,3.14").split(',')        # py 2
listVar = list(("ab,cd,10,3.14").split(','))  # py 3
listVar = list((10, 3.14, "abc"))             # tuple

# access values in the list
listVar[index]
listVar[start:end:step]
listVar[-index]         # fetch element in reversing
listVar[1:]             # slicing the element

# length of the list
len(listVar)

# concatenate lists
[1,2,3] + ['a','b','c']
listVar.extend(['d','e','f'])    # pass by reference

# repetition of the list
[1,2,3] * 4

# update values of the element in the list
listVar[index] = new_value

# delete a specific element in the list
listVar.remove(element)

# element in the list
(3.14) in [10, 3.14, 'abc']
listVar.index(3.14)    # not found: except ValueError
listVar.count(3.14)

# stack operation
listVar.append(x)         # push a element
element = listVar.pop()   # pop a element

# others operations on the list
listVar.insert(index, object)
listVar.reverse()
listVar.sort()             # pass by reference
newList = sorted(listVar)  # pass by value
```



## Dictionaries

```python
# variable declaration and type conversion
dictVal = { "val": 3.14, "name": "PI" }
dictVal = dict(zip(["val", "name"],[3.14, "PI"]))

# access values in the dictionary
val = dictVal["val"]
val = dictVal.get('val')

# set the pair if it not exists, or returns current value
dictVal.setdefault(key, value)

# update values of the key in the dictionary
dictVal["val"] = 3.1415926
dictVal.update({ "val": 3.1415926, "lib": "math" })

# delete a specific pair in the dictionary
del dictVal["val"]
dictVal.clear()                   # clear all pairs

# length of the dictionary
len(dictVal)

# string type for print (JSON type)
str(dictVal)

# dictionary operations
newDictVal = dict.fromkeys(x)     # x : list or dict    
val = dictVal.has_key(x)

# retrieve the dictionary content
val = dictVal.items()             # return as tuples         
val = dictVal.keys()              
val = dictVal.values()               

# show the dictionary in sorting by the value
for key, value in sorted(dictVal.iteritems(), key=lambda (k,v): (v,k)):
    print "%s: %s" % (key, value)
```



## Date / Time

```python
# use necessary package
import time, datetime, calendar

# time tick from 1970/01/01 12:00am
time.time()

# get the current time in tuple format
time.localtime(time.time())

# get the current time in format
time.asctime(time.localtime(time.time()))

# set the time (2000/01/01 12:00am) in tuple format
datetime.datetime(2000,1,1,0,0,0).timetuple()

# get the calendar (2000/01/01-2000/01/31)
calendar.month(2000, 1)

# get CPU time as floating-point number of seconds
time.clock()

# get time tick from a specific time (2000/1/1)
time.mktime(datetime.datetime(2000,1,1).timetuple())

# suspend the calling for three seconds
time.sleep(3)

# customize datetime format (Sat Jan 01 00:00:00 2000)
time.strftime('%a %b %d %H:%M:%S %Y',\     
datetime.datetime(2000,1,1).timetuple())

# whether it is the leap year
calendar.isleap(2000)

# day x week matrix
calendar.monthcalendar(2000,1)
```



## Function Declaration

```python
# declare the function
def funcName(arg1, arg2, ...):
    global var1, var2
    # body to be executed
    return(val1, val2)

# use the function
(ret1, ret2) = funcName(arg1, arg2, ...)
```



## Anonymous Function 

```python
# declare the anonymous function
# , it only return 1 value
# , it owns local namespace and cannot access variables
anyFuncName = lambda arg1, arg2: arg1 + arg2

# use the anonymous function
ret = anyFuncName(arg1, arg2)
```



## Standard I/O 

```python
# standard output
print "This is the message output on python 2."
print("This is the message output on python 3.")

# standard input
raw_input("show message : ")      # python 2
input("show message : ")          # python 2 / 3
```



## Module

```python
# 1.1 : import modules
import datetime, time

# 1.2 : use modules
datetime.datetime(2000,1,1).timetuple()

# 2.1 : import modules with specific namespace
import datetime as dt, time as tm

# 2.2 : use modules by specific namespace
dt.datetime(2000,1,1).timetuple()

# 3.1 : import specific/all functions into current namespace
from datetime import datetime
from datetime import *

# 3.2 : use functions which imported into current namespace
datetime(2000,1,1).timetuple()

# locating path
import sys
sys.path

# built-in functions defined by the module
dir(datetime)

#show the name in the global and local namespaces depending on the location (or on the function)  as the dictionary
globals()
locals()

# reload the module
reload(datetime)
```



## File I/O

```python
# open the file with specific mode
# r : reading, 
# rb : reading in binary
# w : writing, 
# wb : writing in binary
# a : appending on the bottom, 
# ab : appending in binary
# buffering : 0 (no buffer), 1 (line buffer), > 1 (size)
file = open("fileName", "fileMode")
file = open("fileName", "fileMode", buffering)

# file status
file.closed        # return True / False
file.mode          # return file opening mode
file.name

# write string to the file
file.write("This is the string.")

# read fixed length string, default is 1
file.read([count])

# get current file pointer position (number)
file.teil()

# move the file pointer position (to the beginning)
# offset : the position of the pointer
# flag : 0 (absolute), 1 (relative to current), 2 (relative to end)
file.seek(offset, flag)

# auto open and close the file
with open("fileName", "r") as fin:
    for eachline in fin:
        # read in line
```



## Exception

```python
# basic declaration
try:
    # execution main body

    # raise error caught by except
    raise errorType, argument

except SystemExit, argument :
    # raised by sys.exit() function
except ArithmeticError, argument :
    # raised by numeric calculation
except AssertionError, argument :
    # raised by failure of Assert statement
except AttributeError, argument :
    # raised by failure of attribute assignment
except EOFError, argument :
    # raised by no input from raw_input() or input()
except IOError, argument :
    # raised by failure of input/ output operations
except SyntaxError, argument:
    # raised by Python syntax
except TypeError, argument :
    # raised by invalid for the data type
except ValueError, argument:
    # raised by invalid value specified
    # you could show the argument passed
except RuntimeError, argument :
    # raised by errors does not fall into any category
except:
    # for all non-defined exceptions
else:
    # execute complete and no exception found
finally:
    # is always executed in the final

# assert to evaluate the expression
# raise AssertionError while evaluation fails
assert (type(1) == int) 
```



## File Environment

```python
# necessary package
import os

# rename the file
os.rename("oldFileName", "newFileName")

# delete the file
os.remove("fileName")

# create a directory
os.mkdir("folderName")

# change the current directory
os.chdir("/path/to/new/folder")

# get the current working directory
os.getcwd()

# remove the folder 
os.rmdir("folderName")
```




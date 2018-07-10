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
























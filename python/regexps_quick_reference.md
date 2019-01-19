# RegExps Quick Reference



## Necessary Module

```python
# import base module
import re
```



## Pattern

```python
^          # beginning of line
$          # end of line
.          # any single character except newline
[...]      # any single character in brackets
[^...]     # any single character not in brackets
re*        # 0 or more of expressions
re+        # 1 or more of expressions
re?        # 0 or 1 of expressions
re{n}      # exactly n occurrences of expressions
re{n,}     # n or more of expressions
re{n,m}    # n ~ m occurrences of expressions
a | b      # matches either a or b
(re)       # group expression and remembers it
\w         # matches word characters
\W         # matches no word characters
\s         # matches whitespace (\t\n\r\f)
\S         # matches no whitespace
\d         # matches digits, equal to [0-9]
\D         # matches no digit
\B         # nonword boundary,"rub\B" rub in ruby
[aeiou]    # matches any one lowercase vowel
[0-9]      # matches any digit
[a-z]      # matches any lowercase ASCII letters
[A-Z]      # matched any uppercase ASCII letters
[^0-9]     # matches anything other than a digit
\d{3,}     # match 3 or more digits
<.*>       # Greedy: matches "<python>r>"
<.*?>      # Nongreedy:"<python>" in "<python>r>"
```



## Match

```python
# re.match(pattern, string, flags=0)
# Matching checks for the match at beginning of the string.
matchObj = re.match(\
    r'(.*) are (.*?) .*', \
    "Trees are taller than bushes.", \
    re.M | re.I)

# if there is no matching, it would return None
matchObj == None

# return the whole matching on tuple type
matchObj.groups()    
matchObj.groups()[0]

# return indexed matching items (start from 1)
matchObj.group(1)
```



## Search

```python
# re.match(pattern, string, flags=0)
# Searching checks for a match anywhere in the string.
searchObj = re.search(\
    r'.* (.*) are (.*?) .*', \
    "Search a match anywhere. Trees are taller than bushes.", \
    re.M | re.I)

# if there is no matched searching, it would return None
searchObj == None

# return the whole searching on tuple type
searchObj.groups()    
searchObj.groups()[0]

# return indexed searching items (start from 1)
searchObj.group(1)
```



## Replace

```python
# re.sub(pattern, repl, string, max=0)
# repl : replaced string
# max : substitute all occurrences unless max provided
num = re.sub(r'#.*$', "", "1234-456-789 # phone number")
num = re.sub(r'\D', "", "1234-456-789 # phone number")
```



## Option Flags

```python
# case-insensitive matching
re.I

# interprets words based on the current locale
re.L

# makes $ match the end of a line (not just end of string)
# makes ^ match the start of any line (not just start of string)
re.M

# makes a period match any character (including newline)
re.S

# interprets letters based in the Unicode character set
re.U

# permits cuter regular expression, ignoring whitespace and regards unescaped # as a comment marker
re.X
```


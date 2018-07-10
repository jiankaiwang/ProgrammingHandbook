# Jieba



## Necessary Module 

```python
# import base module
import jieba
import jieba.posseg as pseg
import jieba.analyse as analy
```



## String Cutting 

```python
# cut a string
# cut_all : true (all split conditions)
# lcut is similar with cut but it returned a list
[word for word in jieba.cut(rawString, cut_all=False)]
rawStrCutList = jieba.lcut(rawString, cut_all=False) 

# similar with the searching engine
# lcut_for_search is similar with cut_for_search but it returned a list
[word for word in jieba.cut_for_search(rawString, HMM=False)]
rawStrCutSearchList = jieba.lcut_for_search(rawString, HMM=False)
```



## ICTPOS Marking 

```python
# ICTPOS marking (詞性標註)
rawStrCut = pseg.cut(rawString)

# get all cut words with their POS
[[w.word, w.flag] for w in rawStrCut]
```



## Parallel Computing 

```python
# parallel cutting
jieba.enable_parallel(2)
```



## Self-defined Dictionary

```python
# load a user-defined keyword, and
# content in txt and one keyword in one line
# format : keyword(space)frequency(space)POS\n
# --------------
# 不一樣的 100 a
# iOS11 100 n
# iPad
# --------------
jieba.load_userdict("self-dict.txt")

# delete a keyword
jieba.del_word("iOS11")

# add a keyword for splitting the string
jieba.add_word("iOS11", freq=None, tag=None)

# add the frequency
jieba.suggest_freq("iOS11", tune=True)
```



## Tokenize : Position on Text

```python
# tokenize : get position on the string
[[tk[0],tk[1],tk[2]] for tk in jieba.tokenize(rawString)]

# tokenize in searching mode
[[kw[0],kw[1],kw[2]] for kw in jieba.tokenize(rawString, mode='search')]
```



## Keyword Extraction 

```python
# word analyses in TF-IDF method
analy.extract_tags(rawString, topK=10, \
    withWeight=False, allowPOS=('ns', 'n', 'vn', 'v'))

# word analysis in textrank algorithm
analy.textrank(rawString, topK=10, \
    withWeight=False, allowPOS=('ns', 'n', 'vn', 'v'))
```








# gzip in Python

<script type="text/javascript" src="../js/general.js"></script>

gzip 為 Unix 中常見的檔案壓縮與解壓縮演算法，底下透過 Python 實作 gzip 壓縮。

範例檔案 ： 20160526_gzipInPython.rar

###使用 packages
---

```Python
# coding=utf-8
import gzip
import cStringIO
import codecs
import json
```

###壓縮
---

```Python
def compressFileToString(inputFile):
  """
  read the given open file, compress the data and return it as string.
  and now is string type, does not matter the length of string
  """
  stream = cStringIO.StringIO()
  compressor = gzip.GzipFile(fileobj=stream, mode='w')
  while True:  # until EOF
    chunk = inputFile.read(8192)
    if not chunk:  # EOF?
      compressor.close()
      return stream.getvalue()
    # chunk is string type
    compressor.write(chunk)
```

###解壓縮
---

```Python
def decompressStringToFile(value):
  global getDeData
  """
  decompress the given string value (which must be valid compressed gzip
  data) and write the result in the given open file.
  """
  stream = cStringIO.StringIO(value)
  decompressor = gzip.GzipFile(fileobj=stream, mode='r')
  while True:  # until EOF
    chunk = decompressor.read(8192)
    if not chunk:
      decompressor.close()
      return 
    # the 
    getDeData += chunk
```

###實作方式 
---

```Python
# start here
gzipData = ''
fileIn = "data/village.json"
compFile = "data/datac.gz"
dcFile = "data/datac.json"

with open(fileIn,"r") as fin:
    gzipData = compressFileToString(fin)
    # the compressed file is binary data
    with open(compFile,"wb") as fout:
        fout.write(gzipData)   

gzipDcData = ''                                                
with open(compFile,"rb") as fin:
    gzipDcData = fin.read()

getDeData = ''        
with codecs.open(dcFile,"w","utf-8") as fout:
    decompressStringToFile(gzipDcData)
    # chunk is string type, use unicode() to transform into utf-8
    #print type('中文'), type(unicode('中文','utf-8'))
    fout.write(unicode(getDeData,'utf-8'))
```




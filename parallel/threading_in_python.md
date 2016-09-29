# Threading in Python

<script type="text/javascript" src="../js/general.js"></script>

### Supported Package
---

* [thread](https://docs.python.org/2/library/thread.html)
* [threading](https://docs.python.org/2/library/threading.html)

### Not Synchronized Threading and No Critical Section issue
---

* 使用狀況 : 最純粹的執行緒使用
  * 執行緒運行中各自不需要溝通
  * 並無關鍵區域(存取相同變數値)問題

* 範例 :
  * package : thread
  * 將字串傳入不同執行緒，每一個執行緒皆等待數秒後標準輸出字串
  * 需要注意傳入 thread 主體中要以 tuple 為資料結構

```python
# coding:utf-8

import thread
import time

# 
# desc : threading body
# retn : none
# oupt : string
#
def Threadfun(string, sleeptime, *args):
    print '{0}_start\n'.format(string)
    time.sleep(sleeptime)
    print '{0}_end\n'.format(string)

#
# desc : entry body and start different threads
#
if __name__ == "__main__":
    for i in range(1,5):
        # thread passed values by tuple
        thread.start_new_thread(Threadfun, ("ThreadFun in id " + str(i), i))
```

### Not Synchronized Threading but a Critical Section issue
---
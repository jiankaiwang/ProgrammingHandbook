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

* 使用狀況 : 大多數的使用狀況，如不同使用者啟動功能後，獨立完成一連串功能後，將狀態値紀錄起來等
  * 執行緒運行中各自不需要溝通
  * ** 有關鍵區域(存取相同變數値)問題 **

* 範例 :
  * package : threading
  * 關鍵區域問題透過 lock 方式解決，針對共同存取的變數值進行鎖定，一次僅一個執行緒能寫入。透過定義threading.Lock() 來標示要鎖定的對象，而透過鎖定此對象的 acquire 與 release 區域來達成關鍵變數値存取即可。
  * 需要注意傳入執行緒主體中要以 tuple 為資料結構
  * 本範例分成 control (有進行 lock) 與 test (無 lock) 的結果

```python
# coding: utf-8 

import threading
import time

def worker(num):
    global execThreadTest
    
    time.sleep(1)   
    execThreadTest += num  
    return
    
def workerControl(num):
    global execThreadControl
    
    time.sleep(1)
    
    # critial section beginning
    link.acquire()
    
    execThreadControl += num
    
    # critial section ending
    link.release()    
    return

# variable execThreadTest and execThreadControl to simulate the critial object
execThreadTest = 0
execThreadControl = 0

# variable link to control critial section
link = threading.Lock()

for index in range(1,1001,1):
    test = threading.Thread(target=worker, args=(index,))
    test.start()    
    control = threading.Thread(target=workerControl, args=(index,))
    control.start()

while execThreadTest < 1 or  execThreadControl < 1:       
    time.sleep(2)
    print "Control (lock) : ", execThreadControl,", and TEST (no lock) : ", execThreadTest
```

* 類似輸出結果

```bash
# example.1
Control (lock) :  500500 , and TEST (no lock) :  495619

# example.2
Control (lock) :  500500 , and TEST (no lock) :  499587
```

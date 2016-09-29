# Threading in Python

<script type="text/javascript" src="../js/general.js"></script>

### Not Synchronized Threading and No Critical Section issue
---

* package : thread

```python
# coding:utf-8

import thread
import time

# threading body
def Threadfun(string, sleeptime, *args):
    print '{0}_start\n'.format(string)
    time.sleep(sleeptime)
    print '{0}_end\n'.format(string)

# entry body
if __name__ == "__main__":
    for i in range(1,5):
        # thread passed values by tuple
        thread.start_new_thread(Threadfun, ("ThreadFun in id " + str(i), i))
```

### Not Synchronized Threading but a Critical Section issue
---
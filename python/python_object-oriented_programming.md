# Object-Oriented Programming

<script type="text/javascript" src="../js/general.js"></script>

###Class definition
---

```Python
# ------------------------------------------
# ----- class definition (eachData.py) -----
# --- Save as .py that could be included ---
# ------------------------------------------
# -*- coding:utf-8 -*-

class returnBlock:
    # -------------
    # private data member
    # -------------

    __proteinID = ""
    __sequence = 0.0
    __premz = {}
    __mserr = {}
	
    # -------------
    # public data member
    # -------------
	
    addOrNot = 0

    # -------------
    # public function member
    # -------------

    def getAccno(self):
        return self.__proteinID

    def getDetails(self,option,getMass):
        if option == 0:
            print "There are", len(self.__premz), "data"
        elif option == 1:
            print getMass, ".pre:", self.__premz[getMass]
            print getMass, ".mas:", self.__mserr[getMass]
        else:
            for im in self.__premz.keys():
                print im, self.__premz[im], self.__mserr[im]

    def saveDataIn(self,spect,precursor,masserror):
        self.__premz.setdefault(spect,precursor)
        self.__mserr.setdefault(spect,masserror)

    def saveAccCoverage(self,accno,coverage):
        self.__proteinID = accno
        self.__sequence = coverage

    # -------------
    # private function member
    # -------------
		
    def __init__(self):
        self.__proteinID = ""
        self.__sequence = 0
        self.__premz = {}
        self.__mserr = {}
```

###Create objects
---

```Python
# -*- coding:utf-8 -*-
# include the package
import eachData

# build a new object from the class above
newRetData = eachData.returnBlock()    # constructor
newRetData.saveAccCoverage(tmp[0],tmp[3])
newRetData.saveDataIn(tmp[2],tmp[4],tmp[5])

# use a object
newRetData.addOrNot = 1
newRetData.getAccno()
newRetData.getDetails(0,"")
newRetData.getDetails(1,"2969")
newRetData.getDetails(2,"")
```











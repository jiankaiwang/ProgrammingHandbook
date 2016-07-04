# S4 Class 使用

<script type="text/javascript" src="../js/general.js"></script>

範例檔案 : 20160704_

###宣告物件
---

* 宣告名為 ClassExample 的物件
  1. 成員變數 data，資料型頹 data.frame
  2. 成員變數 data 的初始値為 data.frame(matrix(...))
  3. validity() 為驗證資料値是否正確

```R
# ********** define a class naming ClassExample **********
ClassExample <- setClass(
  # Set the name for the class
  "ClassExample",
  
  # Define the slots
  slots = c(
    data = "data.frame"
  ),
  
  # Set the default values for the slots. (optional)
  prototype=list(
    data = data.frame(matrix(cbind(c(4.17,5.58),c(4.81,4.17)),nrow=2,ncol=2,dimnames = list(c(1:2),c("control","test"))))
  ),
  
  # Make a function that can test to see if the data is consistent.
  # This is not called if you have an initialize function defined!
  validity=function(object)
  {
    if(length(object@data) < 0) {
      return("Data is empty.")
    }
    return(TRUE)
  }
)

```

###創建函式
---

* 必需先註冊函式名，再指派哪一個物件類型可以傳入
  1. setGeneric : use the setGeneric function to reserve the function name
  2. setMethod : after setGeneric(), setMethod() is used to define which function is called based on the class names of the objects sent to it

```R
setGeneric(
  name="linearRegression",
  def=function(theObject)
  {
    standardGeneric("linearRegression")
  }
)

setMethod(
  f="linearRegression",
  signature="ClassExample",
  definition=function(theObject)
  {
    return(lm(control~test,theObject@data))
  }
)
```

###使用方式
---

```R
# prepare data
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
examDT <- data.frame(matrix(cbind(ctl,trt),nrow = 10,ncol = 2,dimnames = list(c(1:10),c("control","test"))))

# create a object
genObj <- ClassExample(data=examDT)

# check object
isS4(genObj)

# slot names
slotNames(genObj)
slotNames("ClassExample")

# slot data type
getSlots("ClassExample")

# resign slot data
slot(genObj,"data") <- examDT

# use the function for the class
getLinReg <- linearRegression(genObj)
```










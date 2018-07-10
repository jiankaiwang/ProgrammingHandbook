# Numpy



* Reference : [http://www.numpy.org/](http://www.numpy.org/)



## Necessary Module 

```python
# import base module
import numpy as np
```



## Array Creation

```python
np.array([1,2,3])           # declare 1 x n
np.array((1,2),dtype=np.float) # declare by type
np.array([[4,5,6],[7,8,9]]) # declare m x n
arrayObj.shape              # dimension
arrayObj.strides            # memory size in one row
arrayObj.flags              # array flag information
arrayObj.shape = (i, j)     # reshape
arrayObj.reshape((i, j))    # reshape
arrayObj.dtype == 'int32'   # data type
set(np.typeDict.values())   # get all type list
np.arange(0,10,0.1)         # 0 to 10 by 0.1
np.linspace(0,100,11)       # 0 to 10 in 11 nums
np.logspace(0,2,5)         # 100-102 in 5 nums
np.logspace(0,1,12,base=2,endpoint=False)
np.empty((2,3),np.int)      # create without init
np.zeros((2,3),np.float)    # array with all zero
np.ones((2,3),np.float)     # array with all one
np.zeros_like(arrayObj)     # refer to arrayObj
np.ones_like(arrayObj)      # refer to arrayObj
np.fromstring(arrayObj,np.init8) # string to ASCII
np.random.rand(3)           # create 3 random nums

# ixj matrix from the self-defined function
def fun(i,j):
	return(i%4+j%5)
np.fromfunction(fun,(10,5))

# create in the anonymous function
np.fromfunction((lambda i: i%4+1),(10,))
```



## Array Access

```python
arrayObj[0]                      # access index 0
arrayObj[0:len(arrayObj):2]      # access items by 2
arrayObj[:3:2]                   # start to 3 by 2
arrayObj[3::2]                   # 3 to end by 2
arrayObj[:-1:3]                  # 0 to (end-1) by 3
arrayObj[arrayObj > 5]           # access by conditions
arrayObj[np.array([True,False,True])] # must be boolean
arrayObj[3,8]                    # access by row,column
arrayObj[3:5,8::2]               # supported 1d access              
arrayObj[slice(3,5),slice(8,None,2)] # == [3:5,8::2]
arrayObj[(0,1),(1,2)]            # access (0,1), (1,2)
arrayObj[0:1,[1,2]]              # access (0,1), (0,2)
arrayObj[[1,2]]                  # == [[1,2],:]
```



## Data Structure

```python
# self-defined data structure and 
# align=True (internal storage control)
personType = np.dtype({\
    'names':['name','age','weight'], \
    'formats':['S32','i','f']}, \
    align=True)

# variable declaration and usage
persons = np.array([('a',20,50.2),('b',30,55.6)], \
	dtype=personType)
persons[0]['name']

# nested structure
employee = np.dtype({\
    'names':['person','number'], \
    'formats':[personType,'i']
})

# variable declaration in nested structure and usage
employees = np.array([(persons[0], 1)], dtype=employee)
employees[0]['person']['name']
```






# Object-Oriented Quick Reference



## Class

```python
class Employee:
    'The class is set for employee information'
    # static data member
    employeeCount = 0
    
    # public data member
    name = ""

    # private data member    
    __salary = 0  
    
    # public member function
    def getSalary(self):
        return self.__salary
        
    def setSalary(self, salary):
        self.__setSalaryBody(salary)
        
    # private member function
    def __setSalaryBody(self, salary):
        try:
            rawSalary = float(salary)
            self.__salary = int(round(rawSalary,0))
        except ValueError:
            self.__salary = -1
        
    # initializer (including constructor __new__)
    def __init__(self, name, salary):
        # access the object member
        self.name = name
        self.__salary = salary
        
        # access the class (static) member
        Employee.employeeCount += 1

    # destructor
    def __del__(self):
        pass
```



## Object

```python
# create a object
employee1 = Employee("name", 1380000)
employee2 = Employee("name", 1400000)
print("Id of employee1 : " + str(id(employee1)))
print("Id of employee2 : " + str(id(employee2)))

# access the public member
print("employee1 name : " + employee1.name)
print("employee1 salary : " + str(employee1.getSalary()))

employee1.name = "new name"
employee1.setSalary(1500000)
print("employee1 name : " + employee1.name)
print("employee1 salary : " + str(employee1.getSalary()))

# access the static member
print("Total employees : " + str(Employee.employeeCount))

# delete the object
del employee1
del employee2
```



## Built-in Attribute

```python
# information of the Employee class
print(Employee.__doc__)

# the name of the class
print(Employee.__name__)

# module defined in the class
print(Employee.__module__)

# base classes
print(Employee.__bases__)
```



## Self-defined Attribute

```python
# create a object
employee = Employee("name", 1600000)

# --- method.1 : access by the function ---
# does object has attribute
if not hasattr(employee, 'age'):
    # set the attribute
    setattr(employee, 'age', 28)
    
# modify the attribute
setattr(employee, 'age', 29)

# get the attribute
print('employee age : ' + str(getattr(employee, 'age')))

# delete the attribute
delattr(employee, 'age')
# -----------------------------------------

# --- method.2 : access by the member ---
# does object has attribute
if not hasattr(employee, 'group'):
    # add the attribute
    employee.group = 'ict' 
    
# modify the attribute
employee.group = 'ict/ds'  

# get the attribute
print('employee group : ' + employee.group)

# delete the attribute
del employee.group
# ---------------------------------------

# delete the object
del employee
```



## Base Classes

```python
class Employee:
    'The class is set for employee information.'
    
    employeeCount = 0
    name = ""
    __salary = 0  

    def getSalary(self):
        return self.__salary
        
    def setSalary(self, salary):
        self.__setSalaryBody(salary)
        
    def __setSalaryBody(self, salary):
        try:
            rawSalary = float(salary)
            self.__salary = int(round(rawSalary,0))
        except ValueError:
            self.__salary = -1
        
    def __init__(self, name, salary):
        self.name = name
        self.__salary = salary
        Employee.employeeCount += 1

class Exchange:
    'The class is set for the concurrency exchange.'
    
    def getExchangeRate(self, country):
        if country == "us":
            return(1)
        elif country == "tw":
            return(31)
        elif country == "cn":
            return(5)
    
    def __init__(self):
        pass
```



## Inheritance

```python
# based on public inheritance
class Stuff(Employee, Exchange):
    'The class Stuff inherited from Employee and Exchange'
    
    __group = "" 
    
    def __groupMapSalary(self, group):
        if group in ["ict","iot","ds","ft","medinfo"]:
            return(1200000)
        else:
            return(1100000)
        
    # overloading bulit-in methods
    def __str__(self):
        return('Stuff name is %s in group %s and the salary is %d' % \
        (self.name, self.__group, self.getSalary()))        
        
    # overloading the function from parent
    def getExchangeRate(self, country):
        if country == "us":
            return(1 * self.getSalary())
        elif country == "tw":
            return(31 * self.getSalary())
        elif country == "cn":
            return(5 * self.getSalary())
        
    def __init__(self, name, group):
        # initialize the parent object
        # initialization is not necessary for the inheritance
        Employee.__init__(self, name, self.__groupMapSalary(group))
        
        # initialize the child object
        self.__group = group
        
    def __del__(self):
        pass
```



## Implementation 

```python
# create a object            
stuff = Stuff("example","ict")    

# is only allowed access public member from parent object
print("public member in 1st class : " + stuff.name)
stuff.setSalary(1800000)
print("public member in 1st class : " + str(stuff.getSalary()))
print("public member in 2nd class : " + str(stuff.getExchangeRate("tw")))

# overloading the bulit-in function
print(stuff)

# overloading the parent function
print("overloading member on 2nd class : " + str(stuff.getExchangeRate("tw")))

del stuff
```



## Inheritance Test

```python
# whether the object is the instance of the class
isinstance(Object, Class)

# whether child class is inherited from parent class
issubclass(ChildClass, ParentClass)
```






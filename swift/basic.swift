/* Basic 

- The code written in the global scope is the entry point for the program.
- You don't need a main() function.
*/
print("Hello, world, Swift!")


/* Sample Values

- Use `let` to make a constant and `var` to make a variable.
*/
let myConstant = 2
var myVariable = 5

/*
- A constant or variable must have the same data type of the value 
  you want to assign to it.
- You don't need to explicit the data type when you assign the value 
  to a constant or variable, let the compiler infers its data type.
- If the compiler infers the wrong data type of a constant or a variable, 
  you can explicitly request the data type using a colon.
*/
let implicitInteger = 13
let implicitDouble = 17.0
let explicitDouble: Double = 19

/*
- The implicit data type conversion of a variable or constant is not supported.
- You have to assign the explicit data type conversion.
*/
let label = "The cost is "
let cost = 101
let response = label + String(cost)

/*
- For convenience, you can add parentheses with a backslash in front of it to 
  include a value in a string.
*/
let height = 1.7
let weights = 60.0
let BMIValue = "BMI: \(weights / (height * height))"
print(BMIValue)

/*
- Use three double quotations (`"""`) for multiple lines. For the sake of confusion, 
  write the string after the new line of the start of quotations and 
  end the string before the previous line of the end of quotations.
*/
let name = """
Hi, your BMI value is \(weights / (height * height))
"""
print(name)

/* Arrays and Dictionaries

- Create both arrays and dictionaries using brackets (`[ ]`).
- Access the element in the array using the number as the index.
- Access the pair (`key : value`) in the dictionary using the key as the index.
- Add an element to an array using `append`. 
  Notice the data appended must have the same data type as the array.
- You can simply use the bracket with the value assigned to add a new pair. 
  The same data type is also required when adding a new pair to the dictionary.
*/
var shoppingList = ["apples", "lemons", "bananas"]
shoppingList[1] = "oranges"
shoppingList.append("water")
print(shoppingList)

var grades = [
  "apple": 10.0,
  "banana": 9.8,
]
grades["apple"] = 9.9
grades["blueberry"] = 8.8
print(grades)

/*
- If you want to create an empty array or dictionary, 
  you can create it with the data type using a bracket.
- You can reset the array and dictionary using the empty bracket.
*/
var emptyArray = [String]()
var emptyDictionary = [String: Float]()
emptyArray.append("instance")
print(emptyArray)

emptyArray = []
emptyDictionary = [:]
emptyDictionary["number"] = 100
print(emptyDictionary)
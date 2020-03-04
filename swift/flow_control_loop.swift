/* Flow Control

- Use `if` and `switch` to make conditions and 
  use `for-in`, `while`, and `repeat-while` to make loops.
- Parentheses around the conditions and loop variables are optional.
- Braces around the code body were required.
- The `if` condition must be an explicit expression so that 
  the expression `if number { ... }` is not allowed that 
  the `number` cannot be implicit to a zero comparison.
*/
let scores = [77, 79, 83, 89, 91];
var teamGrades = 0
for score in scores {
   if score >= 90 {
      teamGrades += 3
   } else if score >= 80 && score < 90 {
      teamGrades += 2
   } else {
      teamGrades += 1
   }
}
print("Team Grades: \(teamGrades)")

// the case of using while
let messages = ["this", "is", "a", "message", "."]
var sentence = ""
var index = 0

while index < messages.count {
   switch index {
      case 0:
         sentence += String(messages[index].prefix(1)).uppercased()
         sentence += String(messages[index].dropFirst())
      case messages.count - 1:
         sentence += messages[index]
      default:
         sentence += " " + messages[index]
   }
   index += 1
}
print("Sentence: \(sentence)")

/*
- Write a question mark (`?`) after the type of declaring to make the value as optional.
- You can also use double question marks (`??`) to handle an optional value and 
  provide a default handler after the marks as well.
*/
var optionalName: String? = nil   // change nil to another string
var greeting = "Hello!"
if let name = optionalName {
   greeting = "Hello! \(name)"
} else if optionalName == nil {
   greeting = "Hello! Welcome."
}
print(greeting)

let defaultName = "Welcome"
let guestName: String? = nil  // change nil to another string
let usedName = "Hi! \(guestName ?? defaultName)"
print("Used Name: \(usedName)")

/*
- The `switch` supports multiple conditional comparisons, 
  multiple item comparisons, and advanced test checks.
- The switch syntax requires a default case, 
  if no code body is required it needs `break`.
- The `switch` doesn't need an explicit `break` statement 
  at the end of the code inside each `case` body.
*/
let vegetable = "red pepper"
switch vegetable {
   case "celery":
      print("Add some raisins.")
   case "cucumber", "watercress":
      print("Make a good sandwich.")
   case let x where x.hasSuffix("pepper"):
      /* notice the comparison in the case statement 
         must be a constant, you must use `let` instead of `var`*/
      print("Make \(x) for spicy.")
   default:
      print("Everything is good as the food source.")
}

/*
- You can use `for-in` to iterate a dictionary and 
  get a pair of `(key -> value)` returned.
- You can access the value using a key, but the key order 
  in the dictionary is arbitrary due to the hashing.
*/
let numbers = [
   "prime": [2, 3, 5, 7, 11, 13],
   "fibonacci": [1, 2, 3, 5, 8, 13],
   "square": [1, 4, 9, 16, 25, 36]
]

var averageNumber = [String:Double]()
for (key, value) in numbers {
   var tmpTotal = 0
   var averageNum = 0.0
   for num in value {
      tmpTotal += num
   }
   averageNum = (Double(tmpTotal) / Double(value.count))
   averageNumber[key] = averageNum
   print("Key \(key): Average \(averageNum)")
}

/*
- The `while` loop continues executing the code block 
  until the condition reaches.
- The while syntax can be replaced at the end of a loop block 
  to ensure the code is executed at least once.
*/
var attendence = 0
let attendCount = [1, 2, 1, 3, 5, 4, 1, 2, 3, 1]
var countIndex = 0

while attendence < 10 {
   attendence += attendCount[countIndex]
   countIndex += 1
}
print("Sets: \(countIndex), Attendence: \(attendence)")

attendence = 0
countIndex = 0
repeat {
   attendence += attendCount[countIndex]
   countIndex += 1
} while attendence < 10
print("Sets: \(countIndex), Attendence: \(attendence)")

/*
- You can use `...` with a `for` loop to include both start and end numbers. 
- Besides, you can use `..<` to notify not to include the end value.
*/
var sumNumber = 0
for num in 1 ..< 10 {
   sumNumber += num
}
print("The total sum from 1 to 9 (1 ..< 10) is \(sumNumber).")

sumNumber = 0
for num in 1 ... 10 {
   sumNumber += num
}
print("The total sum from 1 to 10 (1 ... 10) is \(sumNumber).")
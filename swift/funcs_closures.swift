/* functions
- Use `func` to declare the function following by the function name and parameters in parenthesis, 
  and add a pair of `-> (returned data type)` at the end.
- The pair of the returned data type is required, or the swift compiler regards the function 
  as a void function which is not allowed returning data.
*/
func greeting(name: String, day: String) -> String {
  return "Hi, \(name)! Today is \(day)."
}
print(greeting(name: "Kevin", day: "Wednesday"))

/*
- By default, a function call with parameters that require the parameter names as labels.
- For convenience, you can write a custom argument label before the argument name or 
  an underline `_` to use no argument label.
*/
func greeting(_ name: String, on day: String) -> String {
  return("Hi, \(name), Today is \(day).")
}
print(greeting("John", on: "Monday"))

/*
- Functions can have multiple returns. You can access the return using the label name or the return index.
*/
func calStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
  var min = 0
  var max = 0
  var sum = 0

  for score in scores {
    if score > max {
      max = score
    } else if score < min {
      min = score
    }

    sum += score
  }

  return (min, max, sum)
}
var stat = calStatistics(scores: [2, 5, 3, 6, 1])
print(stat.sum, stat.2)

/*
- Functions can be nested. The nested function can access the variables declared in the outer function.
*/
func calBMI(name: String, height: Float, weight: Float) -> String {

  func BMI() -> Float {
    return (weight / (height * height))
  }

  return "Hi, \(name), your BMI is \(BMI())."
}
print(calBMI(name: "Mary", height: 1.65, weight: 60))

/*
- A nested function is also available for a wrapper function, 
  the difference between the one returning an object is that 
  the return pair is the same with the nested function.
*/
func Celsius2Fahrenheit() -> ((Float) -> Float) {
  func body(C: Float) -> Float {
    return C * (9.0 / 5.0) + 32.0
  }

  return body
}

var degreeWrapper = Celsius2Fahrenheit()
print("36 oC is \(degreeWrapper(36.0)) oF.")

/*
- A function can allow a functional argument, that is passing a function as the argument of a function. 
*/
func judgeYield(ratio: Double) -> Bool {
  if ratio < 0.99 {
    return false
  }
  return true
}

func CountYield(list: [Double], condition: (Double) -> Bool) -> Double {
  var passed: Int = 0
  for l in list {
    if condition(l) {
      passed += 1
    }
  }
  return (Double(passed) / Double(list.count))
}

let yield_list = [0.98, 0.96, 0.991, 0.992, 0.995, 0.999, 0.991]
print("Yield is \(CountYield(list: yield_list, condition: judgeYield)).")


/*
- Functions are a special case of closures - blocks of code in the memory can be called later.
- You can define a closure that is no function name and is surrounding with braces (`{}`), and 
  use an `in` to separate the parameters with the code body.
- Such a closure is similar to a lambda function.
- You can even write a closure more concisely. When a closure data type is already known, 
  for example, a callback function, you can omit the data type of the parameters and the returns as well.
- You can refer to parameters by numbers instead of names. 
  When a closure is the only argument to a function, the parentheses can be omitted entirely.
*/
let yields = yield_list.map({ (value: Double) -> Bool in 
  return judgeYield(ratio: value)
})
print(yields)

let yield_percentage = yield_list.map({val in "\(val * 100)%"})
print(yield_percentage)

let sortedYields = yield_list.sorted { $0 > $1 }
print(sortedYields)
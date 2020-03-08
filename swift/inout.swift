/* InOut Parameters

1. The `inout` is a notified mark to allow the function to change the argument value itself.
2. You have to add `&`, a mark for passing reference, to the front of the arguments.
3. The function can change the value inside the code block.
*/

public func Swap<T>(_ num1: inout T, _ num2: inout T)
{
  let temp = num1
  num1 = num2
  num2 = temp
}

var intVal1: Int = 10
var intVal2: Int = -9
Swap(&intVal1, &intVal2)
print("val1: \(intVal1), val2: \(intVal2)")  // val1: -9, val2: 10

var doubleVal1: Double = 0.9
var doubleVal2: Double = 9.0
Swap(&doubleVal1, &doubleVal2)
print("val1: \(doubleVal1), val2: \(doubleVal2)")  // val1: 9.0, val2: 0.9
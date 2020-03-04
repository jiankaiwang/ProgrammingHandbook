/* Protocols
- Using `protocol` to define the protocol. You can define the variable using `var` and 
  define the function using `func`. Notice the function defined in the protocol 
  requires a `mutating` mark to allow changes in the future inheritance.
- The class, enumeration, and the structure all can adopt the protocol.
*/
protocol ExampleProtocol {
  var simpleDescription: String { get }
  mutating func adjust()
}

class SimpleClass: ExampleProtocol {
  var simpleDescription: String = "A class adopts the protocol."
  var secondProperty: Int = 12345
  func adjust() {
    simpleDescription = "adjust completely"
    secondProperty = 23456
  }
}

var sc = SimpleClass()
print("before: \(sc.simpleDescription), \(sc.secondProperty)")
sc.adjust()
print("after: \(sc.simpleDescription), \(sc.secondProperty)")

/*
- Notice the mutating function in the structure, the mutating mark is required, 
  unlike the one in the class. The mark notifies the modification of the structure. 
  Such the mark is not required for the class because the function of the class 
  is always allowed for changing the class.
*/
struct SimpleStructure: ExampleProtocol {
  var simpleDescription: String = "A structure adopts the protocol."
  var secondProperty: Int = 54321
  mutating func adjust() {  // mutating is required
    simpleDescription = "finished adjusting"
    secondProperty = 98765
  }
}

var ss = SimpleStructure()
print("before: \(ss.simpleDescription), \(ss.secondProperty)")
ss.adjust()
print("after: \(ss.simpleDescription), \(ss.secondProperty)")

/* Extensions
- Use `extensions` to add functionality in a protocol to an existing type, 
  such as new methods and computed properties. 
  The type can be the built-in data type or customized class or structure.
*/
extension Int: ExampleProtocol {
  var simpleDescription: String {
    return "The number is \(self)"
  }
  mutating func adjust() {
    self += 1
  }
  func ToDouble() -> Double {
    return Double(self)
  }
}

var num = 7
print("before: \(num.simpleDescription)")
num.adjust()
print("after: \(num.simpleDescription)")
print("To Double: \(num.ToDouble())")

/*
- You can extend the functionalities to an existing class definition.
*/
class ExtClass {
  var property: Int

  init() {
    self.property = 10
  }

  func showVal() -> String {
    return "\(property)"
  }
}

var ec = ExtClass()
print("Value is \(ec.showVal())")
// print("Desc: \(ec.simpleDescription)")  // went error

extension ExtClass: ExampleProtocol {
  var simpleDescription: String {
    return "The value of the object is \(property)."
  }
  func adjust() {  // mutating is not reuqired
    property += 10
  }
}

var ecp = ExtClass()
print("Desc (before): \(ecp.simpleDescription)")
ecp.adjust()
print("Desc (after): \(ecp.simpleDescription)")

/*
- You can use a protocol name just like other named types, like Int, Double, customized Classname, etc.
- When you work with values whose type is a protocol type, 
  methods outside the protocol definitions are not available.
*/
let testproperty: ExampleProtocol = ecp
print("Can get the desc: \(testproperty.simpleDescription)")
//print("Can't get the property defined in the class: \(testproperty.property)")  // went error
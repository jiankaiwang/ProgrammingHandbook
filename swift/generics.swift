/* Generics

- Write a name in an angle brackets to make a generics function or type.
*/
func makeArray<Item>(repeating item: Item, amountOfNumber: Int) -> [Item] {
  var list = [Item]()
  for _ in 0 ..< amountOfNumber {
    list.append(item)
  }
  return list
}

let repeatArray = makeArray(repeating: "hi", amountOfNumber: 10)
print("Repeating: \(repeatArray)")

/*
- You can make the generics forms of functions, and classes, enumerations as well.
*/
enum OptionalValue<Warpped> {
  case none
  case some(Warpped)
}

var possibleInteger: OptionalValue<Int> = OptionalValue.none
print("\(possibleInteger)")
possibleInteger = OptionalValue.some(101)
print("\(possibleInteger)")

/*
- Use `where` right before the body to list the requirements.
  For example. to require a generics type implementing the protocol,
  to require two types to be the same (`==`).
*/
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
  where T.Element: Equatable, T.Element == U.Element {
  for lhsItem in lhs {
    for rhsItem in rhs {
      if lhsItem == rhsItem {
        return true
      }
    }
  }
  return false
}
print(anyCommonElements([1, 2, 3], [2]))
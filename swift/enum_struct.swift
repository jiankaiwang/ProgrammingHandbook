/* Enumerations

- Create an enum object using `enum` followed by a name with its type (required). 
- List all cases orderly, using `case`. Each case is to add 1 up to the previous case.
- By default, the first case begins with 0, however, you can specify an integer number as the beginning number.
*/
enum Rank: Int {
  case ace = 10
  case two, three, four, five, six, seven, eight, nine, ten
  case jack, queen, king
}

let three = Rank.three
let rawValue = three.rawValue

// three: three, its raw value: 12
print("three: \(three), its raw value: \(rawValue)")

/*
- The `enum` object can be different data types, like Double or String. 
  You have to specify each case with values if it is not an integer.
- You can access the case using a `dot` and access the raw value using an explicit and built-in attribute `rawValue`.
*/
enum DoubleRank: Double {
  case num1 = 10.1
  case num2 = 11.2, num3 = 12.3, num4 = 13.4
  case num5 = 14.5
}

let doubleVal = DoubleRank.num4
let doubleRawVal = doubleVal.rawValue

print("As float: \(doubleVal), its raw value: \(doubleRawVal)")

/*
- The enumeration is also allowed for associating with functions.
- You can also assign the raw value to initialize an enum as the optional value.
  Just like the way of calling a function with passed arguments.
*/
enum Cards: Int {
  case ace = 10
  case two, three, four, five, six, seven, eight, nine, ten
  case jack, queen, king

  func SimpleDescription() -> String {
    // self is an explicit way calling itself value
    switch self {
    case .ace:
      return "ace"
    case .jack:
      return "jack"
    case .queen:
      return "queen"
    case .king:
      return "king"
    default:
      return String(self.rawValue)
    }
  }
}

var cardDesc = ""
if let cardRank = Cards(rawValue: 22) {  // optional value
  cardDesc = cardRank.SimpleDescription()
}
print("Card Desc: \(cardDesc)")

enum Suit: String {
  case spades = "1", hearts = "2", diamonds = "3", clubs = "4"

  func SimpleDescription() -> String {
    switch self {
    case .spades:
      return "spades"
    case .hearts:
      return "hearts"
    case .diamonds:
      return "diamonds"
    case .clubs:
      return "clubs"
    }
  }
  
  func Color() -> String {
    switch self {
    case .spades, .clubs:
      return "black"
    case .hearts, .diamonds:
      return "red"
    }
  }
}

print(Suit.hearts.SimpleDescription())
print(Suit.hearts.Color())

if let cardSuit = Suit(rawValue: "3") {
  print(cardSuit.SimpleDescription())
}

/*
- You can store the values associated with the case, that can be determined when you make the instance.
*/
enum ServerResponse {
  case result(String, String)
  case failure(String)
}

let success = ServerResponse.result("6:00 am", "5:00 pm")
let failure = ServerResponse.failure("Oops!")

switch success {
case let .result(sunrise, sunset):
  print("Sunrise is \(sunrise) and sunset is \(sunset).")
case let .failure(message):
  print("Error message: \(message)")
}

/* Structures

- The `Structure` is similar to the `Class`, it has attributes, methods, and initializers as well. 
- The main difference between them is that structures are always copied and passed by values, 
   but classes are passed by reference.
*/
struct GetCard {
  var rank: Cards
  var suit: Suit

  func SimpleDescription() -> String {
    return "\(suit.SimpleDescription()) \(rank.SimpleDescription())"
  }
}

let getcards = GetCard(rank: .king, suit: .spades)
print(getcards.SimpleDescription())
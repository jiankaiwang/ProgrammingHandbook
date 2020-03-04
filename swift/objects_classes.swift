/* Classes

- Use `class` syntax followed by the class name to create a class. The property (or variable) 
  and the member function are created in the usual way, the difference is that they have to 
  be defined inside the context of the class.
- Instantiating the class into an object is easy to add the parenthesis after the class name.
- No matter what to access, the property or the function, use a `dot` after the instantiated object.
*/
class Area {
  var radius: Float = 0.0
  let pi: Float = 3.141596

  func calArea() -> Float {
    return self.radius * self.radius * self.pi
  }

  func getPI() -> Float {
    return self.pi
  }

  func setRadius(_ val: Float) {
    radius = val;
  }
}

var area = Area()
area.setRadius(10)
print("PI is \(area.pi) and the area is \(area.calArea())")

/*
- The class can be initialized using a special function `init` 
  (you can't add the `func` in front of init), but it is optional.
- All the properties of the class require the initialization 
  either in the `init` function or in the declaration.
- Clean up the necessary properties manually using the `deinit` 
  to create a de-initializer when the instance was de-allocated.
- You don't need to write `self` all the time, 
  you write it for differentiating the arguments from the properties, 
  and the global functions from the member ones.
  In most cases, you can ignore writing it.
*/
class Person {
  var age: Int
  var name: String = ""   // goes wrong if no initialization

  init(age: Int) {
    self.age = age
  }

  func greeting() -> String {
    if self.age <= 22 {
      return "Hello, how is the school?"
    } else if self.age > 22 && self.age < 65 {
      return "Hello, how is the work?"
    } else {
      return "Hello, how is the day?"
    }
  }

  deinit {
    // no parenthesis
    // no return data type
    // you can't print anything
    print("Deallocation.")
  }
}

var person = Person(age: 30)
print(person.greeting())

/*
- A class can inherit another one using a `colon`.
- Inside the initialization of the children class, its properties must be initialized first, \
  and then initialized the parent class using the `super.init`. 
  Using the properties of the parent class must be after the initialization, 
  that is to say, after the `super.init`.
- If you want to override the parent's memeber function, the notification mark `override` 
  msut be added before the function declaration.
- 
*/
class FullInfoPerson: Person {
  var occupation: String
  var address: String
  var phone: String
  
  init(phone: String, age: Int, name: String) {
    self.phone = phone
    self.occupation = ""
    self.address = ""

    super.init(age: age)    
    self.name = name    
  }

  func setOccupation(_ occ: String) {
    self.occupation = occ
  }

  func setAddress(_ add: String) {
    self.address = add
  }

  override func greeting() -> String {
    return "Hello, \(self.name)! Your phone is \(self.phone), is that correct?"
  }
}

var fperson = FullInfoPerson(phone: "0123456789", age: 30, name: "Kevin")
print(fperson.greeting())


/*
- There are more simpiler way to get and set the variable, 
  that are the `getter` using `get` and the `setter` using `set`. 
- The setter and getter are the special operations on the variable. 
  However the variable is more like a access point for the complex operations.
*/
class NewArea: Area {
  var rad: Float {
    get {
      // You can't change to `self.rad` for the sake of not repeatedly calling.
      return self.radius
    }
    set {
      /* `newValue` is the preserved and implicit name, 
         you can direct use it*/
      self.radius = Float(newValue)
    }
  }

  init(_ rad: Float) {
    super.init()  // you have to initalize the parent class for using its property
    self.rad = rad
  }
}
var narea = NewArea(3.0)

// getter
print(narea.rad)

// setter
narea.rad = 3.0
print(narea.rad)

/*
- You can also add a question mark `?` to represent the optional assign, 
  after that, you can also use it to optionally call the member function.
*/
var newperson: FullInfoPerson? = FullInfoPerson(phone: "0123456789", age: 20, name: "John")
if let greetingDesc = newperson?.greeting() {
  print(greetingDesc)
}

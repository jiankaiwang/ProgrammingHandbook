/* Error Handling

- You can handle the errors using the built-in `Error` protocol. 
*/
enum PrinterError: Error {
  case outOfPaper
  case noToner
  case onFire
}

/*
- If the function needs an error handling, it requires adding `throws` 
  at the end of the function declaration.
- Inside the code block, use `throw` to throw an error type.
*/

func send(job: Int, toPrinter printerName: String) throws -> String {
  if printerName == "No Toner" {
    throw PrinterError.noToner
  } else if printerName == "No Paper" {
    throw PrinterError.outOfPaper
  }
  return "Job sent"
}

/*
- The caller handles the errors threw, the simple way handling errors is using `do-catch` syntax.
- In the `do` block, use `try` to call the function with error handling. 
  In the `catch` block, handle the error type. The `error` in the catch block is a built-in variable. 
  You can assign it a different variable name if it is required. 
*/
do {
  let response = try send(job: 1024, toPrinter: "No Toner")
  print("Printer: \(response)")
} catch {
  print("Error: \(error)")
}
// prints "Error: noToner"

/*
- You can use multiple catches to catch multiple error handlings.
- You can assign the error as a customized variable using `as` instead of `=`.
*/
do {
  let multipleResponse = try send(job: 2048, toPrinter: "No Paper")
  print("Printer: \(multipleResponse)")
} catch PrinterError.onFire {
  print("Error (on Fire): I'll put this over there.")
} catch let prterr as PrinterError {  // use `as` instead of `=`
  print("Error: \(prterr)")
} catch {
  print("Unexpected Error: \(error)")
}

/* Optional Try
- You can simplify to add a question mark `?` after `try` to get the optional response. 
  If it is successful to run the function without an error, it returns the expected result, otherwise, it returns `nil`.
*/
let printerSuccess = try? send(job: 32, toPrinter: "Nice!")
print("Success with optional try: \(printerSuccess)")
let printerFailure = try? send(job: 64, toPrinter: "No Paper")
print("Failed with optional try: \(printerFailure)")  // printerFailure is `nil`

/* defer
- Use `defer` to write a code block to be executed after all executions but just before returns. 
  You can use `defer` to clean up the necessary information or reset the state, etc.
- The `defer` code block is executed regardless of whether the function throws the error.
*/
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "fish"]

func fridgeContain(_ food: String) -> Bool {
  fridgeIsOpen = true
  defer {
    fridgeIsOpen = false
  }

  return fridgeContent.contains(food)
}

let result = fridgeContain("eggs")
print("result: \(result), open? \(fridgeIsOpen)")

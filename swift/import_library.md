# Building and Importing Swift Libraries

Building and importing libraries to a Swift script is an advanced programming skill while developing a much bigger project. In the following, two main ways are provided to develop libraries, that are using Xcode in the MacOS system and using native commands for the overall Unix-like system.

## Build a Swift Library

Here a built-in tool, `swift package`, is introduced to generate and build a library.

```sh
# the `project` is the folder created for the main.swift and the library
# the `main` is the folder created for the entry of the script
# the `cal` is the folder created for the library
$ mkdir -p ./project/main
$ mkdir ./project/cal
```

Next, creating a library environment inside the `cal` folder using the built-in tool.

```sh
$ cd ./project/cal

# you can also use the command `swift package init --help` 
# to show more information about the type
# the type `library` is to create an environment for build libraries
$ swift package init --type library
```

Now the project path structure is like the below.

```text
+ project
  + main
  + cal
    + Sources                   # keeps all the scripts
      + cal
        - cal.swift             # the source code generated
    + Tests                     # keeps all the tests scripts
      - LinuxMain.swift
      + calTests
        - calTests.swift        # the script for testing
        - XCTestManifests.swift
    - .gitignore
    - Package.swift             # information for building the library
    - README.md
```

After you initialize the library environment, you can build and test it now.

```sh
# under the library path
$ cd ./project/cal

# build the library and test it
$ swift build && swift test
```

Let's edit the script and the tests of the library. Edit the `Sources/cal/cal.swift` for the library. Edit the `Tests/calTests/calTest.swift` for the corresponding tests.

```sh
# edit the main script
$ vim ./cal/Sources/cal/cal.swift
```

While editing the main script, the default content would be like,

```swift
struct cal {
    var text = "Hello, World!"
}
```

Let's edit it, remove the struct and add a function to do a simple calculation.

```swift
/*struct cal {
    var text = "Hello, World!"
}*/

// we add a function that sums two values and returns the result
// add a scope resolver `global` to make it public
public func addNum(_ v1: Int, _ v2: Int) -> Int {
  return v1 + v2
}
```

Remind to add the scope resolver to the front of attributes, methods, classes, and so on. Here we would like to use this function in other scripts so add a `public` to the function. For more information, please refer to the (Swift.org/AccessControl).[https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html].

Next, we edit the tests for checking the function.

```sh
$ vim ./cal/Tests/calTests/calTests.swift
```

Remove the default test case and add new test cases for the function.

```swift
import XCTest
@testable import cal

final class calTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(cal().text, "Hello, World!")

        // we add these new test cases
        XCTAssertEqual(addNum(2, 3), 5)
        XCTAssertEqual(addNum(-1, 1), 0)
        XCTAssertEqual(addNum(-99, -1), -100)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
```

These steps simulate the true programming process. After adding a new function with its test case as well, build and test it.

```sh
$ swift build && swift test
```

**Build and test the library is `not necessary` while importing it in a new script. However, these steps help you check the correctness of the library functionality.** Now building a library is done.

## Importing the Library and Building the Project

Next, we are going to import the library to a main or entry Swift script. First, initialize the project using a built-in tool `swift package`.

```sh
$ cd ./project/main

# initialize an executable-type package
$ swift package init --type executable
```

After initializing the executable package, the folder structure is like the below. The structure of the executable is similar to the one of the library.

```text
+ project
  + cal
  + main
    + Sources
      + main
        - main.swift            # the entry of the project
    + Tests
      - LinuxMain.swift
      + mainTests
        - mainTests.swift       # the tests of the entry
        - XCTestManifests.swift
    - Package.swift             # information for the building
    - README.md
```

You can build and test the main Swift script. 

```sh
$ cd ./project/main

# build the executable binary file
$ swift build && swift test
```

After building the executable main Swift script, you can find the executable binary file under `./project/main/.build/debug/main`. You can run it to print the "Hello, world!".

```sh
$ ./project/main/.build/debug/main
```

Next, we start to edit the script, import the custom `cal` library and use the function defined above.

```sh
$ vim ./project/main/Sources/main/main.swift
```

We comment on the generated script, import the `cal` library and use the public function.

```swift
// the way importing the custom library
import cal

// print("Hello, world!")

// the way calling the public function
print("The sum of number 2 and 3 is \(addNum(2, 3)).")
```

Before compiling or running the whole project, it is necessary to set up the dependencies on the `Package.swift`, the building definition.

```sh
$ vim ./project/main/Package.swift
```

Add custom `cal` library to the `dependencies` section and the `.target` section.

```swift
// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "main",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        
        // add the path of the custom `cal` library
        // for more information, please refer to 
        // https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html
        .package(path: "../cal")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "main",

            // add the custom library name
            dependencies: ["cal"]),  
        .testTarget(
            name: "mainTests",

            // if you test the custom library on the main script
            // you can add it to the list
            dependencies: ["main"]),
    ]
)
```

After adding the custom library to the `Package.swift`, you can `resolve` and `update` the package. If you use the library accessing from the git or the http server, the Swift would resolve and add it to the current project.

```sh
$ cd ./project/main
$ swift package resolve && swift package update
```

Edit the tests for the main script.

```sh
$ vim ./project/main/Tests/mainTests/mainTests.swift
```

```swift
import XCTest
import class Foundation.Bundle

final class mainTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        let fooBinary = productsDirectory.appendingPathComponent("main")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        // add this new test case
        // XCTAssertEqual(output, "Hello, world!\n")
        XCTAssertEqual(output, "The sum of number 2 and 3 is 5.\n")
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
```

Next you can build and test the whole project.

```sh
$ cd ./project/main
$ swift build && swift test
```

Run the executable binary file.

```sh
$ cd ./project/main

# execute the compiled file
$ ./.build/debug/main
```

Now the custom `cal` library is added to the `main` entry script.

## Importing the Library using Xcode [**Optional**]

The Xcode is an IDE mainly used in the MacOS system and easy for building complex tasks on Swift. However, Swift is an open-source programming language and available running on the Unix-like system. The section is only available for those developers using Xcode.

Before importing to the Xcode, you have to generate the library profile first.

```sh
$ cd ./project/cal

# generate the profile for the Xcode
$ swift package generate-xcodeproj
```

Follow the steps to import a customized library.

* Click the Xcode.
* On the homepage, click `Create a new Xcode project`.
* Click the `macOS` subpage, and click the `Command Line Tool` option.
* On the option `Language`, drop down and select the `Swift`.
* Setup the path, project name, and so on. Click `Next` to initialize the project.
* After initializing the project, on the left panel click the project name to open the project homepage.
* Click the `+` button under the section `Linked Frameworks and Libraries`.
* Add the Xcode profile file of the customized library.

Back to the main Swift script, you can use `import cal` to import the library. The rest of the programming is similar to the usual way.
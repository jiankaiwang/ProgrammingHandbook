# Reference



## Basis



The following is the basic syntax.

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("Hello world, GoLang!")
	fmt.Println("The time is", time.Now(), "now.")
}
```



### Packages, Variables and Functions

```go
package main

import (
	"fmt"
	"math"
	"math/cmplx"
	"math/rand"
	"strconv"
)

// ================ example.1 ================

// declear a function
// two arguments, x is int (write after the variable), and y is also an interger
// the return value type, int, is declear after the parentheses
func add(x int, y int) int {
	return x + y
}

// ================ example.2 ================

// declear a function which has multiple returns
// x, y are the same type, you can omit the first type declearation
func swap(x, y string) (string, string) {
	return y, x
}

// ================ example.3 ================

// the way to write naked returns
// notice x already exists, not to write `x := ... `
func nakedReturn(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

// ================ example.4 ================

// declear a variable in package scope
// variable in package scope can not be used
// but not allowed in function scope
// bool is false by default
var varInPackage bool

/* shortened variable declearation is only allowed in function scope
var2InPackage := 3
*/

// ================ example.5 ================

// decleared multiple variables
var (
	test   bool       = false
	bigInt uint64     = 1<<64 - 1
	zval   complex128 = cmplx.Sqrt(-5 + 12i)
)

// ================ example.6 ================

// decleared variables without initializations
// they would be at zero
var (
	bini bool      // false
	nini rune      // 0
	zini complex64 // 0 + 0i
	sini string    // ""
	fini float32   // 0.0
)

// ================ example.7 ================

func typeConvertion() {
	// requires a explict convertion
	var i int = int(3.0)
	var f float32 = float32(i)
	var u uint = uint(f)
	fmt.Printf("int %v, float %f, uint %v\n", i, f, u)

	// more simple way
	i2 := int(4.0)
	f2 := float32(i2)
	u2 := uint(f2)
	fmt.Printf("int %v, float %f, uint %v\n", i2, f2, u2)
}

// ================ example.8 ================

func typeInference() {
	// from a known type
	var v1 int
	v2 := v1

	// from a constant, using default data types
	v3 := -5 + 12i // complex128
	v4 := 10       // int
	v5 := 3.2      // float64

	fmt.Printf("%T, %T, %T, %T\n", v2, v3, v4, v5)
}

func main() {
	rand.Seed(0)
	fmt.Println("The random number is ", rand.Intn(10))
	fmt.Println("The sqrt of number 9 is", math.Sqrt(9))
	fmt.Println("The pi constant value is", math.Pi)

	// function call
	fmt.Println("Sum of two values are", add(30, 70))

	// a quick way to declear the variable
	a := "ready to receive a function returned value, but this step is not necessary"

	// a quick way to declear and receive the function returns
	a, b := swap("hello world", "golang")
	fmt.Println("Swap result", a, b)

	// full statement to declear variables with initializers
	var var1, var2 int = 3, 4
	fmt.Println(var1, var2)

	// quick statement to declear variables with initializers
	var var3, var4 = 4, 5
	fmt.Println(var3, var4)

	// a more shorten way to declear variables with initializers
	var5 := "shortened variable declearation"
	fmt.Println(var5)

	// show variables
	fmt.Println("Bool value", test)
	fmt.Println("Uint64 value", bigInt)
	fmt.Println("Complex value", zval)

	// show initialized values
	fmt.Printf("%v %v %v %q %v\n", bini, nini, zini, sini, fini)

	// type convertion
	typeConvertion()

	// type inference
	typeInference()

	// const value assignment without :
	const cval = 1
	fmt.Println("Const value", cval)

	// string convertion
	v1, _ := strconv.Atoi("14321")  // two returns
	v2 := strconv.Itoa(928354)      // one return
	fmt.Printf("%T:%v, %T:%v", v1, v1, v2, v2)
}

```



### Flow Control Statement

*   Loop: `for`
*   Branch: `if`, `switch`
*   Delay: `defer`

```go
import (
	"fmt"
	"math"
	"math/rand"
	"runtime"
	"time"
)

// ================ example.1 ================

func forLoopSum(stop int) int {
	// for loop
	sum := 0
	for i := 0; i <= stop; i++ {
		sum += i
	}
	return sum
}

// ================ example.2 ================

func whileLoopByFor(stop int) int {
	// the initialization or post action can be ignored
	sum := 1

	// this is the same thing with `while`
	for sum < stop {
		sum += sum
	}
	return sum
}

// ================ example.3 ================

func foreverLoop() int {
	// omit the loop condition to become a non-stop loop
	sum := 0

	for {
		timeSeed := time.Now().UnixNano() / int64(time.Second)
		rand.Seed(timeSeed)
		randNum := rand.Intn(10)
		if randNum < 4 {
			break
		}
		sum += randNum
	}

	return sum
}

func sqrt(num float64) string {
	// if else branch
	if num < 0 {
		return sqrt(-1*num) + "i"
	}
	return fmt.Sprint(math.Sqrt(num))
}

// ================ example.4 ================

func limitedPow(x, n, lim float64) float64 {
	// advanced if branch
	// it is similar to `for` loop
	// you can assign a variable first and it only visible to the if scope
	// if scope includes its else (if) scope
	if v := math.Pow(x, n); v < lim {
		return v
	} else if v == lim {
		return v - 1
	}
	return lim
}

// ================ example.5 ================

func newtonSqrt(x float64) float64 {
	// implement a newton's method to approach that the square of z is x
	if x < 0 {
		return newtonSqrt(-x)
	}

	z := 1.0
	guess := 0.0

	for {
		guess = (z*z - x) / (2 * z)
		if math.Abs(guess) < 1e-8 {
			break
		}
		z -= guess
	}

	return z
}

// ================ example.6 ================

func switchExample() {
	// switch syntax
	// no break in the end of case block
	// only execute the case block meeting the requirement
	// the case requirement need not to be constant
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("Mac OS")
	case "linux":
		fmt.Println("Linux")
	default:
		fmt.Printf("%s\n", os)
	}
}

// ================ example.7 ================

func swicthEvaluator() {
	fmt.Println("When is Saturday?")
	today := time.Now().Weekday()
	fmt.Printf("Today is %v.\n", today)

	// switch case could be a variable
	// no need to be a constant
	switch time.Saturday {
	case today:
		fmt.Println("Today is Saturday.")
	case today + 1:
		fmt.Println("Tomorrow is Saturday.")
	case today + 2:
		fmt.Println("In two days.")
	default:
		fmt.Println("More than two days.")
	}
}

// ================ example.8 ================

func switchForIfBranch() {
	t := time.Now().Hour()
	// switch with no condition is like if-else branch
	switch {
	case t < 12:
		fmt.Println("Good morning.")
	case t < 18:
		fmt.Println("Good afternoon.")
	default:
		fmt.Println("Good evening.")
	}
}

// ================ example.9 ================

func simpleDefer() {
	// defer statement would be executed
	// right after the sourrending block returns
	defer fmt.Println("First statement.")
	fmt.Println("Second statement.")
}

// ================ example.10 ================

func stackingDefer() {
	// deferred function calls are pushed onto the stack
	// when a function returns, the stack would pop the deferred calls
	// executed in a last-in-first-out order
	for i := 0; i < 10; i++ {
        // print 9, 8, 7, ... , 2, 1
		defer fmt.Println(i)
	}
	fmt.Println("final statement in the end of func")
}
```



### Pointer

```go
func basicPointer() {
	// unlike C, GO has no pointer arithmetic

	var n *int     // n is the pointer (save memory address)
	fmt.Println(n) // n = nil when no initialized value

	i := 10
	p := &i            // get the memory address of `i`
	fmt.Println(p, *p) // use * to get the value where pointer point to
	fmt.Println(&p)    // pointer has its own memory address

	n = p              // now we assign n is the same address with p
	fmt.Println(n, *n) // the same value would be pointed to

	var n2 *int = &i // the second way to assign pointers
	fmt.Println(n2)
}
```



### Struct

```go
// Point consists of two components, X and Y.
// use `type` as the declearation and struct is the collection of fields
type point struct {
	X int
	Y int
}

type newi int

// ================ example.1 ================

func basicStruct() {
	// use `{}` as the initializer
	s := point{1, 2}
	fmt.Printf("Point (%v, %v)\n", s.X, s.Y)
}

// ================ example.2 ================

func accessStruct() {
	// use dot to access the member of a struct
	s := point{1, 2}
	s.X = 4
	fmt.Println(s)
}

// ================ example.3 ================

func pointer2Struct() {
	var s point = point{3, 10} // declear a struct
	p := &s                    // get the memory address of s

	// in golang, pointer to the struct can omit the explict derefernce `*`
	p.X = 20 // more correct way is (*p).X, the `*` is allow to ignored
	fmt.Println(s)
}

// ================ example.4 ================

func structLiterals() {
	var (
		v1 = point{1, 2}   // normal way
		v2 = point{X: 3}   // Y default is 0
		v3 = point{}       // default is {0,0}
		v4 = &point{8, 10} // get the address of struct{8, 10}
	)

	fmt.Println(v1, v2, v3, v4)
}
```



### Array and Slice

```go
import (
	"fmt"
	"strings"
)

// ================ example.1 ================

// array is a fixed length container
func arrayExample() {
	// method.1 declears array
	var a1 = [2]int{1, 2}

	// method.2 declears array (array literals)
	a2 := [10]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

	// method.3 declears array
	var s1 [2]string
	s1[0] = "hello"
	s1[1] = "world"

	// method.4 (not recommended)
	var a3 [2]int = [2]int{1, 2}

	fmt.Println(a1, a2, s1, s1[1]+s1[0], a3)
}

func __sliceInfo(obj []int) {
	fmt.Printf("len %v, cap %v, element %v\n", len(obj), cap(obj), obj)
}

// ================ example.2 ================

// slice has dynamic length
func sliceExample() {
	// method.1 created referred on an array
	prime := [6]int{10, 20, 30, 40, 50, 60}
	// slice is composed of [s:e] with s standing for start and e for end (not included)
	var s []int = prime[1:4]

	// slice is more like a reference to array
	// change the value inside the slice would also change the element in underlying array
	base := [4]string{"hello", "world", "golang", "!"}
	var s1 []string = base[1:4]
	var s2 []string = base[0:len(base)]
	s1[1] = "GoLang"

	// method.2 created a slice literals (without declearing length)
	s3 := []int{2, 3, 5, 7, 9, 11}
	s4 := []struct {
		n int
		b bool
	}{
		{2, true},
		{3, false},
		{5, true},
		{7, true},
		{9, false},
		{11, true},
	}

	// when using slices, the start and end can be ignored
	// to use the default indexes (0 for head, final index for tail)
	s5 := prime[:]

	fmt.Println(s, base, s2, s3, s4, s5)

	// use len() and cap()
	// len(): get the slice length, cap(): the length of the underlying object
	s6 := []int{10, 20, 30, 40, 50, 60}
	s6 = s6[:0]
	__sliceInfo(s6)

	s6 = s6[:4]
	__sliceInfo(s6)

	// change the capacity of the underlying array
	// change the start, change the capacity
	s6 = s6[2:]
	__sliceInfo(s6)
}

// ================ example.3 ================

func nilSlice() {
	// nil slice: len is 0 and no underlying array
	var s []int
	__sliceInfo(s)
	if s == nil {
		fmt.Println("Nil slice")
	}

	// assign the underlying array
	var a = [2]int{3, 2}
	s = a[:]
	__sliceInfo(s)
}

// ================ example.4 ================

func dynamicArray() {
	// use make to create a dynamic size array
	d := make([]int, 5) // len 5, cap 5
	__sliceInfo(d)

	d2 := make([]int, 0, 5) // len 0, cap 5
	__sliceInfo(d2)

	// make and fulfill
	a := []int{10, 20, 30}
	b := make([]int, len(a)+1)
	for i := 0; i < len(a); i++ {
		b[i] = a[i]
		b[len(b)-1] += a[i]
	}
	__sliceInfo(a)
	__sliceInfo(b)
}

// ================ example.5 ================

func sliceOfSlice() {
	board := [][]string{
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
	}

	board[0][0] = "O"
	board[1][0] = "X"
	board[1][1] = "O"
	board[2][0] = "x"
	board[2][2] = "O"

	fmt.Println(board)
	for i := 0; i < len(board); i++ {
		fmt.Println(strings.Join(board[i], " "))
	}
}

// ================ example.6 ================

func appendSlice() {
	// append the element whose tyep must be the same with the slice
	a := [3]int{3, 4, 5}
	s := a[1:]
	s = append(s, 6)

	fmt.Println(a, s)
}
```



### range

```go
func rangeExample() {
	// range for array
	// range would return both index and value
	// index starts from 0 and value is the copy of the index element
	a := []int{11, 22, 33, 44, 55}

	for idx, val := range a {
		val += 20
		fmt.Println(idx, val)
	}
	fmt.Println(a)

	// range for slice
	// range copys the value of a slice object
	// so that changing the slice value can't change the underlying array
	b := a[0:4]
	for idx, val := range b {
		val += 20
		fmt.Println(idx, val)
	}
	fmt.Println(a, b)
}
```



### Map

```go
// Loc is a struct saving both lat, lon coordinates.
type Loc struct {
	Lat, lon float64
}

// ================ example.1 ================

func mapExample() {
	var m map[string]Loc
	// use `make()` to initialize the map object
	m = make(map[string]Loc)
	// add a pair of key and value into the map container
	m["Bell Labs"] = Loc{40.68433, -74.39967}
	fmt.Printf("The coordinate of Bell Labs: %v\n", m["Bell Labs"])
}

// ================ example.2 ================

func mapExample2() {
	// method.1: map literals
	m := map[string]Loc{
		"Bell Labs": Loc{
			40.68433, -74.39967,
		},
		"Google": Loc{
			37.42202, -122.08408,
		},
	}

	// method.2: map literals in abbreviation
	var m2 = map[string]Loc{
		"Bell Labs": {40.68433, -74.39967},
		"Google":    {37.42202, -122.08408},
	}

	fmt.Println(m)
	fmt.Println(m2)
}

// ================ example.3 ================

func operateMap() {
	m := map[string]int{
		"answer": 60,
	}

	// update
	m["answer"] = 80
	fmt.Println(m)

	// insert
	m["standard"] = 60
	fmt.Println(m)

	// delete
	delete(m, "standard")
	fmt.Println(m)

	// test key in map or not
	elem, exist := m["date"]
	fmt.Printf("Exist or not: %v, the value: %v\n", exist, elem)

	// the length of map
	fmt.Println(len(m))

	// iterate all pairs
	// you can use range to iterate all pairs in map
	// no index provided, instead the key would be returned
	for key, val := range m {
		fmt.Printf("key %v, value %v\n", key, val)
	}
}

func add2map(m map[string]int, word string) map[string]int {
	_, exist := m[word]
	if exist {
		m[word]++
	} else {
		m[word] = 1
	}
	return m
}

// ================ example.4 ================

// WordCount implements the counting of words.
func WordCount(s string) map[string]int {
	m := make(map[string]int)
	words := strings.Split(s, " ")
	for _, word := range words {
		_, exist := m[word]
		if exist {
			m[word]++
		} else {
			m[word] = 1
		}
	}
	return m
}
```



### Function Values

```go
func functionValues() {
	// functions are values too
	// functions can be passed around just like other values
	// functions can be function arguments
	hypot := func(x, y float64) float64 {
		return math.Sqrt(x*x + y*y)
	}
	fmt.Println(hypot(5, 12))      // as the usual way
	fmt.Println(compute(hypot))    // function can be passed as the argument
	fmt.Println(compute(math.Pow)) // pass another function
}
```



### Function Closures

```go
// ================ example.1 ================

// function closures
// addr would return a func which recognize sum as the variable scope
func addr() func(int) int {
	// the addr() would bound to the variable `sum`
	sum := 0
	return func(n int) int {
		sum += n
		return sum
	}
}

func functionClosures() {
	pos, neg := addr(), addr()
	for i := 0; i < 10; i++ {
		fmt.Println(
			pos(i),
			neg(-2*i),
		)
	}
}

// ================ example.2 ================

// fibonacci is a function that returns
// a function that returns an int.
// 0, 1, 1, 2, 3, 5, ...
func fibonacci() func() int {
	prev, curr, ret := 0, 1, -1
	return func() int {
		ret = prev
		prev = curr
		curr = ret + prev
		return ret
	}
}

func fibseries() {
	f := fibonacci()
	for i := 0; i < 10; i++ {
		fmt.Println(f())
	}
}
```



### Methods (Value Receiver and Reference/Pointer Receiver)

In general, pointer receiver is much better than value one, there are two reasons.

*   Pointer receiver can modify the value which the receiver pointed to.
*   It is more efficient when the receiver was a huge struct.

```go
// Vertex save the coordinate of a vertex.
type Vertex struct {
	X, Y float64
}

// ================ example.1 ================

// Abs has a receiver (v Vertex).
// Golang has no class.
// However you can define methods to the specific type (called receiver).
func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func methodExample() {
	newVertex := Vertex{3, 4}
	fmt.Println(newVertex.Abs())
}

// ================ example.2 ================

// Abs is an alternative way.
// method is also a function
func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func methodAsFunc() {
	newVertex := Vertex{3, 4}
	fmt.Println(Abs(newVertex))
}

// ================ example.3 ================

type newFloat float64

// Abs has a receiver (nf newFloat).
// The receiver can be different types, not only struct.
func (nf newFloat) Abs() float64 {
	if nf < 0 {
		// explict type conversion
		return float64(-nf)
	}
	return float64(nf)
}

func receiverExample() {
	newf := newFloat(-math.Sqrt2)
	fmt.Println(newf.Abs())
}

// ================ example.4 ================

// pscale has a pointer receiver
// pointer receiver or reference receiver is more common than
// value recevier because it can modify the value of variable
// passed in
func (v *Vertex) pscale(s float64) {
	v.X = v.X * s
	v.Y = v.Y * s
}

// vscale has a value receiver
// value receiver only copy the value, it can't change the
// variable value
func (v Vertex) vscale(s float64) {
	v.X = v.X * s
	v.Y = v.Y * s
}

func valuePointerReceiverCompare() {
	var nv = Vertex{3, 4}
	nv.vscale(2)    // can't change nv value
	fmt.Println(nv) // {3,4}
	(&nv).pscale(4) // can modify nv value, == nv.pscale(4)
	fmt.Println(nv) // {12,16}
}

// ================ example.5 ================

func pscale(v *Vertex, s float64) {
	v.X = v.X * s
	v.Y = v.Y * s
}

// pointer receiver with a function
func pointerReceiverWithFunc() {
	nv := Vertex{3, 4}
	pscale(&nv, 10)
	fmt.Println(nv.Abs())
}
```



### Interfaces

An interface type is defined as the set of method signatures.

```go
// ================ example.1 ================

type nfloat float64

func (n nfloat) abs() float64 {
	if n < 0 {
		return float64((-n).abs())
	}
	return float64(n)
}

type vertex struct {
	X, Y float64
}

func (v *vertex) abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

type abser interface {
	abs() float64
}

func interfaceExample() {
	// original way with pointer receivers or methods
	nf := nfloat(-math.SqrtPi)
	nv := &vertex{3, 4}
	fmt.Println(nf.abs(), nv.abs())

	// using interface
	// notice the interface accept the assignment from different types
	var it abser
	it = nf
	fmt.Println(it.abs())
	it = nv
	fmt.Println(it.abs())
}

// ================ example.2 ================

type f64 float64

type it interface {
	pm()
}

func (f *f64) pm() {
	fmt.Println(f)
}

func interfaceExample2() {
	var i, i2 it
	var f *f64

	// no initialization, the value is <nil>
	i = f
	fmt.Printf("%v, %T\n", i, i)

	// nil interface
	fmt.Printf("%v, %T\n", i2, i2)

	// calling a nil iterface with methods caused a run-time error
	//i2.pm()
}

// ================ example.3 ================

func emptyInterface() {
	// empty interface holds values of any type
	type I interface{}

	var i I
	fmt.Printf("%v, %T\n", i, i)

	i = 100
	fmt.Printf("%v, %T\n", i, i)

	i = "this is a string"
	fmt.Printf("%v, %T\n", i, i)
}
```



### Type Assertion to Interface

```go
// ================ example.1 ================
// type assertion to the interface's value

func typeAssertion() {
	var I interface{} = "hello"

	// type assertion to interface's value
	val := I.(string)
	fmt.Println(val)

	// more correct way to type assertion
	// val (interface's value), ok (type assertion)
	val, ok := I.(string)
	fmt.Println(val, ok) // hello, true

	f, ok := I.(float64)
	fmt.Println(f, ok) // 0, false

	/*
		// the following would go panic, lacking `ok` to assert the type
		f = I.(float64)
		fmt.Println(f)
	*/
}

// ================ example.2 ================
// an example to type switch

func describeType(i interface{}) {
	// a type switch is a construct that permit several type assertions in series
	// syntax is similar with origin type assertion, e.g. i.(int)
	// but replace the `int` with `type`
	//
	// type switch, i.(type), must be used in `switch` syntax
	switch v := i.(type) {
	case int:
		fmt.Printf("Twice of %v is %v.\n", v, v*2)
	case string:
		fmt.Printf("The length of string is %v.\n", len(v))
	default:
		fmt.Printf("No corresponding operations to '%v', type is %T.\n", v, v)
	}
}
```



### Stringers

A stringer is a type that can describe itself as a string. The most common interface is `Stringer` defined by the `fmt` package. 

```go
type Stringer interface{
    String() string
}
```

The `fmt` package looks for this interface to print values.

```go
// ================ example.1 ================

type person struct {
	name string
	age  int
}

// implement String() in Stringer interface
func (p *person) String() string {
	return fmt.Sprintf("Person name is %v, the age is %v", p.name, p.age)
}

func stringerExample() {
	p1 := person{"Peter", 21}
	p2 := person{"John", 12}

	// notice here must use `&p1`
	// due to the pointer receiver defined above (p *person)
	fmt.Println(&p1)
	fmt.Println(&p2)
}

// ================ example.2 ================

// IPAddr saves the ip address.
type IPAddr [4]byte

func (ip IPAddr) String() string {
	return fmt.Sprintf("%v.%v.%v.%v", ip[0], ip[1], ip[2], ip[3])
}

func showIPAddr() {
	hosts := map[string]IPAddr{
		"loopback":  {127, 0, 0, 1},
		"googleDNS": {8, 8, 8, 8},
	}
	for name, ip := range hosts {
		fmt.Printf("%v: %v\n", name, ip)
	}
}
```



### Errors

Go program express error state with `error` values. Like `fmt.Stringer`,  the `error` type is a built-in inferface.

```go
type error interface{
    Error() string
}
```

```go
import (
	"fmt"
	"math"
	"time"
)

// ================ example.1 ================

type MyError struct {
	when time.Time
	what string
}

// implement the Error() defined by interface
// which is called by `fmt` while printing values
func (e *MyError) Error() string {
	return fmt.Sprintf("At %v, error %v occurred.\n", e.when, e.what)
}

func run() error {
	// a simple example
	return &MyError{
		time.Now(),
		"This didn't work.",
	}
}

func errorExample() {
	if err := run(); err != nil {
		fmt.Println(err)
	}
}

// ================ example.2 ================

type ErrNegativeSqrt float64

func (f *ErrNegativeSqrt) Error() string {
	// avoid using fmt.Sprintf("%v", v)
	// replace it with fmt.Sprintf("%v", float64(v))
	// due to the value is an infinite floating value
	return fmt.Sprint("Can's sqrt the value ", float64(*f), "\n")
}

func Sqrt(x float64) (float64, error) {
	if x < 0 {
		err := ErrNegativeSqrt(float64(x))
		return float64(0.0), &err
	}

	z := 1.0
	guess := 0.0

	for {
		guess = (z*z - x) / (2 * z)
		if math.Abs(guess) < 1e-8 {
			break
		}
		z -= guess
	}

	return z, nil
}
```



### Readers

```go
import (
	"fmt"
	"io"
	"os"
	"strings"
)

// ================ example.1 ================

func stringReader() {
	r := strings.NewReader("Hello world, Readers in GoLang.")
	b := make([]byte, 8)
	for {
		// `Read() returns n (the number of bytes populated) and err (nil or io.EOF for end)`
		n, err := r.Read(b)
		fmt.Printf("Number of bytes: %v, Error: %v, Data in []byte is: %v\n", n, err, b)

		// reachs the end of the reader (the flag `io.EOF`)
		if err == io.EOF {
			break
		}
	}
}

// ================ example.2 ================

type MyReader struct{}

func (r MyReader) Read(b []byte) (int, error) {
	for i := 0; i < len(b); i++ {
		b[i] = byte('A')
	}
	return len(b), nil
}

// ================ example.3 ================

type rot13Reader struct {
	r io.Reader
}

func (r13 *rot13Reader) Read(b []byte) (int, error) {
	for {
		n, err := r13.r.Read(b)
		if err == io.EOF {
			return 0, io.EOF
		}
		for idx := 0; idx < len(b); idx++ {
			v := &b[idx]
			if *v >= 65 && *v <= 77 {
				*v += 13
			} else if *v >= 78 && *v <= 90 {
				*v -= 13
			} else if *v >= 97 && *v <= 109 {
				*v += 13
			} else if *v >= 110 && *v <= 122 {
				*v -= 13
			}
		}
		return n, nil
	}
}

func main() {
	stringReader()

	s := strings.NewReader("Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	io.Copy(os.Stdout, &r)
}
```



### Image

Image is defined as an interface.

```go
package image

type Image interface{
    ColorModel() color.Model
    Bounds() Rectangle
    At(x, y int) color.Color
}
```

```go
import (
	"fmt"
	"image"
	"image/color"

	"golang.org/x/tour/pic"
)

// ================ example.1 ================

func imageExample() {
	m := image.NewRGBA(image.Rect(0, 0, 100, 100))
	fmt.Println(m.Bounds())
	fmt.Println(m.At(0, 0))
}

// ================ example.2 ================
// Exercise: Images

type Image struct{}

// ColorModel should return color.RGBAModel
func (img Image) ColorModel() color.Model {
	return color.RGBAModel
}

// Bounds should return a image.Rectangle, like image.Rect(0, 0, w, h).
func (img Image) Bounds() image.Rectangle {
	return image.Rect(0, 0, 100, 100)
}

// At should return a color;
// the value v in the last picture generator corresponds
// to color.RGBA{v, v, 255, 255} in this one.
func (img Image) At(x, y int) color.Color {
	v := uint8(x ^ y)
	return color.RGBA{v, v, 255, 255}
}

func main() {
	imageExample()

	m := Image{}
	pic.ShowImage(m)
}
```



### Goroutine

A goroutine is a lightweight thread managed by GO runtime. The function is running on a new goroutine. Goroutine run in the same address space, so access to the shared memory must be synchorized.

```go
import (
	"fmt"
	"time"
)

// ================ example.1 ================

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

func goroutineExample() {
	go say("world") // a simple way to execute a goroutine
	say("hello")
}
```



### Channels

Channels are like conduit to allow you to send or receive values via operator `<-` between goroutines.

The following examples are included:

*   `channels`
*   `buffered channels`
*   `range and close`
*   `select with case`: `Select` must be receive, send, or assign recv.
*   `default selection`



```go
import (
	"fmt"
	"strconv"
	"time"

	"golang.org/x/tour/tree"
)

// ================ example.1 ================

func sum(intList []int, c chan int) {
	total := 0
	for _, v := range intList {
		total += v
	}
	c <- total // send the value to channel
}

func channelExample() {
	intList := []int{2, 3, 4, 5, 6, 7}

	// create a channel
	ch := make(chan int)
	go sum(intList[:len(intList)/2], ch)
	go sum(intList[len(intList)/2:], ch)

	// result callback is a stack in FILO (first in last out)
	// but the channel is a stack in FIFO (first in first out)
	data1, data2 := <-ch, <-ch // receive the value from channel
	fmt.Println(data1, data2, data1+data2)
}

// ================ example.2 ================

func bufferedChannelExample() {
	// create a buffered channel
	ch := make(chan string, 10)

	for i := 0; i < 10; i++ {
		ch <- "insert " + strconv.Itoa(i)
	}

	// receiving from a buffered channel
	// is the way of FIFO (First in First Out)
	for i := 0; i < 10; i++ {
		fmt.Println(i, <-ch)
	}
}

// ================ example.3 ================

// A sender (only) can close the channel, the receiver can
// use the second parameter (ok), like `val, ok := <-ch`,
// to test whether the channel is closed.
// A channel doesn't need being closed, only when the receiver
// is required to be told the channel is closed.
// Like in for loop to continue receive the value.

func fibonacci(n int, ch chan int) {
	// 0, 1, 1, 2, 3, 5, 8, 13, 21, ...
	ret, cur, tmp := 0, 1, -1
	for i := 0; i < n; i++ {
		ch <- ret
		tmp = ret + cur
		ret = cur
		cur = tmp
	}
	close(ch) // close the channel
}

func closeAndRangeInChannel() {
	ch := make(chan int, 10)
	// we create a buffered channel saving the fibonacci list
	// a safety way is that the bufferred size is the same with the step size
	go fibonacci(cap(ch), ch)
	for val := range ch {
		fmt.Println(val)
	}

	// test whether the channel is closed
	// by adding second parameter, like ok in the following script
	val, ok := <-ch
	fmt.Println(val, ok)
}

// ================ example.4 ================

// Select in goroutine can wait the multiple channel communication.
// the following script would encounter the blocking issue

func selectBody(ch chan int, quit chan int) {
	x, y := 0, 1
	for {
		select {
		case ch <- x:
			x, y = y, x+y
		case <-quit:
			fmt.Println("Quit")
			return
		}
	}
}

func selectExample() {
	ch := make(chan int)
	quit := make(chan int)
	go func() {
		for i := 0; i < 10; i++ {
			fmt.Println(<-ch)
		}
		quit <- 0
	}()
	selectBody(ch, quit)
}

// ================ example.5 ================

// Default selection would solve the blocking issue.

func defaultSelection() {
	tick := time.Tick(50 * time.Millisecond)
	boom := time.After(100 * time.Millisecond)
	for {
		select {
		case <-tick:
			fmt.Println("Tick")
		case <-boom:
			fmt.Println("Boom")
			return
		default:
			fmt.Println("   .")
			time.Sleep(100 * time.Millisecond)
		}
	}
}

// ================ example.6 ================
// Exercise: Equivalent Binary Trees

/*
type Tree struct {
    Left  *Tree
    Value int
    Right *Tree
}
*/

// Walk walks the tree t sending all values
// from the tree to the channel ch.
func Walk(t *tree.Tree, ch chan int) {
	if t.Left != nil {
		Walk(t.Left, ch)
	}
	ch <- t.Value
	if t.Right != nil {
		Walk(t.Right, ch)
	}
}

// Same determines whether the trees
// t1 and t2 contain the same values.
func Same(t1, t2 *tree.Tree) bool {
	ch := make(chan int, 10)
	desc1, desc2 := "", ""

	go Walk(t1, ch)
	for i := 0; i < 10; i++ {
		v, _ := <-ch
		desc1 = fmt.Sprintf("%v %v", desc1, v)
	}

	go Walk(t2, ch)
	for i := 0; i < 10; i++ {
		v, _ := <-ch
		desc2 = fmt.Sprintf("%v %v", desc2, v)
	}

	fmt.Println(desc1)
	fmt.Println(desc2)
	return desc1 == desc2
}

func equalBT() {
	nt1 := tree.New(3)
	nt2 := tree.New(3)
	fmt.Println(Same(nt1, nt2))
}
```



### Sync.Mutex

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

// ================ example.1 ================
// Mutal Exclusion

// The struct safeCounter is used in concurrency.
type safeCounter struct {
	v   map[string]int
	mux sync.Mutex
}

// Inc increase the counter for the given key.
func (s *safeCounter) Inc(key string) {
	s.mux.Lock()
	// in the section, surrounding by lock() and unlock(),
	// for mutal exclusion would only be counted for one goroutine
	s.v[key]++
	s.mux.Unlock()
}

func (s *safeCounter) value(key string) int {
	// lock so that only one goroutine can access the value
	s.mux.Lock()
	defer s.mux.Unlock()
	return s.v[key]
}

func mutalExample() {
	sc := safeCounter{v: make(map[string]int)}
	for i := 0; i < 1001; i++ {
		go sc.Inc("somekey")
	}

	time.Sleep(time.Second)
	fmt.Println(sc.value("somekey"))
}

// ================ example.2 ================
// Exercise: Web Crawler

// fakeFetcher is Fetcher that returns canned results.
type fakeFetcher map[string]*fakeResult

type fakeResult struct {
	body string
	urls []string
}

func (f fakeFetcher) Fetch(url string) (string, []string, error) {
	if res, ok := f[url]; ok {
		return res.body, res.urls, nil
	}
	return "", nil, fmt.Errorf("not found: %s", url)
}

// fetcher is a populated fakeFetcher.
var fetcher = fakeFetcher{
	"https://golang.org/": &fakeResult{
		"The Go Programming Language",
		[]string{
			"https://golang.org/pkg/",
			"https://golang.org/cmd/",
		},
	},
	"https://golang.org/pkg/": &fakeResult{
		"Packages",
		[]string{
			"https://golang.org/",
			"https://golang.org/cmd/",
			"https://golang.org/pkg/fmt/",
			"https://golang.org/pkg/os/",
		},
	},
	"https://golang.org/pkg/fmt/": &fakeResult{
		"Package fmt",
		[]string{
			"https://golang.org/",
			"https://golang.org/pkg/",
		},
	},
	"https://golang.org/pkg/os/": &fakeResult{
		"Package os",
		[]string{
			"https://golang.org/",
			"https://golang.org/pkg/",
		},
	},
}

// Fetcher returns the body of URL and
// a slice of URLs found on that page.
type Fetcher interface {
	Fetch(url string) (body string, urls []string, err error)
}

type urlParsing struct {
	urlList []string
	m       sync.Mutex
}

func stringInSlice(a string, list []string) bool {
	for _, b := range list {
		if b == a {
			return true
		}
	}
	return false
}

func (u *urlParsing) checkAndAdd(url string) bool {
	u.m.Lock()
	exists := stringInSlice(url, u.urlList)
	if !exists {
		u.urlList = append(u.urlList, url)
		defer u.m.Unlock()
		return false
	}
	defer u.m.Unlock()
	return true
}

var u = urlParsing{urlList: make([]string, 0)}

// Crawl uses fetcher to recursively crawl
// pages starting with url, to a maximum of depth.
// Here we use sync.WaitGroup to wait all goroutines done.
func Crawl(url string, depth int, fetcher Fetcher, wg *sync.WaitGroup) {
	// TODO: Fetch URLs in parallel.
	// TODO: Don't fetch the same URL twice.
	// This implementation doesn't do either:
	defer wg.Done()

	if depth <= 0 {
		return
	}

	existing := u.checkAndAdd(url)

	if existing {
		return
	}

	body, urls, err := fetcher.Fetch(url)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("found: %s %q\n", url, body)

	for _, ur := range urls {
		//fmt.Println("...", ur)
		wg.Add(1)
		go Crawl(ur, depth-1, fetcher, wg)
		time.Sleep(100 * time.Microsecond) // handover the control to the goroutine
	}
	return
}

func main() {
	mutalExample()

	var wg sync.WaitGroup
	wg.Add(1)
	go Crawl("https://golang.org/", 4, fetcher, &wg)
	wg.Wait()
	fmt.Println("Wait for complete.")
}
```




## Built-in Libraries



| Main Package | Sub Package / Names | Description                                                  |
| ------------ | ------------------- | ------------------------------------------------------------ |
|(Built-in)|len()|return the length of object, e.g. array, etc.|
||cap()|return the length of underlying object, e.g. array, etc.|
||append(obj, element)|append the element its type must be the same to the slice|
|reflect|Typeof(obj)|return the data type of object|
|io|-|includes files, network connections, compressors, etc.|
||func (T) Read(b []byte) (n int, err error)|read the specific type of data via []byte|
||Copy(os.Stdout, &r)||
| math        | Intn(number)        | Get the a random integer number.                             |
|              | Seed(number)        | Set the random seed.                                         |
|              | Sqrt(number)        | Get the sqrt of a number.                                    |
|              | Pi                  | A constant, 3.141592653...                                   |
|              | cmplx               | Complex number calculation.                                  |
|strings|Join(obj, sep="")|Concatenate the elements as the string.|
||Pow(x, n)|== x ^ n, e.g. Pow(3, 2) = 9|
||Split(string, sep="")|split the word into a array|
||NewReader("")|string reader|
| fmt          | -                   | <https://golang.org/pkg/fmt/>                                |
||Println()|Print message in a line format.|
||Printf("%v", var)|Print message in the format we defined.|
||Sprint(var)|Transform var as a string.|
||Sprintf()|Transform var in the format we defined.|
| strconv      | Atoi                | v, err := strconv.Atoi("14321")   // two returns, string to int |
|              | Itoa                | v2 := strconv.Itoa(928354)         // one return, int to string |
|runtime|GOOS|os type, darwin: Mac OS, linux, Linux, etc.|
|time|Now()|the current time|
||Now().Weekday()|the current day, another usage is `time.Saturday`|
||Now().Hour()|return 0-23|
|image|-||
|sync|WaitGroup|use sync.WaitGroup to wait all goroutines done|

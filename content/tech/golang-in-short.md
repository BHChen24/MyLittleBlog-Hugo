---
title: "Golang in short"
date: 2026-09-10T11:24:00
description: "Quick notes of GO"
tags: ["go", "tutorial"]
categories: ["Tech notes"]
---

> 🔔 **Prelude:**
> No need for digging a big hole, just use it.

## Golang in short

---

### Go is

1. A modern high-level programming language that resembles C
2. Open-source, compiled, statically typed, and memory-safe

### Go has

1. Simple yet powerful package management (pulls directly from GitHub)
2. Built-in concurrency primitives
3. Garbage collection (GC)
4. Lightning-fast compilation
5. Minimal syntax
6. Cross-platform compilation

### Go doesn't have

1. Classes and inheritance
2. Function overloading
3. Implicit type conversions

### I use Go to

1. Say goodbye to Java's verbose syntax
2. Build web services and microservices
3. Handle high-concurrency scenarios

### Go is perfect for

1. Web services and RESTful APIs
2. Microservices architecture
3. Network programming and distributed systems

### Go might not be ideal for

1. GUI desktop applications
2. Kernel development
3. Machine learning (Python has a stronger ecosystem)

---

## Installing Go

1. Using OS package managers
    - Linux: `apt`, `yum`, `snap`
    - macOS: `brew`
    - Windows: `choco`, `scoop`, etc.
2. Download official precompiled binaries
    - Already compiled, ready to use
    - Set up path and links manually
3. Verify with `go version`

### Hello World

```go
// This is a comment
/* This is
   a multiline
   comment */
package main // This is the main package

// No semicolons at line endings

import (
    "fmt"
    "math"
) // Importing other packages

const myConstant int = 0 // Constants need explicit initialization

func main() {
    fmt.Println("helloworld")
    // Package names -> lowercase
    // Lowercase in package -> myConstant -> package-private
    // Capitalized -> Println() -> exported (public)
}

```

### Types

```go
bool

string

int  int8  int16  int32  int64
uint uint8 uint16 uint32 uint64 uintptr // Has pointers but no pointer arithmetic

byte // alias for uint8

rune // alias for int32
     // Represents a Unicode code point
     // From ancient Nordic "rune"

float32 float64

complex64 complex128

// Zero value for reference types is nil

// Type assertion
t, ok := variable.(int) // Returns two values, ok indicates success
                        // Panics if ok is not captured and type is wrong

// Type conversion
var myInt int32 = 42
myAnotherInt := int64(myInt) // Type conversion
                             // No direct conversion between bool and int
                             // Generally, single characters and numbers can convert
                             // Otherwise, only conversions within same type family

```

### Variables and Functions

```go
var hi bool = true // Variables outside functions must have explicit types

func myFunc(x, y int) (int, int) {
    innerHi := "hi" // Inside functions, use := for type inference
    const hiConst = "hi again" // Constants cannot use :=
    return x + 1, y + 1
}

func MapFilter[T any, R comparable](
    slice []T,
    mapper func(T) R,
    predicate func(R) bool,
) func(options ...int) (filtered []R, count int, err error) {
    // Returns a function
    return func(options ...int) (filtered []R, count int, err error) {
        // Implementation
        return
    }
}
// A complete function signature example
// Note the second func starts parameters
// The last func starts return type -> returns a function
// T is generic, R is constraint, but they're essentially the same thing

func(x int) int { return x * 2 } // Anonymous function definition

```

### Arrays, Slices, and Maps

```go
// Arrays - fixed length
var arr [5]int = [5]int{1, 2, 3, 4, 5}
arr2 := [...]int{1, 2, 3} // Compiler infers length

// Slices - dynamic length
var slice []int = []int{1, 2, 3}
slice2 := make([]int, 5)     // Length 5
slice3 := make([]int, 5, 10) // Length 5, capacity 10

// Maps
var m map[string]int = map[string]int{"one": 1, "two": 2}
m2 := make(map[string]int)
m2["key"] = 42

// Check if key exists
value, exists := m["key"]
if exists {
    fmt.Println(value)
}

```

### Control Flow

```go
// Only for loops exist
// All parts of for loop are optional
for i := 0; i < 10; i++ {
    // Loop body
}

// Infinite loop
for {
    // Equivalent to while(true)
}

// Condition loop
i := 0
for i < 10 {
    i++
}

for i, v := range expression {} // Iterate over iterables
                                // Similar to Python's for..in
                                // Directly provides index and value
                                // No enumerate function needed
                                // Use _, v to ignore index

// if statement
if v := 5; v < 6 { // Can assign in condition
    // Condition body
}

// switch statement
switch x := 5; x { // x is optional
    case 1:
        fmt.Println("one")
    case 2, 3, 4:      // Multiple values
        fmt.Println("two, three or four")
    default:
        fmt.Println("other")
}

// Type switch
switch v := x.(type) {
    case int:
        fmt.Printf("int: %d\n", v)
    case string:
        fmt.Printf("string: %s\n", v)
    default:
        fmt.Printf("unknown type\n")
}

```

### Defer and Channels

```go
// defer - deferred execution (stack structure, LIFO)
defer fmt.Println(1)
defer fmt.Println(2)
defer fmt.Println(3)
panic("!")

// Output order: 3 2 1 panic
// defer provides stack-based deferred execution
// panic triggers deferred functions

// channel - channels (queue structure, FIFO)
func channelExample() {
    myChan := make(chan int, 2) // Buffer size 2
    myChan <- 10 // 10 goes in
    myChan <- 20 // then 20 goes in
    took := <-myChan      // took is 10
    fmt.Println(<-myChan) // 20
}

func blockingChannel() {
    ch := make(chan int) // Unbuffered channel
    // ch <- 1           // Will block! Need another goroutine to receive

    // Correct approach
    go func() {
        ch <- 1
    }()
    fmt.Println(<-ch)
}

// Channels provide a queue-like or pipe-like structure
// FIFO

```

### Pointers

```go
// Go has pointers
// Useful when referencing large data
// Go's design philosophy is very close to C-family languages
// Fun fact: When passing pointers to functions, both C and Go copy the pointer
// All parameters are pass-by-value in both languages
// But C++ has completely different reference passing mechanism

func main() {
    var myPtr *int
    // var anotherPtr uintptr  // uintptr is integer type, not pointer

    i := 42
    myPtr = &i // Take address

    fmt.Println(*myPtr) // Dereference, outputs 42
    *myPtr = 43         // Modify through pointer
    fmt.Println(i)      // Outputs 43

    // No pointer arithmetic
}

```

### Format Verbs

| Verb | Description | Example | Output |
| --- | --- | --- | --- |
| %v (value) | Default format | Printf("%v", people) | {zhangsan} |
| %+v | Adds field names for structs | Printf("%+v", people) | {Name:zhangsan} |
| %#v | Go syntax representation | Printf("%#v", people) | main.Human{Name:"zhangsan"} |
| %T (type) | Type in Go syntax | Printf("%T", people) | main.Human |
| %% | Percent sign | Printf("%%") | % |
| %t (true) | true or false | Printf("%t", true) | true |
| %b (binary) | Binary representation | Printf("%b", 5) | 101 |
| %c (char) | Unicode character | Printf("%c", 0x4E2D) | 中 |
| %d (decimal) | Decimal | Printf("%d", 0x12) | 18 |
| %o (octal) | Octal | Printf("%o", 10) | 12 |
| %q (quote) | Single-quoted character literal | Printf("%q", 0x4E2D) | '中' |
| %x | Hexadecimal, lowercase | Printf("%x", 13) | d |
| %X | Hexadecimal, uppercase | Printf("%X", 13) | D |
| %U (unicode) | Unicode format: U+1234 | Printf("%U", 0x4E2D) | U+4E2D |
| %b | Binary exponent scientific notation | Printf("%b", 10.5) | 5835037194198p-49 |
| %e | Scientific notation | Printf("%e", 10.2) | 1.020000e+01 |
| %E | Scientific notation | Printf("%E", 10.2) | 1.020000E+01 |
| %f (float) | Decimal point, no exponent | Printf("%f", 10.2) | 10.200000 |
| %g | Compact format (%e or %f) | Printf("%g", 10.20) | 10.2 |
| %G | Compact format (%E or %f) | Printf("%G", 10.20) | 10.2 |
| %s (string) | String (string or []byte) | Printf("%s", []byte("Go")) | Go |
| %q | Double-quoted string | Printf("%q", "Go") | "Go" |
| %x | Hex, lowercase, two chars per byte | Printf("%x", "golang") | 676f6c616e67 |
| %X | Hex, uppercase, two chars per byte | Printf("%X", "golang") | 676F6C616E67 |
| %p (pointer) | Hexadecimal with 0x prefix | Printf("%p", &people) | 0x4f57f0 |
| + | Always print sign; ASCII-only for %+q | Printf("%+q", "中文") | "\u4e2d\u6587" |
| - | Pad with spaces on right (left-align) |  |  |
| # | Alternate format: 0 prefix for octal (%#o), 0x for hex (%#x), etc. | Printf("%#U", '中') | U+4E2D '中' |
| ' ' | Space for elided sign; spaces between bytes for hex |  |  |
| 0 | Pad with zeros; moves padding after sign for numbers |  |  |

Reference:

### String Formatting

```go
// %[flags][width][.precision]verb

// Width and alignment
fmt.Printf("%5d\n", 42)      // "   42" right-aligned, width 5
fmt.Printf("%-5d\n", 42)     // "42   " left-aligned, width 5
fmt.Printf("%05d\n", 42)     // "00042" zero-padded

// String alignment
fmt.Printf("|%10s|\n", "hello")   // "|     hello|" right-aligned
fmt.Printf("|%-10s|\n", "hello")  // "|hello     |" left-aligned
fmt.Printf("|%10s|\n", "你好")     // "|        你好|" handles Chinese

pi := 3.14159265359

// Decimal precision
fmt.Printf("%.2f\n", pi)     // "3.14" 2 decimal places
fmt.Printf("%.4f\n", pi)     // "3.1416" 4 decimal places (rounded)
fmt.Printf("%8.2f\n", pi)    // "    3.14" width 8, 2 decimals
fmt.Printf("%08.2f\n", pi)   // "00003.14" zero-padded

// Scientific notation precision
fmt.Printf("%.3e\n", pi)     // "3.142e+00"
fmt.Printf("%.3g\n", 0.00012345)  // "0.000123" auto format

// + flag: show sign
fmt.Printf("%+d\n", 42)      // "+42"
fmt.Printf("%+f\n", -3.14)   // "-3.140000"

// # flag: show base prefix
fmt.Printf("%#x\n", 255)     // "0xff"
fmt.Printf("%#o\n", 8)       // "010"
fmt.Printf("%#b\n", 5)       // "0b101"

// Space: add space for positive numbers
fmt.Printf("% d\n", 42)      // " 42"
fmt.Printf("% d\n", -42)     // "-42"

// Making tables
fmt.Printf("%-10s %8.2f %5d\n", "Apple", 3.99, 10)
fmt.Printf("%-10s %8.2f %5d\n", "Banana", 12.5, 5)
// Output:
// Apple          3.99    10
// Banana        12.50     5

// Dynamic width and precision
width := 10
precision := 2
fmt.Printf("%*.*f\n", width, precision, pi)  // Width and precision from variables

```

### Structs

```go
type MyStruct struct {
    x int  // Private field (package-visible)
    Y int  // Public field (exported)
}

// No need for "->" with struct pointers, Go handles it

// Value receiver method
func (s MyStruct) myFunc(x, y int) (int, int) {
    return s.x + x, s.Y + y
}

// Pointer receiver method
func (s *MyStruct) modify(x int) {
    s.x = x  // Can modify original struct
}

// Pointer receivers can accept values and pointers
// Value receivers can also accept both, Go handles it automatically
// In a sense, pointer parameters have "broader" acceptance

// Struct tags
type User struct {
    Name string `json:"name" xml:"user-name"`
    Age  int    `json:"age,omitempty"`
    Pass string `json:"-"` // Ignore this field
}

// Reading tags with reflection
import "reflect"
field, _ := reflect.TypeOf(User{}).FieldByName("Name")
fmt.Println(field.Tag.Get("json"))  // "name"

```

### Interfaces

```go
// Interfaces define method signatures
// No explicit implementation needed - types automatically implement interfaces
// Interfaces can embed other interfaces

type MyInterface interface {
    myAdd(x, y int) int
}

type MyStruct struct{
    x int
    y int
}

func (s MyStruct) myAdd(x, y int) int { // Implements myAdd
    return x + y
}

// Now MyStruct implements MyInterface

// Empty interface
interface{} // or any (Go 1.18+)
// Can store any type
var x interface{} = 42
x = "hello"
x = []int{1, 2, 3}

// Empty struct
var y struct{} = struct{}{}
// Takes no memory, often used as signal

```

### Error Handling

```go
// error is a built-in interface
type error interface {
    Error() string
}

// Functions typically return result and error
result, err := doSomething()
if err != nil {
    fmt.Printf("couldn't convert number: %v\n", err)
    return
}

// Custom error
type MyError struct {
    msg string
}

func (e MyError) Error() string {
    return e.msg
}

// Create errors with errors package
import "errors"
err := errors.New("something went wrong")

// Format errors with fmt.Errorf
err := fmt.Errorf("invalid value: %d", value)

```

### Concurrency

```go
// Use go keyword to start goroutines
func main() {
    go say("world")
    say("hello")

    // Need to wait for goroutines to finish
    time.Sleep(time.Second)
}

// See Defer and Channels section for channel creation

// Sending to full channel blocks
// Receiving from empty channel blocks

// Close channel
close(myChan)
// Note: Only senders should close channels

// Use select to handle multiple channels
// Like concurrent switch
// select blocks until one case can proceed
// When multiple cases ready, randomly picks one
select {
    case v := <-ch1:
        fmt.Println("received from ch1:", v)
    case ch2 <- x:
        fmt.Println("sent to ch2")
    case <-quit:
        fmt.Println("quit")
        return
    default:
        fmt.Println("no communication")
}

// Mutex
import "sync"
var mu sync.Mutex

mu.Lock()
// Critical section
mu.Unlock()

// Use defer to ensure unlock
mu.Lock()
defer mu.Unlock()
// Critical section

// Directional channels
func send(ch chan<- int) { ch <- 42 }      // Send-only
func recv(ch <-chan int) { val := <-ch }   // Receive-only

// Check if channel is closed
v, ok := <-ch  // ok is false if channel closed and empty

```

### Various Magic 🪄

#### `...`

```go
// 1. Variadic functions
func sum(nums ...int) int {
    total := 0
    for _, n := range nums {
        total += n
    }
    return total
}

// Calling
sum(1, 2, 3)      // Can pass multiple
sum(1)            // Can pass one
sum()             // Can pass none

// 2. Expanding slices
numbers := []int{1, 2, 3, 4}
result := sum(numbers...)  // Expand to multiple arguments

// Common usage
slice1 := []int{1, 2}
slice2 := []int{3, 4}
combined := append(slice1, slice2...)  // Expand slice2

// 3. Array literals
arr := [...]int{1, 2, 3, 4, 5}  // Compiler calculates length, result is [5]int

// Useful with indices
arr := [...]string{
    0: "zero",
    5: "five",   // Array length is 6
}

```

Notes:

1. Variadic parameter must be last
2. Inside function, variadic parameter is slice type
3. Types must match when expanding

#### Initialization Tricks

```go
// Initialize array with indices
arr := [10]int{0: 1, 9: 10}  // 0th is 1, 9th is 10, rest are 0

// Initialize map with keys
m := map[string]int{
    "a": 1,
    "b": 2,
}

// Partial struct initialization
type Point struct{ X, Y int }
p := Point{Y: 10}  // X is 0, Y is 10

```

#### iota Enumerations

```go
// iota starts at 0 in each const declaration
const (
    A = iota  // 0
    B         // 1
    C         // 2
)

// Skip values
const (
    _  = iota  // 0 (skip)
    KB = 1 << (10 * iota)  // 1 << 10 = 1024
    MB         // 1 << 20 = 1048576
    GB         // 1 << 30 = 1073741824
)

// Bit flag enums
type Permission int

const (
    Read Permission = 1 << iota  // 1
    Write                        // 2
    Execute                      // 4
)

// Usage
var perm Permission = Read | Write  // Combine permissions

// Check permission
if perm&Read != 0 {
    fmt.Println("Has read permission")
}

// Add permission
perm |= Execute

// Remove permission
perm &^= Write

```

#### Type Aliases vs Type Definitions

```go
// Type alias (Go 1.9+) - completely equivalent
type MyInt = int  // MyInt is int, interchangeable

// Type definition - creates new type
type MyInt int    // MyInt is new type, cannot assign directly

// Example
type Celsius float64
type Fahrenheit float64

var c Celsius = 100
var f Fahrenheit = 212
// f = c  // Error! Type mismatch
f = Fahrenheit(c * 9/5 + 32)  // Need explicit conversion

```

#### make vs new

```go
new(T)      // Returns *T, zero value allocation; commonly for simple structs
make(...)   // Only for slice/map/chan, returns initialized value (not pointer)

// Examples
p := new(int)           // *int, value is 0
s := make([]int, 5)     // []int, length 5, initialized
m := make(map[string]int) // map[string]int, initialized

```

### Go Gotchas and Important Notes

#### Slice Underlying Array Sharing

```go
// Passing slice copies slice header (pointer, len, cap), shares underlying array
s := []int{1, 2, 3}
t := s[:2]         // Shares underlying array with s
s = append(s, 4)   // May trigger reallocation, t no longer shares

// Modifying shared underlying array
s := []int{1, 2, 3, 4, 5}
t := s[1:3]  // [2, 3]
t[0] = 99    // s becomes [1, 99, 3, 4, 5]

```

#### Map Randomness

```go
// Map iteration order is random, don't rely on order
m := map[string]int{"a": 1, "b": 2, "c": 3}
for k, v := range m {
    fmt.Println(k, v)  // Order may differ each run
}

// Cannot take address of map elements
// &m["key"]  // Compile error: map values not addressable

```

#### String Bytes vs Characters

```go
// len(string) returns byte count, not character count
s := "你好"
fmt.Println(len(s))  // 6 (3 bytes per Chinese character)

// for range string iterates by rune (UTF-8 decoded)
for i, r := range "你好" {
    fmt.Printf("%d: %c\n", i, r)  // 0: 你, 3: 好
}

// s[i] gives byte
fmt.Printf("%x\n", "你"[0])  // e4 (first byte)

// Strings are immutable, convert to []byte or []rune to modify
s := "hello"
// s[0] = 'H'  // Error!
bs := []byte(s)
bs[0] = 'H'
s = string(bs)  // "Hello"

```

#### Interface nil Pitfall

```go
// Interface value is (type, data) pair
// When type != nil, even if data == nil, interface is not nil

type MyErr struct{}
func (e *MyErr) Error() string { return "error" }

var e error
fmt.Println(e == nil)  // true

var pe *MyErr = nil
e = pe
fmt.Println(e == nil)  // false! type=*MyErr, data=nil

```

#### Loop Variable Pitfall

```go
// Loop variables reuse same memory location
// Be careful in goroutines/closures

// Wrong
for i, v := range []int{1, 2, 3} {
    go func() {
        fmt.Println(i, v)  // May all print 2, 3
    }()
}

// Correct: rebind
for i, v := range []int{1, 2, 3} {
    i, v := i, v  // Create new local variables
    go func() {
        fmt.Println(i, v)
    }()
}

```

#### Method Call Auto-conversion

```go
// Compiler automatically handles value/pointer conversion

type S struct{ n int }
func (s *S) Inc() { s.n++ }  // Pointer receiver

var v S
v.Inc()    // Compiler converts to (&v).Inc()

var p = &S{}
(*p).Inc() // Works but unnecessary
p.Inc()    // Direct call

```

#### Struct Embedding (Anonymous Fields)

```go
// Embedded field methods and properties are "promoted"

type A struct{ X int }
func (a A) Show() { fmt.Println(a.X) }

type B struct{
    A          // Anonymous embedding
    Y int
}

var b B
b.X = 1        // Direct access, equivalent to b.A.X
b.Show()       // Calls A's method

// With name conflicts, must specify explicitly
type C struct {
    A
    X int      // Shadows A.X
}
var c C
c.X = 1        // Accesses C.X
c.A.X = 2      // Accesses A.X

```

#### init Functions and Package Imports

```go
// init() executes automatically on package load
// Order: imported package init -> current package init -> main

package main

import (
    _ "database/sql"      // Only execute init, don't use exports
    _ "github.com/go-sql-driver/mysql"  // Register MySQL driver
)

func init() {
    fmt.Println("main init")
}

func main() {
    // Database driver already registered in init
}

```

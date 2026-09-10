---
title: "Rust Notes 2"
date: 2026-09-10T11:15:00
description: "Basic syntax: variable and function"
tags: ["rust", "tutorial"]
categories: ["Tech notes"]
---

## Syntax of Rust

Don’t worry, this will be very easy at the beginning. (Really?)

---

### Function goes first

- Similar to C and C++, there must be a `main` function as the entry point of the program.
- Use `fn` to declare a function, so concise.
- Use `()` for receiving parameters, and `{}` for the actual logic inside the function.
- Remember to use `;` to end a statement. As I said, it’s similar to C and C++.
- Example:

```rust
fn main() -> {
    println!("Hello, world!");
    // "ln" means print with a new line after the content
    // What is "!"? Well, it means this function is actually a macro
    // For now, let's just use it as is
    // You don't need to learn everything to start using Rust. Heart.
}
```

A complete structure of function head in Rust should be:

```rust
keyword name(parameter: type ) -> [return type] { body }

fn      myFunction(para : i32) -> i32 { ... }
```

---

### Define variables

- You **must** use `let` to create a variable.
    - `let myVar = 3;`
    - `let myVar: u32 = 3;` → Explicitly specifies the type of the variable `myVar` as `u32`. `u32` is a 32-bit unsigned integer type in Rust.
    - `let mut myVar = 3;` → Creates a **mutable** variable.
- What? Mutable?
    - Variables in Rust are **immutable by default**.(Its value is determined after compilation.)
    - It's important to understand that in Rust, `some_variable = some_value` is not just **assigning** a value, but rather **binding** the value to the variable.
    - This topic is related to Rust’s Ownership feature, which we will discuss in the next post.
    - Here's an example:

```rust
let myVar = 5;
myVar = 6; // Error

let mut myMutVar = 5;
myMutVar = 6; // Pass
```

- If you understand that variables are bound to values, it becomes easier to grasp **variable destructuring**:
    - Basically, destructuring means extracting values from patterns.

```rust
fn main() {
    let (a, mut b): (bool,bool) = (true, false);
    println!("a = {:?}, b = {:?}", a, b);
    // You can treat the {} as a placeholder for a or b
    // :? is for "formatting" output and "debugging" output
    // Whatever, it should print the value of a and b

    b = true;
    assert_eq!(a, b);
}
```

- You can also use `const` to define a constant value:
    - `const MY_CONST_VALUE: i32 = 5;`
    - Constants must always have a type annotation, unlike regular variables.

---

#### **Statement and expression**

- In short:

```rust
fn add_with_extra(x: i32, y: i32) -> i32  {
    let x = x + 1; // Statement
    let y = y + 5; // Statement
    x + y // Expression. Hey! Attention here! No ";" after the sentence!

    // Also expression is expected to "return" something
    // So we can avoid to write "return" in the end of our fn

    // In other word, statament CANNOT return a value
}
```

- Interesting facts:
    - In `let x = 1;`
        - `x` is an expression
        - `1` is an expression
        - `let x = 1;` is a statement
        - Bound
- Lastly, if an expression doesn’t return anything, it returns `()`
    - `()` is both a type and a value, and the value is `()`.
    - You can treat the `()` as a `()`, yes, that is it.

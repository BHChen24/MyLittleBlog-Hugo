---
title: "Rust Notes 3"
date: 2026-09-10T11:16:00
description: "Basic types 1"
tags: ["rust", "tutorial"]
categories: ["Tech notes"]
---

> 🔔 **Prelude:**
> In the end, all data types in Rust come from these primitive types.

## Basic types

- Every value in Rust has a specific data type
- In general, these can be divided into two categories: **scalar** types and **compound** types
- Scalar types include:
    - **Numbers**: Signed integers (`i8`, `i16`, `i32`, `i64`, `isize`), unsigned integers (`u8`, `u16`, `u32`, `u64`, `usize`), floating-point numbers (`f32`, `f64`)
        - The `isize` and `usize` types depend on the architecture of the computer the program is running on: if the CPU is 32-bit, these types are 32-bit; similarly, if the CPU is 64-bit, they are
        - Rust's **default** integer type is `i32`
        - Can overflow, and Rust does not check for this by default. If you encounter incorrect values, make sure to check the type of your numbers.
    - **Strings**: String literals and string slices
    - **Booleans**: `true` and `false`
    - **Characters**: Representing a single Unicode character, stored as 4 bytes
    - **Unit type**: Represented by `()`, with its only value also being `()`

---

### Be Careful with `float`s

See this example:

```rust
fn main() {
  assert!(0.1 + 0.2 == 0.3);
}
```

You might think this would return `true` , but the truth is, the program will panic and quit.

- Due to binary precision issues, `0.1 + 0.2` is not exactly equal to `0.3`
- You can consider using this approach: `(0.1_f64 + 0.2 - 0.3).abs() < 0.00001`

---

### NaN

- `-42.1.sqrt()` will produce `NaN`
- Any operation involving `NaN` will return `NaN`
- Comparing `NaN` will cause the code to panic and crash
- Use `is_nan()` to determine if a value is `NaN`

---

### **Use `as` for Type Conversion**

In Rust, you can use `as` to convert one type to another.

```rust
fn main() {
    let x: i32 = 10;
    let y: f64 = x as f64; // Convert i32 to f64

    println!("x as f64 is: {}", y);
}
```

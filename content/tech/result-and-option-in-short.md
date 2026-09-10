---
title: "Result and Option in short"
date: 2026-09-10T11:26:00
description: "Two old friends in Rust"
tags: ["rust"]
categories: ["Tech notes"]
---

> 🔔 **Prelude:**
> When writing Rust programs, Result and Option are data structures we can hardly avoid. I believe that rather than understanding their underlying mechanisms, we should first quickly figure out how to handle them.

## Gift Wrapping

Actually, we don't need to think of `Option<T>` and `Result<T,E>` as too complicated:

- `Option` contains the data we want, where the data type is `T`. However, there might be no data inside (`None`). But regardless, as long as what we care about is wrapped, it **will be** an `Option`.
- `Result` also contains the data we want, but it comes with another "restless" additional item `E` (Error). In fact, combinations of Result and Option are very common, such as `Result<Option<T>, E>`. `Result` provides a powerful and **unified** specification for Rust's error handling.

### So, how do we open the gift box...

The moment of unwrapping gifts is always exciting.

Whether it's `Option` or `Result`, we can use `unwrap()` to open this package.

- If the gift box contains a normal value, everything goes smoothly, and everyone's happy.
- But if it contains something "weird" (`None` or `Err`), the program will immediately `panic` and crash.

Of course, if we insist on using safer unwrapping methods (like `unwrap_or`, `match`, etc.), we can control whether the program crashes ourselves, which is very practical.

### What functions do these gift boxes provide?

Let's quickly go through the methods they provide. Detailed explanations won't be provided here, as I believe you can look up relevant information through [https://doc.rust-lang.org/std/option/](https://doc.rust-lang.org/std/option/) and [https://doc.rust-lang.org/std/result/](https://doc.rust-lang.org/std/result/).

#### Option

| API | Purpose | Return Value and Notes |
| --- | --- | --- |
| `is_some()` | Check if it's `Some` | `bool` |
| `is_none()` | Check if it's `None` | `bool` |
| `unwrap()` | Get the value inside `Some`, panic if `None` | `T` / `panic` |
| `unwrap_or(default)` | Get value, return specified default if `None` | `T` |
| `unwrap_or_else(f)` | Get value, call closure `f` to return default if `None` | `T` |
| `map(f)` | If `Some`, call `f` on inner value, return new `Option` | `Option<U>` |
| `and_then(f)` | If `Some`, call `f`, return another `Option` | `Option<U>` |
| `or(other)` | If `None`, return parameter `other`, otherwise return self | `Option<T>` |
| `or_else(f)` | If `None`, call closure `f` to return an `Option` | `Option<T>` |
| `as_ref()` | Convert `Option<T>` to immutable reference of inner value `Option<&T>` | `Option<&T>` |
| `as_mut()` | Convert `Option<T>` to mutable reference of inner value `Option<&mut T>` | `Option<&mut T>` |
| `ok_or(err)` | Convert `Some(value)` to `Ok(value)`, and `None` to `Err(err)` | `Result<T, E>` |
| `ok_or_else(f)` | Same as above, but call closure if `None` | `Result<T, E>` |
| `expect(msg)` | Similar to `unwrap()`, but allows custom error message | `T` / `panic` |
| `?` | Return `None` directly when `None` (must be used in functions returning `Option`) | `T` / early return |

Notable methods:

- `map(f)` provides a way to operate on inner data without unpacking, very commonly used
- `expect("Hi")` can display error messages when panicking, more practical than `unwrap()`
- `?` can greatly improve code cleanliness
- `is_some()` and `is_none()` are also very useful for making decisions

### Result

Compared to the intuitive and easy-to-understand `Option`, `Result` seems more "convoluted" with an additional type, but essentially it's almost identical to `Option`: what to do if we didn't get the value (possibly due to an error).

| API | Purpose | Return Value / Notes |
| --- | --- | --- |
| `is_ok()` | Check if it's `Ok` | `bool` |
| `is_err()` | Check if it's `Err` | `bool` |
| `unwrap()` | Get value inside `Ok`, `panic` if `Err` | `T` / `panic` |
| `unwrap_or(default)` | Get value, return default if `Err` | `T` |
| `unwrap_or_else(f)` | Get value, call closure `f` to return default if `Err` | `T` |
| `map(f)` | If `Ok`, call `f` on inner value, return new `Result` | `Result<U, E>` |
| `and_then(f)` | If `Ok`, call `f`, return another `Result` | `Result<U, E>` |
| `map_err(f)` | If `Err`, call `f` on error, return new `Result` | `Result<T, F>` |
| `or(other)` | If `Err`, return `other`, otherwise return self | `Result<T, E>` |
| `or_else(f)` | If `Err`, call closure `f` to return `Result` | `Result<T, E>` |
| `as_ref()` | Convert to immutable references | `Result<&T, &E>` |
| `as_mut()` | Convert to mutable references | `Result<&mut T, &mut E>` |
| `ok()` | Success value → `Some(value)`, error → `None` | `Option<T>` |
| `err()` | Error value → `Some(error)`, success → `None` | `Option<E>` |
| `expect(msg)` | Similar to `unwrap()`, but allows custom error message | `T` / `panic` |
| `?` | Return early when encountering `Err` (must be used in functions returning `Result`) | `T` / early return |

`Result` also has: `map(f)` and `?`, as well as useful `is_ok()` and `is_err()`

In `Result<T, E>`:

- `T` is the type of value returned on success (e.g., file content, calculation result, etc.).
- `E` is the type of value returned on error (e.g., `std::io::Error`, custom error `enum`, etc.).
- Actually:
    - `E` can be any type, with no restrictions
    - But to use `?`, facilitate debugging and printing, `E` usually needs to implement `Debug`, `Display`, `Error`, and other traits
    - Yes, `E` can be very complex types (carrying context, providing helper methods), or very simple error structures (like, a string). `Err` is just the shell that `Result` uses to mark "this is the error branch", with `E` inside

### Examples

```rust
// ===== Creating Option =====
let some_value: Option<i32> = Some(42);  // Has value
let none_value: Option<i32> = None;      // No value

// Common usage: returning from functions
fn find_number(flag: bool) -> Option<i32> {
    if flag { Some(7) } else { None }
}

// ===== Creating Result =====
let ok_value: Result<i32, String> = Ok(42);                    // Success
let err_value: Result<i32, String> = Err("Oops".to_string()); // Failure

// Common usage: returning from functions
fn divide(a: i32, b: i32) -> Result<i32, String> {
    if b == 0 {
        Err("Division by zero".to_string())
    } else {
        Ok(a / b)
    }
}
```

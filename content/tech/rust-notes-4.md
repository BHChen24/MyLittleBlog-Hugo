---
title: "Rust Notes 4"
date: 2026-09-10T11:19:00
description: "Range"
tags: ["rust"]
categories: ["Tech notes"]
---

## Range

Rather than using C style loop, in Rust, we use ..= to indicate a range:

```rust
for i in 1..=5 {
    println!("{}",i);
}
```

Output:

```rust
1
2
3
4
5
```

Sequences are only allowed for numeric or character types because they can be consecutive.

```rust
for i in 'a'..='z' {
    println!("{}",i);
}
```

### Char

Use `''` . `""` is for the string

```rust
fn main() {
    let c = 'z';
    let z = 'ℤ';
    let cat= '😻';
}
```

Accept `Unicode`, occupy 4 bytes.

### Bool

Only 1 byte.

```rust
fn main() {
    let t = true;
    let f: bool = false;
}
```

### Unit type

Literally, it is `()`.

Yes, the unit type is `()`, and the value of this type is also, and only `()`.

It's similar to `void` in other languages.

Sometimes, you may come across code like `Result<(), String>`. This is an example of **generic types** in Rust. If you're familiar with C++ generic types, you can figure out that we pass 2 types into the `Result`, regardless of what the `Result` actually is.

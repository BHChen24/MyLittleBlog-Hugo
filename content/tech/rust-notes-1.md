---
title: "Rust Notes 1"
date: 2026-09-10T11:14:00
description: "Hello world!"
tags: ["rust", "tutorial"]
categories: ["Tech notes"]
---

## About these notes

These Rust notes are just a collection of my learning records. Since I'm a beginner in Rust, these notes are more like quick references or supplements, rather than a comprehensive Rust tutorial. No matter what, I hope you can still find parts that are useful to you.

---

### Why rust？

Rust's advantages include memory safety, high performance, and high productivity. To me, Rust appears to be one of the best implementations of C++. If you don't get into deeper topics and only use prepared libraries, Rust's syntax is simple and clear. Its built-in compiler cautions are also quite informative, which significantly decreases the amount of thinking required on developers.

However, Rust has been criticized for being "too safe." If you want to dig deeper and truly utilize Rust, you'll have to deal with its complex and tedious safety mechanisms. A true dilemma exists: "Why not use the more flexible C++, or Python, which offers quicker speed in development and a more strong ecosystem?"

In my opinion, Rust is a "balanced" choice that addresses some shortcomings of mainstream languages. It is safer than C++ and performs better than Python. However, Rust has obvious drawbacks including an extremely high learning and development cost (which may be more difficult than learning C++). However, Rust is clearly a popular technology right now, and its ecosystem is rapidly expanding. Learning a challenging new language is never a terrible idea.

---

### Environment prep

1. Follow the instructions at [https://www.rust-lang.org/learn/get-started](https://www.rust-lang.org/learn/get-started) to install **Rust**.
2. Install VS Code.
3. Install the **rust-analyzer** extension in VS Code.
4. Well done! You’re now ready to write your first Rust program.

Use Google or AI tools to help you do these tasks, you will deal with Google and AI all the time when you’re learning something new.

---

### Hello world

1. In VS Code, open a new folder.
2. Press `Ctrl + `` to open a new terminal, or you can follow the top menu tabs: "Terminal" -> "New Terminal".
3. Enter `cargo new helloworld` to create a new project named `helloworld`.
    1. `cargo` is like the `pip` in Python; it manages packages (libraries) in Rust.
4. Go into the `src` folder, and you will find the `main.rs` file.
5. Enter `cargo run` in the terminal to directly run … oops! An error occurs.
    1. You need to first navigate into the `helloworld` directory because that’s the project’s working directory.
    2. Use `cd helloworld`, or open the folder again in VS Code, and then create a new terminal.
    3. Enter `cargo run`.
    4. Congratulations! You've run your first Rust program!

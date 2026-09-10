---
title: "OSD600 Lab 4"
date: 2026-09-10T11:33:00
description: "Git remotes and merges to collaborate"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> PR, code review and communication.

## Refelction

---

### **First, how did the code itself go?**

The Python project I worked with is clean and straightforward. It made me reconsider my tech stack: I may use Python as my primary prototyping language, and only turn to Go, Rust, or C++ when specific requirements demand it.

### **Did you run into any problems?**

Implementing the logic was simple, but writing tests was more difficult. Too many cases could be included!

### **How did you tackle the work?**

I looked up examples online and used some tools to inspire different test cases.

---

### **Second, how did it go using git?**

Since I’ve been using Git continuously in recent months, I didn’t face major technical issues. The only recurring problem was occasionally forgetting to create a new branch, etc.

### **Did you find any of it difficult? How did you get around this?**

There was a tricky issue: I directly worked on my forked main branch and mentioned the original issue in one of the commit, so, the issue pointed back to my commit on the main branch. It’s a little bit confused because for a new feature I should have a clearly named branch links to the issue.

Luckily, I could still use the correct branch for making the new PR, but the comments are still left in the issue… And I feel like it’s troublesome to change the recorded behavior on Github.

I haven’t found a perfect solution for human-caused fault yet, so I simply try to be more careful. Fortunately, Git and GitHub are well-designed, so there’s usually a way to recover mistakes.

---

### **What would you do differently next time? What did you learn from the experience?**

In this week’s lab, a couple of tests passed locally but failed on the maintainer’s machine, so weird. I later realized that the issue was due to a mismatch between my local and pushed code.

Through communication we resolved it, but next time I will double-check my final code version. I also learned that consistent CI/CD pipelines and active communication are essential for online code contributing.

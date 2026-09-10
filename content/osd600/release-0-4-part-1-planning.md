---
title: "OSD600 Release 0.4 Part 1 - Planning"
date: 2026-09-10T11:48:00
description: "Scheduling things out"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> Tough week, and it will get tougher

## Planning for the release 0.4

Last week, we wrapped up some final tasks for Release 0.3, and now I’m officially moving into the work for Release 0.4. I mentioned earlier that I was still waiting for my PR for Release 0.3 to be merged. Fortunately, right after the lecture, someone from Opsimate finally reviewed my changes and gave me feedback. The response time was a bit slow, but at least things are moving again.

The real issue, however, is the schedule. The end of the semester is approaching, and last week I was completely occupied with assignments from other courses. Because of that, I didn’t spend as much time exploring Release 0.4 as I had hoped.

The good news is that during Release 0.3, I had already identified a few projects I really wanted to contribute to: [My last post](https://www.parkerchenca.com/en/article/2aaf0ccf-d7f8-8015-91e1-e557e20be6b3). I also spent some time understanding their codebases, so I’m not starting from zero. I’ll talk about those projects below.

My plan is to clear out the most urgent schoolwork first, then fully commit myself to Release 0.4.

### [**Microsoft Qlib**](https://github.com/microsoft/qlib)

I already finished setting up the environment using `pyenv` and `uv`, which allows me to manage Python dependencies very cleanly. I also prepared the example dataset used in the project.

My next step is to go through the latest issues on their GitHub repo and see if there are any that interest me or are suitable for my skill level. Once I choose an issue, I can start analyzing the relevant parts of the code.

I don’t intend to fully understand the entire codebase, because Qlib is large and complex. Instead, I plan to learn the sections that are directly related to the issue I want to work on.

### [**Actual Budget**](https://github.com/actualbudget/actual)

When I was reading the code earlier, I actually found an approach for solving this issue: [**https://github.com/actualbudget/actual/issues/6149**](https://github.com/actualbudget/actual/issues/6149)

However, the problem mainly involves the UI, and the fix probably requires only around ten lines of code(In fact, the existing PR for this issue modifies fewer than 20 lines.) Because of that, I eventually decided not to work on this issue, since it feels too small for Release 0.3.

My next step is to continue exploring the parts of Actual Budget’s codebase that I already understand and look for issues that are more meaningful to contribute to.

One thing I realized while reading the code is that in a well‑designed project, adding a new feature—even a large one—doesn’t necessarily require changing many lines of code. The architecture handles most of the complexity. For an assignment, this might make the contribution look “too small on the surface,” but the real difficulty lies in reading and understanding the existing code.

### 🧳 Summary

In my current plan for Release 0.4, I expect to focus mainly on these two projects. The most difficult part for me right now isn’t the code itself, but managing my time during this extremely busy part of the semester.

I hope everyone in the course has a smooth development process, and I’ll try my best to push forward as well.

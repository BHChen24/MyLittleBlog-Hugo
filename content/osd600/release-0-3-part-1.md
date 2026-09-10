---
title: "OSD600 Release 0.3 Part 1"
date: 2026-09-10T11:44:00
description: "Houston, we have a problem."
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> I have a bad feeling about this: once again, I find myself stuck trying to choose the right project.

## Main Content

### Still WIP

At the end of this week, I haven’t submitted my first PR yet. Most of my time went into searching for a suitable open‑source project, and my plan is to update this post again after I finally publish my first PR.

Since I previously mentioned that I want to contribute to a repo related to **$*finance*$**🤑, I spent a good amount of time exploring that topic. Here are some projects currently on my list:

### AI-powered investment platform

**Microsoft Qlib** ([**https://github.com/microsoft/qlib**](https://github.com/microsoft/qlib))

**Qlib** describes itself as “an AI‑oriented quantitative investment platform,” but in simpler words, it’s a framework that provides data tools, modeling support, and workflow automation to help build AI‑driven quantitative trading strategies.

- I’m personally very interested in this project and have already started exploring it. The development activity is not bad — issues and PRs are still being handled as recently as this week.
- It uses Python, has plenty of issues to choose from, focuses on a hot topic (AI), and the documentation is fairly complete.
- But…I spent an entire afternoon debugging my Python environment. Absolutely terrifying.

### Open‑source banking system

**Apache Fineract** ([**https://github.com/apache/fineract**](https://github.com/apache/fineract))

- This is an open‑source banking system written in Java. I feel that its tech stack aligns well with what employers in the industry expect. If I can learn its design principles and make meaningful contributions, it could be very helpful for my future job search.
- However, the repo doesn’t have a typical Issues section, and its contribution rules seem quite different. I might need extra time to figure out how to get started.
- Still, this is the project I’m currently most interested in.

### Personal-finance app

**Actual Budget** ([**https://github.com/actualbudget/actual**](https://github.com/actualbudget/actual))

- This personal finance platform is super active: around 30 PRs were handled within just a week, and it has around 23k stars. Clearly a very popular project.
- It mainly uses TypeScript and focuses on “practical frontend” features. The demo isn’t such fancy, but the features look solid and well‑built.
- It doesn’t feel “technically fancy” or groundbreaking, but it solves real problems — exactly the type of project I care about and would like to contribute to.

### 🧳 Summary

Overall, I’m still in the process of selecting the right project and diving into the code, but I’m getting closer. Hopefully I can finally report back with my first PR on weekend.

### Updates

Over the past several days, a few things happened that changed the direction of my work.

1. At first, I planned to continue exploring Qlib. However, when I tried to set up the environment, **`uv`** and **`pyenv`** ended up conflicting with each other again.
2. I spent additional time rebuilding a clean environment, but unexpectedly, Python packages started throwing compilation errors—some of them simply refused to build.
3. At that point, I felt I had already invested too much time just dealing with environment issues. So I decided to switch back to a project I’m more familiar with: **OpsiMate** ([**https://github.com/OpsiMate/OpsiMate**](https://github.com/OpsiMate/OpsiMate) ), which I worked on during release 0.2.
4. While reviewing feature requests, I found an issue that has not been implemented yet: [**https://github.com/OpsiMate/OpsiMate/issues/94**](https://github.com/OpsiMate/OpsiMate/issues/94) . It’s new, has reference implementations, and involves a reasonable amount of work. It felt like the right fit, so I decided to focus my efforts on contributing to OpsiMate.

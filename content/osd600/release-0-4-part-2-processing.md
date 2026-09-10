---
title: "OSD600 Release 0.4 Part 2 - Processing"
date: 2026-09-10T11:49:00
description: "Pushing things forward"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> Me working with a big project… Wait, me?

## Starting the Contribution

---

This week I finally moved from planning into actually contributing. I decided to work on **Actual Budget** again, and honestly, I was kinda nervous because this repository has 23.6k stars, real users, and an active core team.

I chose a TypeScript issue related to incompatible type definitions

([https://github.com/actualbudget/actual/issues/6290](https://github.com/actualbudget/actual/issues/6290)).

In short, the `Query` type was missing a few methods and caused type errors inside the API package.

My PR is small and touches only a few lines of code (PR: [https://github.com/actualbudget/actual/pull/6331](https://github.com/actualbudget/actual/pull/6331)). The challenge was not writing the code only, but understanding what the project expected from contributors.

### Understanding the Project and the Rules

---

Before writing anything, I spent most of my time reading the project structure and the Contributing guide. Actual Budget has an entire website explaining how to participate:

[https://actualbudget.org/docs/contributing/](https://actualbudget.org/docs/contributing/)

Compared to our previous workflows, the overall process is similar — fork repo, create branch, implement change, send PR. However, the attitude and expectations are much more formal.

The contributing guide explains:

- development workflow
- expectations for PR quality
- how reviews work
- and, very directly, that not every PR will be accepted

> “We aren’t going to take every single little change. Don’t be offended if we close your PR…”
>

So even for a small fix like mine, discussion might still be required, and reviewers could ask for adjustments. It’s more serious, but also very professional.

In addition, I got in touch with `yarn` in this project, and the project has a set of commands to generate a release note instead of describing PR on GitHub.

### The PR Experience

---

After pushing my code, I first marked it with `[WIP]`. Soon after, Copilot automatically reviewed the PR and suggested writing tests. That’s kind of strange because when I checked the file, I found there were no dedicated tests at all for that file, so I asked the question directly inside the discussion and waited for a reviewer to reply.

When I removed `[WIP]`, another automated reviewer (coderabbitai) appeared, plus almost 30 checks waiting to finish. Seeing that number made me feel how large and complex this project really is.

So far, the review and discussion are still ongoing.

### Final Thoughts

---

Even though this PR is small, the experience means huge for me. I got to know about how large open-source projects manage quality and how serious review standards can be.

I also feel more confident contributing to large projects now. I’m planning to share more details and personal reflections during Friday’s meeting, and hopefully continue contributing after Release 0.4.

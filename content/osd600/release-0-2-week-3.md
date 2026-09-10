---
title: "OSD600 Release 0.2 Week 3"
date: 2026-09-10T11:37:00
description: "The third PR. Be a part of the project."
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> I am one part of a group of a hundred developers?!

## In release 0.2 week 3…

---

### **What I did**

This week I participated in the project that was recommended by my classmates: [**OpsiMate**](https://github.com/OpsiMate/OpsiMate); it's truly an active open-source project—once I commented on an issue, there was a contributor to reply to me in time.

I also joined their slack channel and found they even have short but regular reports for community growth, which makes me really feel like I am a part of the project.

---

### **Working on (issue/PR)**

The issue I worked on is: [https://github.com/OpsiMate/OpsiMate/issues/517](https://github.com/OpsiMate/OpsiMate/issues/517) and this is the related PR for it: [https://github.com/OpsiMate/OpsiMate/pull/521](https://github.com/OpsiMate/OpsiMate/pull/521)

This issue is about adjusting the project’s linting and formatting configurations. Before, there were several config files in different folders, such as the app server folder, the client folder, and the shared package folder. So one of the main contributors wants to create unified base configs for both the linter and the formatter in order to manage them in a standardized way.

---

### **Need to know**

After analyzing the codebase, I realized that the project is mainly using `eslint.config.js/mjs` and `.prettierrc` as the configuration files. S
the first thing I need to figure out is how prettier and eslint reads their configs from specific files.

And, obviously, `.prettierrc` doesn’t support importing or exporting, so I need to find a way to transit config objects within config files.

---

### **Difficulties**

It’s not so hard to find the online resources and apply them to create a new base config file that is accepted by prettier. But the eslint configs seem to be more complex.

Furthermore, once the eslint configuration is broken, it will spread out to subdomains and eventually lead to a failed CI/CD workflow (I made one mistake and then there were a huge number of red error messages that freaked me out). So I need to take it more carefully and frequently ask for help.

---

### **Fixes**

To be honest, the fixings are not so special or awesome; I basically just followed online instructions plus a little bit of my personal experience to accomplish this issue. If I made a mistake, the local IDE tools like SonarQube, eslint and prettier plugin would correct me before making changes; besides, this project applied the CodeRabbitAI for GitHub PR reviewing. I got a lot of useful suggestions for improving my bug-fixing code. Everything just looks like it's running smoothly and under control.

---

### **Considerations**

There are a few interesting thoughts I want to mention here but, I don’t know if I should write some super long paragraphs for each of those 😂, so I decide to list them below as bullet points:

- Technically speaking, this is my first time participating in a project that has a public developing community; my first PR was made for my friend, and my second PR was made for a hacktoberfest-specific project (I think. But it still is a fun project!). So I am very exciting for this week’s work.
- Eslint9 doesn't support `extend` syntax anymore, but my work was based on a previous version, so I did pay for it with some useless effort. Thankfully I noticed this problem from the code reviewer. Should take more care about the version of developing tools next time.
- Slack seems super useful for communication. It also likes the discord… Maybe I should take some time to learn about it.
- Do not feel afraid of following up on the work. Eventually we should push the process somehow.

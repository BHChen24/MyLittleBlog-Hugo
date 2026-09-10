---
title: "OSD600 Release 0.2 recap"
date: 2026-09-10T11:41:00
description: "Everything you did in October"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> Journey of open-source contribution

## In October, in Hacktoberfest…

### **What I did**

---

At first, I helped my friend build **his open-source project**. I introduced him to Hacktoberfest and added issue and PR templates to his project to make it easier for more people to contribute. Project link: [**https://github.com/TemaDeveloper/library_proj**](https://github.com/TemaDeveloper/library_proj)

Then, I found a fun “**cat card battle**” project on GitHub. I joined it just because it looked interesting - and I love cat pictures. I also noticed that it is a new project created for Hacktoberfest, not too hard, but still meaningful (Not just “add yourself to the Contributors.md”). I contributed code to help the project fetch cat images correctly. Project link: [**https://github.com/JessieVela/cat-card-battle**](https://github.com/JessieVela/cat-card-battle)

My next two PRs were for the **OpsiMate** project. This project has about 200 stars with a very active open-source community. They even use Slack to make announcements regularly. The reason why I choose this project is after working on two smaller projects, I wanted to join a bigger one that needed more communication and coordination - and OpsiMate was a good match. I unified their `eslint` and `prettier` config files, and also helped write some tests. Project link: [**https://github.com/OpsiMate/OpsiMate**](https://github.com/OpsiMate/OpsiMate)

### how I've progressed

---

The beginning was difficult. Honestly, the assignment really pushed me to start - because I needed to complete something for the marks. But once I made the first try, I realized most problems were not as hard as I thought.

The hardest part for me was **finding the right issues**. The hacktoberfest tag and my classmates’ sharing on Teams helped a lot. I also learned a lot about GitHub search. Here's a document I often used and recommend to others:

[**https://docs.github.com/en/search-github/github-code-search/understanding-github-code-search-syntax**](https://docs.github.com/en/search-github/github-code-search/understanding-github-code-search-syntax)

Then came **reading and understanding code** - or more exactly, understanding the whole structure of a repository. Usually, a repo has many tools like ESLint, pnpm, biome, etc. These tools may not be part of the main logic, but if they are not configured correctly, the project cannot even run, and there is no way to develop and test the project. I once tried a project that I couldn’t make run locally, and I finally had to give up: [**https://github.com/BHChen24/flexprice](https://github.com/BHChen24/flexprice)** (If you are interested, you can give it a try.)

Another important part is using **soft skills**, like time management and communication. Good **time management** is important. our professor has told us many times not to push all PRs at the last minute. I tried to make a detailed schedule with flexible options. For example, one week I was sick and couldn’t finish my PR by Friday, but I finished it during the weekend. That was the “acceptable case” in my plan. I also had other priority levels and fallback plans, such as contacting the professor if needed. In longer projects, unexpected things can always happen, so it’s important to track progress and prepare alternatives.

About **communication** - I noticed many open-source contributors communicate in a very casual way. Maybe that’s a community habit. But some comments like “Hey, give me the issue” feel a bit rude to me. I saw that some people spoke like that and then received no reply 😂. So  I try to be polite and neutral, and keep my messages short. Being too formal can also confuse others, I think.

I also learned that timely **follow-up** is important, because not everyone is a full-time open-source developer. For example, when I was debugging in the cat card project, the author only replied after I mentioned them - so if I had stayed silent, nothing would have moved forward.

### What I learned

---

I think my biggest improvement is getting to know **how to read code** in a better way. Now, when I start working on a project, I know exactly what to check first: read the **`README.md`**, look at the repository’s insights ****tab, read the **`CONTRIBUTE.md`** file, etc. I also learned how to use good tools when reading code — I always search first, and then use “go to definition/references” to jump precisely to related code. I scroll much less with my mouse now.

I also became more confident using **Git**. I use Git often in assignments and at my internship, and I’ve learned some useful details. For example, if I publish a branch first and then rebase, the history becomes very messy like spaghetti - and everyone can see it. But if I don’t publish before rebasing, the worst thing is just a local conflict, which I can solve privately. Then when I publish, the history looks clean and is easier for reviewers to follow.

I also gained inspiration on how to build reliable projects by reading **clean repositories**, like this one: [**https://github.com/yamadashy/repomix/**](https://github.com/yamadashy/repomix/)

Another repo I liked is [**https://github.com/juspay/hyperswitch**](https://github.com/juspay/hyperswitch) . I didn’t have a chance to contribute yet, but it’s a great example of how to build a financial project in Rust, a direction I’m very interested in. I’ll keep following it.

### **Considerations**

---

I think I made some progress during Hacktoberfest, but this is still just the beginning.

I had planned to contribute to larger projects (with maybe over 2k stars), but due to time, strange build errors, and some unexpected competition, I chose a safer way to meet the requirements of the course first. Still, I really want to contribute to big projects. Some of my classmates have already done that, and after this round of Hacktoberfest, I finally feel confident enough to try it too in the future.

By the way… seeing my avatar appear in the Contributors list makes me feel kind of proud.

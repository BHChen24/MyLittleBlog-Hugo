---
title: "OSD600 Release 0.2 Week 4"
date: 2026-09-10T11:40:00
description: "Last PR for the release 0.2"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> We ****need to be tested for sure

## In release 0.2 week 4…

---

### **What I did**

This week I contributed in another issue in the project [**OpsiMate**](https://github.com/OpsiMate/OpsiMate), - the same one I contributed to last week.

My main task was to add test cases for one of the APIs.

---

### **Working on (issue/PR)**

Here’s the issue I picked up: [https://github.com/OpsiMate/OpsiMate/issues/371](https://github.com/OpsiMate/OpsiMate/issues/371)

And here’s my pull request:  [https://github.com/OpsiMate/OpsiMate/pull/537](https://github.com/OpsiMate/OpsiMate/pull/537)

This issue was a bit of a “legacy” one. Someone had tried working on it before, but their PR was rejected. Another contributor also took it but later unassigned themselves.

When I saw it sitting there for a while, I thought “Why not give it a try?” So I volunteered to take it on. Right now, both the issue and my PR are still waiting for review.

---

### **Need to know**

The issue focused on writing tests using the `Supertest` framework, which is quite similar to `Vitest`. By looking at existing tests in the project, I quickly figured out how to use it.

It was also very helpful to check some closed issues and PRs - there are lots of good examples there.

---

### **Difficulties & Fixes**

While testing, I actually found a few bugs in the original API code.

It seems the API didn’t have proper `try-catch` logic, so it couldn’t return the correct response status. Because of that, I had to mention this problem in my PR - basically saying, “Hey, this API might have a bug. It should be fixed before we can finalize the tests.”

I submitted a draft PR temporarily. The maintainers might ask me to fix the bug as well, or maybe just provide more guidance on the tests. Either way, I just need to wait for the review.

---

### **Considerations**

I’ve seen some test code that doesn’t really “test” anything - it just exists to make the tests pass.

With AI tools becoming more common in development, this problem might get even more serious: AI can help you generate tests quickly, but those tests might only aim to pass instead of really verifying quality (especially when you tell the AI, “Hey, this code doesn’t work!”).

In my experience, my tests did help me discover real issues and hidden bugs, which shows how valuable testing can be - even if it’s sometimes tedious.

Combining AI-assisted coding with good testing practices is definitely an interesting topic worth exploring in the future.

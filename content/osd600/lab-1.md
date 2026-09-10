---
title: "OSD600 Lab 1"
date: 2026-09-10T11:29:00
description: "Blog about the process and outcomes for Lab 1"
categories: ["OSD600"]
---

> 🔔 **Prelude:
> Doing cool things with classmates**

- How did you go about doing your code reviews? Do you prefer an async or sync approach? Why?

I prefer the async approach to doing the code reviews; it gives me a flexible schedule to handle my work and life. And I feel relaxed when I need to read something alone.

- What was it like testing and reviewing someone else's code? Did you run into any problems? Did anything surprise you?

Just like learning new concepts! I may know about the programming language, but the ideas from others are always new and valuable to me. I sometimes could not understand the meaning of others’ code, but thankfully, except for directly asking them, we can also leverage AI in these days.

- What was it like having someone test and review your code? Were you surprised by anything?

It's just like being judged … but I considered it a little bit; in an open-source community, being reviewed by someone is for making the product better, and then I got relief with this thought. The collaborators always surprise me by discovering new bugs and applying new tests in a way that I never thought of before!

- What kind of issues came up in your testing and review? Discuss a few of them in detail.

Well, for example, I got stuck in the middle when I tried to write tests for a C++ project (although I found that I don’t need to actually write them for this lab in the end). It doesn’t mean I don’t know about C++, but I need time to remind myself of how to write tests in C++ because it has been a while since I used C++ to build something. I have to search online for how to write the tests properly and look for examples. When I face some unfamiliar frameworks, testing and review take time.

- Provide links to issues you filed, and summarize what you found

[https://github.com/ElshadHu/RepositoryContextManager/issues/3](https://github.com/ElshadHu/RepositoryContextManager/issues/3)

This is a tricky one because I am not so familiar with CMakefile. When I tried to build the project the system kept showing errors, I had no idea at that time. But I finally found that it was triggered by the hardcoded PATH setting when I truly dove into the file. I want to tell myself, “If you want to fix a bug, don’t just stare at the error prompts, you have to dive into the file!”

All issues I filed should be under the same issues page; here is another repo I filed issues for: [https://github.com/RiverDave/rust-cli-tool/issues](https://github.com/RiverDave/rust-cli-tool/issues)

- Provide links to issues that were filed on your repo, and what they were about

[https://github.com/BHChen24/repo2context/issues/1](https://github.com/BHChen24/repo2context/issues/1)

And all other issues are under the “issues” page.

I noticed I included a configuration management tool in my project but since I haven’t used it, I didn’t write any comment or mention it in my “README.md”, and this did cause some confusion. Thanks a lot David!

- Were you able to fix all your issues? What was that like?

[https://github.com/BHChen24/repo2context/issues/4](https://github.com/BHChen24/repo2context/issues/4)

For documentation issues, I can, but for some feature requirements and tricky bugs I cannot yet. Actually, I fixed the markdown file syntax error immediately: the embedding link `[https://go.dev/](GO)` should be like `[Go](https://go.dev/)` .(And this is the first time I asked copilot to review my code for the PR, wow!)

- What did you learn through the process of doing the testing and reviewing?

It’s definitely a necessary process for improving our products. The key point here is barely anyone can accomplish a high-quality project by working totally alone. In ancient China there is an idiom: “When everybody adds fuel, the flames rise high,” which means, “Great things can be achieved by mass effort.” This is a wonderful description of the meaning of testing and reviewing in the open-source community.

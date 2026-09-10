---
title: "OSD600 Lab 2"
date: 2026-09-10T11:30:00
description: "Contributing and submitting Pull Requests"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> About the process of contributing a code change to another project

## 🖋️ Main Content

The project repo: [https://github.com/RiverDave/rust-cli-tool](https://github.com/RiverDave/rust-cli-tool)

Your issue: [https://github.com/RiverDave/rust-cli-tool/issues/27](https://github.com/RiverDave/rust-cli-tool/issues/27)

Your pull request: [https://github.com/RiverDave/rust-cli-tool/pull/28](https://github.com/RiverDave/rust-cli-tool/pull/28)

### 1. What I did

Briefly speaking, I did:

- First take a look at the whole project to see the current situation
- Check if the “recent file” feature has been implemented
- Analyze code base to see how to add custom commands
- Search online for obtaining file metadata in certain language
- Raise issue, fork repo, switch branch, develop logics
- Test my code
- Update documentation
- Create PR
- Communicate with repo owner
- Close issue
- Write blog

#### 1.1 The changes I made for my feature

- I found the rust project used `clap` — a famous and solid **Command Line Argument Parser for Rust**.
- Thanks for that, I have a very clear pattern to follow then create a new command for the application:

    ```rust
    #[arg(long = "recent")]
    pub recent: bool,
    ```

    As simple as it looks like!

- Then, I extended the `Config` struct to include a `recent_only` field, which controls whether to filter for recent files.
- Next, I create useful logics in the `file.rs`. The main filtering logic checks if files were modified within the last 7 days — if a file is older than 7 days, it gets skipped.

#### 1.2 The process of getting your work accepted

- First, review the codebase and existing issues to make sure I understand the basics of the project and avoid raising a duplicate issue.
- Then, communicate with the repo owner — by Teams, by issue, by email, or whatever I like (but also must check the comfortable way for the owner first), to say, “hi, can I add a feature to your project, because…” The core of this is to “let them know.”
- During the coding process, we’ll mainly communicate by the issue. I code, they give feedback, I change my code until we are all good for the issue.

### 2. Technical aspects

#### 2.1 How did file timestamps work in the language you were working with?

> [https://doc.rust-lang.org/std/fs/struct.Metadata.html#method.modified](https://doc.rust-lang.org/std/fs/struct.Metadata.html#method.modified)
>

According to this file metadata documentation, we have a lot of tools for obtaining info of a file, including the timestamps for the last modified time. Noticed that this method may “**not be available on all platforms**” so I added some error-handling code to it.

Next, we should also obtain the current system time ([https://doc.rust-lang.org/std/time/struct.SystemTime.html#method.now](https://doc.rust-lang.org/std/time/struct.SystemTime.html#method.now)), minus 7 days, then compare these two variables. If the file wasn’t touched in 7 days, it is not a “recent” file.

#### 2.2 What challenges did you face integrating with the existing codebase?

I think there is one main challenge I want to mention: It takes time to understand the project.

I had to trace through the code to see how `clap` handles commands. Well… Actually I noticed soon that if I follow the coding pattern in the repo then I should be OK to write the new code. Fully understanding the `clap` is a hard task itself.

And I also need to figure out how the `Config` struct flows through the application (The really important task) and where the file processing logic lives in `file.rs`. Reading other people's code is always slower than writing your own, plus you have to spend a lot of time researching the language that you are not so familiar with.

#### 2.3 In addition…

In the process of collaboration, I do have a question I really want to ask: Should I use AI tools to quickly understand other people’s open-source projects?

Theoretically, feeding an open-source project into an AI shouldn’t pose security or legal issues, because it’s “open-source”; but, the AI technology is still so new (and the legal issues are always tricky) that no one really knows what the hidden costs might be. Even if I let the AI summarize someone else’s project, who can tell if its summary is reliable?

On the other hand, if I try to research and interpret things completely on my own, there’s still a high chance that I’ll make human mistakes. So, whether or not to use AI tools ends up becoming more of a “trade-off” decision to me…

#### 2.4 How did you handle edge cases?

There was an interesting thing I want to mention in testing. So when I implemented my feature and first tested it, I found that the app would output all the files in the target folder, which made me confused. But later I noticed that because:

1. The target folder for testing is one of this project's folders.
2. When I use `git clone` to clone the repo to a local place, it also means that I “modified” all the local files in the folder.

So, the “recent” feature will not filter anything out because all the files are “recently” edited. I think this case can be considered an edge case.

My solution is to manually create a `recent_test_files` folder that contains some old files and some new files, then test the feature on them. This leads to a correct test result and also prevents the application from reading too many unnecessary files at once.

### 3. If your repo received a pull request…

Haven’t got a PR yet. 😶‍🌫️

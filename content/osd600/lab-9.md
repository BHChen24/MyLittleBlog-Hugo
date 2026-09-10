---
title: "OSD600 Lab 9"
date: 2026-09-10T11:47:00
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> Rocket lift off

## Answering Main Lab Questions

Originally I had a **reflection** section for this blog, but my Professor provides some wonderful questions for me to share my experience and thoughts, so, my reflection has been melted into my answers. I hope you can find useful information directly in there.

- **Which release tool and package registry did you choose? Provide links to everything you mention.**
    - Go has it’s unique release system — basically, if I init my module locally, push to the GitHub, have a right git tag version, and finally click the “Request” on [`https://pkg.go.dev/example.com/my/module`](https://pkg.go.dev/example.com/my/module) … then, done, I don’t need to handle rest things, the module will be indexed on the official module platform, and anyone should be able to `go install` my module. So convenience.

- **What was the process for creating a release? Be detailed so that other developers could read your blog and get some idea how to do the same.**
    - Ok, assume that you already have a “ready-to-go” codebase (you cannot release empty folder)
    - Then, you should use `git tag` related commands for tagging you current commit (Use `git tag --help` for help)
    - Next, you should push your commit to GitHub, maybe you have already done that, so, you should **push your tag** separately to GitHub
    - Don’t forget to change your documentation… I used to notice that my release still shows **v0.0.1** for the version flag, which means I have to repeat my work again (depressedly).
    - Finally, you can release your package. I used **Go**, and put some useful links in the **Reference** section. If you are also using GO, them can help you make your way.

- **What did you learn while doing your release? Did you have any "aha!" moments or get stuck?**
    - A lot of “aha!” moments, actually.
    - Go’s release workflow feels almost suspiciously simple—so simple that sometimes I overthought things.
    - The biggest challenge wasn’t complexity but the danger of skipping steps because the process looked too easy.
    - You can find more of my “aha!” moments in the detailed experience I describe below.

- **How much did you have to alter your code, files, build, etc. to use the chosen package format and registry?**
    - I didn’t need to change my code structure at all (But actually, I still need to change the documents).
    - Go’s build system is easy, clean and straightforward. I think this is one of the reasons many developers love Go — compared to languages like C++, incremental builds and direct code fetching “just work.” (Disclaimer: I also really like C++.)
    - One thing to be careful about is that git tags **must** follow the **`vX.X.X`** format, such as **`v1.0.1`**. Otherwise, the Go package platform may fail to recognize the version or cause unexpected issues.

- **How did the User Testing session with your partner go? Describe what it was like, where they got stuck, and how you corrected the problems.**
    - Before the session, I tested installation myself on my Raspberry Pi.
    - Interestingly, because my package URL is **`https://pkg.go.dev/github.com/BHChen24/repo2context`**, the default installed binary is named **`repo2context`**, not the short alias **`r2c`** that I used throughout my documentation.
    - This confused both me at first — I couldn’t find the installed executable because I was searching for **`r2c`**.
    - To avoid further confusion, I updated my **README** to explicitly mention this and show how to rename the binary if users prefer a shorter command.
    - Still waiting for feedbacks from my partners

- **How do users install and use your project now that it has been released? Provide links and some instructions.**
    - I have provided full installation instructions in my README:

    ```markdown
    ## Installation

    ### Prerequisites

    - [Go](https://go.dev/) installed on your system

    ### Quick Install

    ```bash
    go install github.com/BHChen24/repo2context@latest
    ```

    This installs the binary as `repo2context` to your `$GOPATH/bin` (or `$HOME/go/bin` by default).

    **Add Go bin to PATH** (if not already configured):

    Linux/macOS:
    ```bash
    # For bash
    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc && source ~/.bashrc

    # For zsh
    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.zshrc && source ~/.zshrc
    ```

    Windows (PowerShell as Administrator):
    ```powershell
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:USERPROFILE\go\bin", "User")
    ```
    Then restart your terminal.

    ```bash
    # Verify installation
    repo2context --version

    # (Optional) Rename to shorter command
    mv ~/go/bin/repo2context ~/go/bin/r2c
    ```
    ```

    I found once my app is released on the go pkg platform, all these instructions also appear on the home page, which is really cool and convenient. I put it again here for you to quickly navigate: [https://pkg.go.dev/github.com/BHChen24/repo2context](https://pkg.go.dev/github.com/BHChen24/repo2context)

### **References**

- [https://pkg.go.dev/about#adding-a-package](https://pkg.go.dev/about#adding-a-package)
- [https://semver.org/](https://semver.org/)

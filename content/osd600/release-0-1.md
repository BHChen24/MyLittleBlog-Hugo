---
title: "OSD600 Release 0.1"
date: 2026-09-10T11:31:00
description: "Building a Repository Context Packager command-line tool"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> This is my first step into building an open‑source style CLI tool in Go.

## Release 0.1

### Project Description

For this assignment, I built a “Repository Context Packager” tool named **repo2context**, which can scan a local git repository and generate a single, well-structured text file with repository information optimized for sending to LLMs such as ChatGPT and Gemini.

### Technology Choice

- **Language**: Go (Golang)
- **Output format**: Markdown
- **Why Go?**: Although many people are talking about Go’s advantages all the time, my main reason to do this was simply that I wanted to challenge myself.

### Implemented Features

#### Required Features

- Basic CLI interface with `--help` and `--version`
- Repository/file analysis
- Path tree structure
- Git commit/branch metadata
- Summary statistics (file count, lines of code)
- Standard streams (stdout for output, stderr for errors)
- Error handling

#### Optional Features Implemented

1. **Gitignore Integration**
    - The tool automatically excludes files and directories listed in `.gitignore`.
    - Provide a `--no-gitignore` to disable `.gitignore` filtering
2. **Output to File** (`-o` / `--output`)
    - Users can save the formatted repository context into a file (markdown text).
    - Example:

        ```bash
        toolname . --output context.md
        # usually the toolname is "r2c" but can be built as other names
        ```

### Development Experience

#### Process

1. Set up GitHub repository
2. Implement CLI argument parsing in Go (with `cobra` package)
3. Add recursive directory/file reading; Implement project structure tree displaying; tests…
4. Extract Git info (`os/exec` to run git commands and parse metadata)
5. Get data together and format output
6. Implement the two optional features: .gitignore handling + output to file
7. Also invite classmates to file issues

#### Challenges

- **Git env:** Needed to handle different situations like Git may not be available or the repo may not be initialized. (To be honest, I found this type of check should be applied to basically everywhere, and that’s a bit painful handling errors in Go..)
- **Starting from scratch:** This was my first time writing a full CLI tool in Go, so I had to set up everything from zero — project structure, flags, Git integration, error handling, etc. (Have to do a lot of research)

#### Learnings

- Learned how to build a demo project from 0 to 0.1 in Go.
- Gained experience reading Git metadata and filtering files dynamically.
- Deepened understanding of how to do file system traversal, file I/O and error handling in Go.

### Summary

- Implemented **all required features**
- Completed **2 optional features**
- A not bad foundation for future extensions
- Good start for practicing open-source contribution process

### Links

- **GitHub Repository**: [https://github.com/BHChen24/repo2context/](https://github.com/BHChen24/repo2context/)

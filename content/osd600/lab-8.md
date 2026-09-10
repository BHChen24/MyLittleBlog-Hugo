---
title: "OSD600 Lab 8"
date: 2026-09-10T11:43:00
description: "CI, linters, and testing"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> Another helpful hand, and more

## Main Content

This week I worked on GtHub Actions CI for my Go project, added a Go linter, and wrote tests for a partner’s repository. The lab overlapped with my Cloud Computing (CCP) course, so the CI work fit well with what I’m learning there.

Reflections

- I’m also taking CCP, so CI-related tasks felt practical.
- I had already added CI in a previous lab (I thought “why not?” while I was adding tests), so I extended that work here.
- Adding a Go linter was new to me (I know the eslint), but following the `golangci-lint` repo made it straightforward.

### Answering questions

#### How did you set up your GitHub Actions CI Workflow? What did the YAML for this workflow look like?

I searched “How can I set up my GitHub Actions CI Workflow?”, as just same as the question title. Then, I found a Go workflow templates by clicking the action button in GitHub. The workflow builds and tests on push and pull requests to **`main`** and **`dev`**. Super straightforward again.

Template YAML:

```yaml
name: Go
on:
  push:
    branches: [ "main", "dev" ]
  pull_request:
    branches: [ "main", "dev" ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Set up Go
      uses: actions/setup-go@v4
      with:
        go-version: '1.25.1'
    - name: Build
      run: go build -v ./...
    - name: Test
      run: go test -v ./...
```

#### How did your partner's repo and testing setup differ from yours? What was it like writing tests for a project you didn't create?

---

My partner’s repo did not initially have CI now(I will check again later). They did provide example tests, which helped me a lot. Writing tests for someone else feels just like writing a feature, but you must understand more about the intended behavior before you can test it well.

#### What do you think of CI now that you've set it up for yourself?

- CI acts as an automatic safety layer — it finds flaws before the changes are really applied to the main (or other danger zone).
- It saves manual steps: every push triggers the same checks.
- CI is also flexible: you can configure testing closer to the real deployment environment, which local runs can’t always match.

#### If you did the optional challenges, talk about how that went and what you learned.

I added **`golangci-lint`** via GitHub Action (the repo/documentation has a ready template). Check their repo and instruction: [https://github.com/golangci/golangci-lint-action](https://github.com/golangci/golangci-lint-action)

I was surprised when I found they actually have provided “ready-to-use” config lines that allow me to copy and paste and then run everything correctly.

Lesson: read official docs and search the marketplace before creating the wheel — many reusable actions already exist.

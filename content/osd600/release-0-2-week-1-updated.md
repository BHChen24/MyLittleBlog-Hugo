---
title: "OSD600 Release 0.2 Week 1 (Updated)"
date: 2026-09-10T11:34:00
description: "First step in Hacktoberfest"
categories: ["OSD600"]
---

> 🔔 **Prelude:**
> *Everything's hard in the beginning*

## In release 0.2 week 1…

### **What I did**

This week I mainly focused on searching for suitable open source projects to contribute to. I haven’t started submitting any pull requests yet, but I did managed to create an issue (see link below) and am waiting for it to be assigned.

[https://github.com/TemaDeveloper/library_proj/issues/17](https://github.com/TemaDeveloper/library_proj/issues/17)

### **Working on (issue/PR)**

I opened an issue about setting up **issue templates** for a repository. Although I think it was a simple one, it still was my first time dealing with this topic, so I referred to the official GitHub documentation. I surprisingly learned that using a **`.yml`** file for the issue template allows better formatting and a cleaner layout for users filling in issue forms than the `.md` template.

The process has been updated; please have a check on the "Updated" section in this post

### **Need to know**

Still waiting for feedback or assignment on my issue. Once that’s done, I plan to contribute my first PR to this project or one of the other candidates I’ve found.

### **Difficulties**

The main challenge this week was **finding the right project** to start with. Some repositories are attractive and popular but have too many contributors already. It’s so hard to find available “good first issues.” in those repos.

### **Fixes**

After rewatching a previously recorded lecture, I realized I had overlooked GitHub’s **advanced search** feature. By also researching on the GitHub official documentation, I improved my efficiency in locating suitable issues by using `no:assignee`, etc. I’ve already starred several projects for upcoming work.

### **Considerations**

Some classmates shared potential projects on our team channel, and I found that exchanging ideas and experiences is really helpful. I believe active communication and collaboration will be key to achieving our release goals.

### Updated

I have added templates to the repo and The PR has been merged.

[https://github.com/TemaDeveloper/library_proj/pull/18](https://github.com/TemaDeveloper/library_proj/pull/18)

Here are some things I want to share:

1. Even though this PR is simple, it is somehow a little bit tricky. Because the templates will not be applied until the PR has been merged into the main repo (Github needs to read them), I have to create a new test repository in my account to test the templates.
2. And, this testing procedure did cause a bug: I mistakenly placed the templates in `.github/workflow/ISSUE_TEMPLATES` instead of the correct path `.github/ISSUE_TEMPLATES` in the original repo. However, in my separated test repo, the path is correct so that it didn't reflect any issue.
3. So after noticing the PR has been merged and the bug appeared, I still need to communicate with the owner to let him know I will create a new PR to fix the minor bug ([https://github.com/TemaDeveloper/library_proj/pull/19](https://github.com/TemaDeveloper/library_proj/pull/19)). This cost extra time.

This little issue got me thinking about how to handle PRs whose results only show after merging... I’d like to explore this topic further.

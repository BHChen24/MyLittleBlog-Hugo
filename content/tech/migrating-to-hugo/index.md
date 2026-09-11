---
title: "Migrating to Hugo"
date: 2026-09-10T13:00:00
description: "Why NotionNext had to go, and few problems Hugo handed me on the way in."
tags: ["hugo", "notionnext", "migration", "vercel"]
categories: ["tech"]
---

I moved my blog to Hugo. I've had some free time in the gap between
graduating and landing a job, so I finally got around to something I'd been
putting off for a while.

## Why migrate at all

A few things pushed me toward it. A couple of years into the Computer
Programming and Analysis program, I'd seen enough tools and tradeoffs that
"run a lighter stack" stopped being an abstract idea and turned into an
actual plan. [NotionNext](https://github.com/notionnext-org/NotionNext) is a
good project. I'll get into why it stopped working for me, but it's more machinery than a
personal blog needs.

I'd also run out of excuses not to touch it. One of my rules is: if it works, don't
touch it, and that's exactly why this sat on my todo list for so long.
But "I don't fully understand web app internals yet" was not true
for me anymore, and once that excuse is gone, all that's left is a task
I'm avoiding.

And practically, between graduation and the next job I have more free time
than I'll have again for a while, so it made sense to sit with my notes and
actually figure out what I'd learned. Getting back into regular blogging
needed a platform I'd actually want to open.

I also looked at Hexo and Astro. The short version of why Hugo won is in
[Building This Blog](/tech/building-this-blog/): it comes down to how content
maps to URLs and how each one handles Org-mode.

The longer version is that this year I went through IDEA, VS Code, Neovim, and Emacs for different kinds
of work. IDEA is still my favorite for Java: its indexing and language
support make everything else feel like it's guessing. VS Code is the
balanced choice once you're off Java or working on something large; the
ecosystem covers file browsing, Markdown rendering, and even reading a PDF
without leaving the editor. And since I live in a terminal (WSL as my main
environment, so I get fzf, rg, and the Linux tooling that things like Claude
Code supported first) right now, Neovim is hard to pass up: it's light, fast, and
everything stays on the keyboard.

None of that is actually why I picked Hugo, though. I picked Hugo because I
fell for *Emacs*. It's the first tool that gave me what "one unified
environment" actually means. The Org mode is the part I like most: think of
it as Markdown crossed with a Jupyter notebook. When I want code output
sitting inside my notes instead of copy-pasted from a terminal, Org is about
the best format for that. Hugo happens to parse Org natively, so the fit was
already there before I went looking for it.

### Why not just stay on NotionNext

This is the part with real evidence behind it, not just preference:

1. It's a React app with a long dependency chain.
2. It's hard-coupled to the Notion API. A major API update once took the
   whole blog down in one shot, and there was nothing I could do about it on
   my end.
3. Forking is the wrong shape for this. Maintaining my own fork meant every
   upstream change was a potential merge conflict and a version-bump
   decision I didn't want to make.
4. Error rates I never got to the bottom of. Vercel's dashboard would
   occasionally show something like this:

   {{< figure src="high-error-rate.png" alt="Vercel observability panel showing a 58% error rate" caption="Vercel's own dashboard, mid outage." >}}

5. The deployments themselves were flaky, on top of everything else. A run
   of "Updated" deploys failing back to back on production isn't something
   you want in your history:

   {{< figure src="deployment-errors.png" alt="A string of failed Vercel deployments" caption="A run of production deploys failing back to back." >}}

6. React's CVE treadmill. Every so often there was a fresh CVE to patch that
   had nothing to do with anything I'd written:

   {{< figure src="cve-fix.png" alt="A commit titled 'Fix React Server Components CVE vulnerabilities'" caption="A CVE patch that had nothing to do with anything I'd written." >}}

None of that is exotic. It's just the cost of running someone else's React
app instead of a static site, and I'd paid it long enough.

## How I migrated

### Getting oriented

I started at Hugo's own site, found the themes gallery, and looked for
something that fit a personal, bilingual blog. PaperMod stood out: MIT
licensed, 13.9k GitHub stars, still getting updates, and the demo already
looked close to what I wanted without any customization.

{{< figure src="hugo-themes.png" alt="Hugo's themes page showing the PaperMod theme" caption="PaperMod's listing in Hugo's theme gallery." >}}

From there it was the usual mix: reading the theme's own docs, skimming its
GitHub repo for how people actually configure it, and asking an AI assistant
questions that would've otherwise cost an evening of trial and error, mostly
which config keys are current versus deprecated, and how Hugo's page bundles
are supposed to be laid out.

### Actually doing it

The content move itself was mechanical: 45 posts pulled out of a Notion
export, cleaned up, and dropped into `content/`. The interesting part was
everything that broke after the content was in place, and none of it showed
up until I actually tried to use the feature.

#### One Issue: oversized record failed the whole deploy

My Algolia push script truncates each post's content to stay under Algolia's
10KB per-record limit, but I'd only truncated `content`, not `summary`. Hugo
builds an automatic summary by grabbing whole content blocks, and one post
that opened with a long block produced an 11KB summary. Algolia rejected the
record, the push script exited non-zero, and that failed the entire Vercel
build: not a partial deploy with one missing search result, a hard stop.

```go
"summary" (.Summary | plainify | truncate 300 "" | htmlUnescape | htmlUnescape)
```

### Cutting over

The old blog was still live on Vercel, wired to www.parkerchenca.com and
parkerchenca.com. First I paused that project.

Then it was straightforward: pull the domain off the old project, import the
new repo as its own Vercel project, add the environment variables, and point
the domain back at the new one. Vercel won't let the same domain sit on two
projects at once, so the order matters.

Comments were the last piece: giscus needed the repository to be public with
GitHub Discussions turned on and its own GitHub App installed before it would
actually render anything.

And then, boom, it was done. Simpler than I expected, and the environment
variables even came out to about half of what NotionNext needed.

### Where that leaves things

The blog is live, search works, comments work (I think the light/dark toggle
also flips the comment widget now, but I haven't actually tested it in a
browser myself. If you've read this far, give it a try and tell me in the
comments below ;D ).

## Useful links

Hugo:
- https://github.com/adityatelange/hugo-PaperMod
- https://github.com/adityatelange/hugo-PaperMod/wiki

My Blog:
- https://github.com/BHChen24/MyLittleBlog-Hugo/

---
title: "Ox-Hugo Export Test"
date: 2026-09-10
description: "A post in the shape ox-hugo emits, used to check rendering end to end."
tags: ["hugo", "org-mode", "test"]
categories: ["tech"]
---

Written in Org, exported to Markdown by ox-hugo. Hugo never sees the `.org`
source, so the theme only has to deal with one content format.

## Why export instead of parsing

Hugo's built-in go-org covers common syntax, but it is not the Emacs exporter.
Going through ox-hugo keeps one renderer in play and avoids drift between what
Emacs shows and what the site publishes.

## Code block

```python
def hello():
    print("exported from org")
```

## Table

| Col A | Col B |
|-------|-------|
| 1     | 2     |

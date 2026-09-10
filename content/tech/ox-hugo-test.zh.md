---
title: "Ox-Hugo 导出测试"
date: 2026-09-10
description: "一篇 ox-hugo 导出形态的文章，用来端到端验证渲染。"
tags: ["hugo", "org-mode", "测试"]
categories: ["tech"]
---

在 Org 里写，由 ox-hugo 导出成 Markdown。Hugo 从头到尾看不到 `.org` 源文件，
主题只需要处理一种内容格式。

## 为什么导出而不是解析

Hugo 内置的 go-org 覆盖了常用语法，但它不是 Emacs 的导出器。走 ox-hugo 只保留
一个渲染器，避免 Emacs 里看到的和站点发布出来的产生偏差。

## 代码块

```python
def hello():
    print("exported from org")
```

## 表格

| 列 A | 列 B |
|------|------|
| 1    | 2    |

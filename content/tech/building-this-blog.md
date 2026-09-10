---
title: "Building This Blog"
date: 2026-09-09
description: "Hugo, PaperMod, Algolia, and the four things that broke along the way."
tags: ["hugo", "papermod", "algolia", "setup"]
categories: ["tech"]
---

This site runs on Hugo with the PaperMod theme, bilingual content, and Algolia
for search. None of those choices were difficult. Wiring them together produced
four bugs that were, so this post is mostly about those.

## Why Hugo

The decision came down to Hugo against Hexo. Two requirements settled it: content
organised by directory, and a tolerable path for Org-mode files.

Hugo maps `content/` directly onto URL structure. A file at
`content/tech/foo.md` becomes `/tech/foo/` and the `tech` directory becomes a
section with its own list page. No plugin, no configuration. Hexo can be pushed
into the same shape with `permalink` rules and a category plugin, but it is a
workaround rather than the design.

## The Org-mode detour

Hugo ships Org support through go-org, so `.org` files render without a plugin.
That worked, briefly:

```
ERROR access denied: "text/org" is not whitelisted in policy "security.allowContent"
```

Hugo 0.166 denies `text/org` by default. The parser is present; the security
policy blocks it. Adding an override fixed it:

```yaml
security:
  allowContent:
    - '! ^text/html$'
```

The override came back out later. Writing Org and exporting to Markdown with
ox-hugo keeps a single renderer in play, so Hugo only ever sees Markdown and the
security policy stays at its default. One less deviation from upstream.

## Configuration renames

Two config keys changed name in Hugo 0.158 and the older names still appear in
most tutorials:

| Old | New |
|-----|-----|
| `languageCode` | `locale` |
| `languages.<lang>.languageName` | `languages.<lang>.label` |

Both still work and both emit deprecation warnings. PaperMod's templates still
call `.Language.LanguageCode` internally, so the warnings appear even with a
fully modern config. They are the theme's, not yours.

## Search

PaperMod bundles Fuse.js. It builds a JSON index at compile time, ships it to
the browser, and matches locally. Zero infrastructure, and for a small English
site it is the correct choice.

Two things pushed this site to Algolia instead. The whole index downloads on
every visit to the search page, which does not scale past a few hundred posts.
And Fuse does character-level fuzzy matching with no CJK tokenisation, which
matters for a site that is half Chinese.

There is no official Algolia integration for Hugo. The community packages —
`hugo-algolia`, `atomic-algolia` — stopped being maintained years ago and are
pinned to client v4 while current is v5. So: a template that emits records, a
search page built on InstantSearch, and a push script. Under 200 lines total,
all of it sitting on official libraries.

### The escaping bug

The search page passes configuration into JavaScript:

```go
var cfg = {{ dict "appId" $appId "indexName" $index | jsonify }};
```

Go's `html/template` knows this is a JavaScript context and escapes the value
into a *string literal*. The result:

```js
var cfg = "{\"appId\":\"...\",\"indexName\":\"blog_en\"}";
```

`cfg.indexName` is `undefined`. InstantSearch initialises against an undefined
index and the page renders an empty search box with no error. Wrapping the value
in `JSON.parse()` fixes it without reaching for `safeJS`, which would have
disabled the escaping that exists for good reason.

### The truncate bug

Records are truncated to stay under Algolia's 10KB limit:

```go
.Content | plainify | htmlUnescape | truncate 2000 ""
```

Entities kept appearing in the index as `&#34;`. Hugo's `truncate` is HTML-aware
and re-escapes on output, so it has to run *before* the unescaping, not after.

### The leftover Fuse bug

PaperMod injects its Fuse bundle conditionally:

```go
{{- if (eq .Layout `search`) -}}
<link rel="preload" as="fetch" href="../index.json">
```

The Algolia search page still declared `layout: "search"`, so the theme injected
15KB of Fuse and preloaded an `index.json` that no longer existed. Renaming the
layout to `algolia` sidesteps the condition entirely.

## What is left

Comments are wired to giscus but switched off — the partial renders nothing
until a repository is configured. Analytics is a commented-out block waiting on
a GA4 property. Both are switches rather than commitments.

The remaining duplication is the Algolia index name, which appears in
`hugo.yaml` and again in the push script. Removing it would mean teaching the
script to parse YAML. Two constants do not justify a dependency.

## Notes to self

- Run `hugo server -e production` when checking SEO tags; the default
  development environment omits OpenGraph, Twitter Cards, and JSON-LD entirely.
- The index has to be pushed after every deploy. Fuse indexes travel with the
  build; Algolia indexes live on someone else's server.
- Test content needs to be long enough to scroll. The back-to-top button only
  appears after a full viewport of scrolling, which a sixty-word post will never
  trigger.

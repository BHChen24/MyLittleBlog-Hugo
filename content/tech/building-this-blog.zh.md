---
title: "搭这个博客"
date: 2026-09-09
description: "Hugo、PaperMod、Algolia，以及过程中踩坏的四个地方。"
tags: ["hugo", "papermod", "algolia", "搭建"]
categories: ["tech"]
ShowToc: true
TocOpen: true
---

这个站跑在 Hugo 上，用 PaperMod 主题，中英双语，搜索走 Algolia。这几个选择本身
都不难。难的是把它们接到一起，过程中冒出四个 bug，这篇主要就是记这些。

## 为什么选 Hugo

最后是在 Hugo 和 Hexo 之间挑。两条需求定了胜负：内容按文件夹组织，以及 Org-mode
文件要有一条能走的路。

Hugo 的 `content/` 目录结构直接映射成 URL 结构。`content/tech/foo.md` 出
`/tech/foo/`，`tech` 这个目录自动成为一个 section 并带自己的列表页。不需要插件，
不需要配置。Hexo 靠 `permalink` 规则加分类插件也能凑出同样的效果，但那是绕路，
不是设计本身。

## Org-mode 的弯路

Hugo 通过 go-org 内置了 Org 支持，`.org` 文件不装插件就能渲染。这个确实成立，
但只成立了很短一会儿：

```
ERROR access denied: "text/org" is not whitelisted in policy "security.allowContent"
```

Hugo 0.166 默认拒绝 `text/org`。解析器在，是安全策略把它挡住了。加一段覆盖能修好：

```yaml
security:
  allowContent:
    - '! ^text/html$'
```

这段覆盖后来又删掉了。在 Org 里写、用 ox-hugo 导出成 Markdown，全程只有一个渲染器
在起作用，Hugo 从头到尾只见 Markdown，安全策略保持默认。少一处偏离上游的配置。

## 改过名的配置项

有两个配置键在 Hugo 0.158 改了名，而绝大多数教程上还是旧名字：

| 旧 | 新 |
|-----|-----|
| `languageCode` | `locale` |
| `languages.<lang>.languageName` | `languages.<lang>.label` |

两个旧名都还能用，都会打 deprecation 警告。PaperMod 的模板内部仍在调
`.Language.LanguageCode`，所以哪怕你的配置全部现代化了，警告照样出现。那是主题的，
不是你的。

## 搜索

PaperMod 自带 Fuse.js。构建时生成一份 JSON 索引，发到浏览器，之后全在本地匹配。
零基础设施，对一个体量不大的英文站来说是正确选择。

有两点把这个站推向了 Algolia。一是每次打开搜索页都要把整份索引下载下来，文章上了
几百篇就撑不住。二是 Fuse 做的是字符级模糊匹配，没有 CJK 分词，而这个站有一半是
中文。

Hugo 这边没有官方的 Algolia 集成。社区那几个 —— `hugo-algolia`、`atomic-algolia`
—— 都停更好几年了，还锁在客户端 v4，而现在是 v5。所以只能自己写：一个生成记录的
模板、一个基于 InstantSearch 的搜索页、一个推送脚本。加起来不到 200 行，而且全都
架在官方库上。

### 转义 bug

搜索页要把配置传进 JavaScript：

```go
var cfg = {{ dict "appId" $appId "indexName" $index | jsonify }};
```

Go 的 `html/template` 知道这是 JavaScript 上下文，于是把值转义成了一个**字符串
字面量**。结果是：

```js
var cfg = "{\"appId\":\"...\",\"indexName\":\"blog_en\"}";
```

`cfg.indexName` 是 `undefined`。InstantSearch 拿着一个 undefined 的索引名初始化，
页面渲染出一个空搜索框，一声不吭。用 `JSON.parse()` 包一层就好了，而且不用去碰
`safeJS` —— 那等于关掉一个本来就该在的保护。

### truncate bug

记录要截断以控制在 Algolia 的 10KB 限制内：

```go
.Content | plainify | htmlUnescape | truncate 2000 ""
```

索引里的实体始终以 `&#34;` 的形式出现。Hugo 的 `truncate` 是 HTML-aware 的，输出时
会重新转义，所以它必须跑在 unescape **之前**，不是之后。

### Fuse 残留 bug

PaperMod 是有条件地注入 Fuse 包的：

```go
{{- if (eq .Layout `search`) -}}
<link rel="preload" as="fetch" href="../index.json">
```

而 Algolia 的搜索页还写着 `layout: "search"`，于是主题往里塞了 15KB 的 Fuse，还
preload 了一个已经不存在的 `index.json`。把 layout 改名成 `algolia`，这个条件就
彻底绕开了。

## 还没做的

评论接的是 giscus，但处于关闭状态 —— 没配仓库时那段 partial 什么都不输出。统计是
一段注释掉的配置，等一个 GA4 属性。两个都是开关，不是承诺。

目前唯一的重复配置是 Algolia 的索引名，`hugo.yaml` 里一份，推送脚本里一份。要消掉
它就得让脚本会解析 YAML。两个常量不值一个依赖。

## 给自己的备忘

- 检查 SEO 标签时要用 `hugo server -e production`；默认的 development 环境根本不
  输出 OpenGraph、Twitter Cards 和 JSON-LD。
- 索引每次部署后都得推。Fuse 的索引跟着构建产物走，Algolia 的索引在别人服务器上。
- 测试内容得够长到能滚动。回到顶部按钮要滚过整整一屏才出现，六十个词的文章永远
  触发不了。

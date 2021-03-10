---
layout: post
title: "Hugo でインライン HTML が表示されなくなった"
slug: hugo-inline-html
date: 2019-12-16T11:56:34+09:00
lastmod: 2019-12-16T11:56:34+09:00
comments: true
categories:
  - "programming"
tags:
  - "hugo"
---

基本的に Hugo でブログを書くときは markdown を利用して書いています。

ただ Amazon のリンクを貼ったりするときは外部サービスの吐き出す html を貼り付けて markdown と併用した記事を書いたりすることもあります。

あるとき Amazon リンクを書いた html 部分がごっそり消えていたのに気づきました (特にエラーにはならない)。

[Change Log](https://github.com/gohugoio/hugo/releases/tag/v0.60.0) を見てるとどうやら v0.60.0 からインライン html で改修が入ったようです。

markdown と html を混在した記事を書く場合は以下のように `unsafe` モードを有効にする必要があるらしいです。

**config.toml**

```config.toml
[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
    unsafe = true
```

---
layout: post
title: "Hugo にコメント投稿機能をつけました"
slug: added-disqus
date: 2020-02-05T16:52:53+09:00
lastmod: 2020-02-05T16:52:53+09:00
comments: true
categories:
  - "programming"
tags:
  - "hugo"
---

**Q. Hugo でコメント投稿機能をつけるにはどうしたらいいのだろう？**

**A. DISQUS 使いましょう！**

[公式サイト](https://gohugo.io/content-management/comments/)でも DISQUS 使いましょう、とある。

やり方は簡単。まず [DISQUS](https://disqus.com/) でサインアップして、サイトの作成と設定をする。

`Settings > General` で shortname が分かるのでこれをコピっておく。

Hugo の `config.toml` に下記を追加

```
disqusShortname = "YOUR DISQUS SHORT NAME"
```

であとはテーマ配下の `single.html` とかにテンプレートを書けばいいのだけれど、使ってるテーマによっては DISQUS コメントのテンプレートがすでに入っていたりする。僕の使ってるテーマでは `config.toml` の反映だけでいけた。簡単。

あとは DISQUS でコメントの順序を新着順にするなどの細かい設定をやった。
---
layout: post
title: Emacs に swift-mode をインストール
slug: install-swift-mode-to-emacs
date: 2014-07-21T14:51:49+00:00
comments: true
categories:
  - "programming"
tags:
  - "emacs"
---

Apple が発表した新言語 Swift が話題になってますね。
ほとんどの人は Xcode で試すのでしょうけど、あんな不便なIDEを使いたくない Emacs 病の人がいるかと思います。

すでに swift-mode なるものが `package.el` からインストールできるようになってるのでさっそくインストールしましょう。
以下を Emacs で実行すればOK。

    M-x package-install swift-mode

<a href="https://github.com/chrisbarrett/swift-mode" title="swift-mode" target="_blank">GitHub - swift-mode</a>

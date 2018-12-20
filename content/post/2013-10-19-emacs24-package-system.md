---
layout: post
title: Emacs24 のパッケージシステムを使おう
date: 2013-10-19T03:26:46+00:00
comments: true
categories: programming
tags:
  - emacs
  - ubuntu
---

Emacs24 から独自のパッケージシステムが導入されました。
これによって、今までちまちま github などからインストールしていた各種 elisp が一元管理できるようになりバージョンアップなども行えるため、素晴らしく便利になりました。

初めて elisp を導入するような場合は package からインストールするといいです！

## パッケージインストール先の追加
そのままでも使えますが、よりたくさんのパッケージ候補を出すために以下を `.emacs` もしくは `.emacs.d/init.el` などに追加します。

```lisp
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
```

## パッケージのインストール
`M-x list-packages` でインストールできるパッケージの一覧がでます。
`i` でインストール候補に選ばれ `x` で実行します。

以上です。

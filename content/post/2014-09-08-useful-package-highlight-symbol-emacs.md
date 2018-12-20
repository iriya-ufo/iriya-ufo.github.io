---
layout: post
title: highlight-symbol が便利
date: 2014-09-08T16:01:00+00:00
comments: true
categories: programming
tags: emacs
---

ちょっとした事なんですが、プログラムを書いてると、「このシンボルを目立つようにマーク付けしておきたいなぁ」なんて思うことがあります。関数とか変数とか関係なくちょこっとマークしてそれを常にハイライトしておくんですね。`highlight-symbol` を使うとこれが実現できそうです。

パッケージリストにあるのでさくっとインストールして下記を `.elisp` などに書いておけば動きます。(キーバインドはお好みで)

```lisp
(require 'highlight-symbol)
;; 使いたい色を設定、repeat してくれる
(setq highlight-symbol-colors '("DarkOrange" "DodgerBlue1" "DeepPink1"))
;; キーバインドの設定
(global-set-key (kbd "C-o") 'highlight-symbol-at-point)
(global-set-key (kbd "M-C-o") 'highlight-symbol-remove-all)
```

---
layout: post
title: Mac の Gauche で SLIB を使う
slug: slib-with-gauche
date: 2014-04-12T17:17:10+00:00
comments: true
categories:
  - "programming"
tags:
  - "gauche"
---

Gauche は brew でインストールしていますが SLIB をインストールしていなかったためエラーがでました。

ここからダウンロードしてくれば使えるようになります。

<a href="http://people.csail.mit.edu/jaffer/SLIB.html" title="SLIB" target="_blank">The SLIB Portable Scheme Library</a>

## インストール方法
Gauche デフォルトのライブラリパスにコピーしてあげるだけです。

    $ cd ~/Downloads
    $ curl -O http://groups.csail.mit.edu/mac/ftpdir/scm/slib-3b4.zip
    $ unzip slib-3b4.zip
    $ cp -r slib /usr/local

これで、例えば以下のようにして Gauche で trace のデバッグができるようになりました。

```lisp
(use slib)
(require 'trace)
```

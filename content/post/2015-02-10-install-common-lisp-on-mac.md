---
layout: post
title: Mac に Common Lisp 処理系をインストールする
slug: install-common-lisp-on-mac
date: 2015-02-10T03:42:46+00:00
comments: true
categories:
  - "programming"
tags:
  - "common lisp"
---

Common Lisp は仕様によって規定される言語なので処理系が複数存在します。フリーでメジャーなのは <strong>SBCL</strong> と <strong>Clozure CL</strong> です。違いは <a href="http://ja.wikipedia.org/wiki/Common_Lisp" title="Common_Lisp" target="_blank">Wikipedia</a> あたりを参考にしてもらうといいかと。
簡単に特徴を上げるとすると SBCL はバイトコードへのコンパイルがかなり優秀だがコンパイル速度が遅い、Clozure CL はコンパイルが速くデバッグメッセージなどが分かりやすいけど、バイトコードの速度は SBCL に劣る。といったところでしょうか。
開発は Clozure CL で本番は SBCL みたいに使い分けるといいかもしれないです。

今回は両方インストールしてみることにします。

## SBCL のインストール

    $ brew install sbcl

REPL するときに、ヒストリーの行き来ができないので rlwrap でラップしてあげます。以下を `~/.zshrc` などに追加します。

    alias sbcl='rlwrap sbcl'

これで終わりです。後は SLIME などの便利な環境を入れますが、これは Clozure CL でも共通ですので後で書きます。


## Clozure CL のインストール
<a href="https://itunes.apple.com/us/app/clozure-cl/id489900618?mt=12" title="MacAppStore" target="_blank">Mac App Store</a> から GUI 処理系がダウンロードできるようですが、別に統合開発環境は必要ないので SVN で実行バイナリをダウンロードする形でインストールします。

インストール方法は公式サイトに準拠します。

http://ccl.clozure.com/download.html

    $ cd /usr/local/
    $ svn co http://svn.clozure.com/publicsvn/openmcl/release/1.10/darwinx86/ccl

これで `/usr/local/ccl` 配下に実行バイナリがダウンロードできました。ccl の中にある dx86cl64 というのが 64 bit 版の処理系です。

SBCL 同様 rlwrap でラップします。以下を `~/.zshrc` などに追加します。

    alias ccl='rlwrap /usr/local/ccl/dx86cl64'


## SLIME の設定
Common Lisp を使う人はみなさん Emacs 使ってると思うので、SLIME いれましょう。24 以降の Emacs だとパッケージからインストールできます。補完を便利にするため ac-slime もいれます。後は `.emacs` に以下を追記します。

```lisp
;;====================================
;; Common Lisp
;;====================================
;; デフォルト処理系の設定
(setq inferior-lisp-program "/usr/local/ccl/dx86cl64")
;; slime の設定
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner slime-indentation))
(setq slime-net-coding-system 'utf-8-unix)
;; slime の補完
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
```

Emacs で開発するときは `M-x slime` として REPL を立ち上げて開発をしていきます。

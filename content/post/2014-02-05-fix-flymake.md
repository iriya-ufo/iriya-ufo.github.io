---
layout: post
title: rbenv で入れた ruby で flymake がちゃんと動作しなかったので直した
slug: fix-flymake
date: 2014-02-05T00:28:18+00:00
comments: true
categories:
  - "programming"
tags:
  - "emacs"
  - "ruby"
---

Emacs ユーザーの皆さんこんにちは。Ruby 書いてますか？rbenv 入れてますか？flymake 使ってますか？
flymake はデフォルトだとシステムの ruby を読みにいきます。rbenv で ruby をインストールしていた場合、パスを設定してやらないとシステムの ruby1.8 を使います。なので 1.9以降の文法を書くとエラーになります。具体的には以下のハッシュ記法などで Syntax Error がでます。

```ruby
h = { :h => 1 } # ruby1.8 or ruby1.9 以降で動作
h = { h: 1 } # ruby1.8 だとエラーになる
```

rbenv でインストールした ruby を読ませるため `.emacs` に以下を追記します。

```lisp
;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))
```

Emacs を再起動して `M-x run-ruby` で確認してみましょう。

## PATH 設定前

    irb(main):001:0> RUBY_VERSION
    => "1.8.7"

## PATH 設定後

    irb(main):001:0> RUBY_VERSION
    => "2.0.0"

これで flymake でも新しい文法でチェックできるようになります。

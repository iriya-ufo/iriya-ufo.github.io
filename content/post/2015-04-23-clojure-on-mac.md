---
layout: post
title: Mac に Clojure 環境いれてみた
slug: clojure-on-mac
date: 2015-04-23T23:10:30+00:00
comments: true
categories:
  - "programming"
tags:
  - "clojure"
---

Closure ではなくて Clozure でもなくて Clojure の環境構築です。
Mac でのやり方と、ついでに Emacs でいい感じにする設定を書きます。

## JDKのインストール
これがないと始まらないですね。JDK とか OpenJDK とか細かいことは気にしないでおきましょう。端末で java とか打ってみて入っていないようでしたら Oracle のサイトからダウンロードしてインストールで一発です。

## Emacs の設定
非 Emacs ユーザーは「Leiningen のインストール」まで読み飛ばしてください。

以下を Cask に追加して `$ cask install` してください。Cask を使ってない場合は `M-x package-install` とかで大丈夫です。環境構築が楽になるので Cask おすすめです。

```lisp
(depends-on "paredit")
(depends-on "rainbow-delimiters")
(depends-on "clojure-mode")
(depends-on "clojurescript-mode")
(depends-on "cider")
```

<a href="http://www.daregada.sakuraweb.com/paredit_tutorial_ja.html" target="_blank">ParEdit</a> はなくても大丈夫です。Lisp 系言語を書くときの便利なプラグインみたいなものです。rainbow-delimiters は対応する括弧をいい感じに色付けしてくれるものです。cider はネットワーク経由の REPL を使うようにするためのものです。

## Emacs 設定ファイル
`.emacs` とか `init.el` に以下を追記します。

```lisp
;;
;;================================================================
;; Clojure
;;================================================================
(require 'clojure-mode)
(require 'clojurescript-mode)
(require 'paredit)
(add-hook 'clojure-mode-hook 'paredit-mode)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
```

## Leiningen のインストール
Leiningen は Clojure のビルドツール兼パッケージ管理をするものです。インストールは簡単です。

    $ brew install leiningen
    $ lein --version

あと具体的な使い方は<a href="http://clojournal.com/entry/54e42e79e4b07686596991c1" target="_blank">ここ</a>とかみるといいと思います。便利なプラグイン一覧とかは<a href="https://github.com/technomancy/leiningen/wiki/Plugins" target="_blank">ここ</a>からどうぞ。

## Leiningen と CIDER
おまけです。Leiningen と CIDER の連携の仕方です。
`~/.lein/profiles.clj` に以下を書きます。

```lisp
{:user {:plugins [[cider/cider-nrepl "0.8.2"]]}}
```

あとは lein プロジェクトで Emacs から呼び出してやればOKです。

    M-x cider-jack-in

## 参考
- <a href="http://matstani.github.io/blog/2013/04/19/clojure-dev-env-emacs/" target="_blank">Clojure開発環境インストール手順(Emacs)</a>
- <a href="https://github.com/clojure-emacs/cider" target="_blank">cider | github</a>

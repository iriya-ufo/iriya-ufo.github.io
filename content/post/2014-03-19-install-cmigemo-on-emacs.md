---
layout: post
title: Mac の Emacs に cmigemo をインストール
date: 2014-03-19T01:11:21+00:00
comments: true
categories: programming
tags:
  - emacs
  - homebrew
  - mac
  - shell
---

cmigemo はすごく便利です。Mac の Emacs にインストールするのに若干はまったので備忘録として記載します。

まずはインストールから

    $ brew install cmigemo

ここから `migemo.el` をとってきてロードパスの通ったところに置きます。

    $ git clone https://github.com/emacs-jp/migemo.git

`.emacs` の設定をします。exec-path の問題はいくつか解決方法がありましたが、exec-path-from-shell のパッケージはうまくいきませんでした。また elisp も動くものと動かないものがありました。以下のように書くと私の環境下では動作しました。

```lisp
;; exec-path が GUI で正しく引き継がれない問題を解決
(let ((path-str
       (replace-regexp-in-string
       "\n+$" "" (shell-command-to-string "echo $PATH"))))
  (setenv "PATH" path-str)
  (setq exec-path (nconc (split-string path-str ":") exec-path)))
```

cmigemo の設定です。

```lisp
;; cmigemo
;; 日本語のインクリメンタル検索
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
;; IME の制御  
;; emacs 起動時は英数モードから始める
(add-hook 'after-init-hook 'mac-change-language-to-us)
;; minibuffer 内は英数モードにする
(add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
;; [migemo]isearch のとき IME を英数モードにする
(add-hook 'isearch-mode-hook 'mac-change-language-to-us)
```

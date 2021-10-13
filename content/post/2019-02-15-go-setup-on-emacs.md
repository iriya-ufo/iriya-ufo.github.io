---
layout: post
title: "Emacs に Go の開発環境を整える"
slug: go-setup-on-emacs
date: 2019-02-15T11:35:19+09:00
lastmod: 2019-02-15T11:35:19+09:00
comments: true
categories:
  - "programming"
tags:
  - "go"
  - "emacs"
---

記事の情報が古くなってしまったので書き直しました。以下を参照してください。

- [[2021年版] Emacs に Go の開発環境を整える]({{< relref "2021-10-13-go-setup-on-emacs-ver2" >}})

----

ここからは以前の内容です。

Mac で Go をサクッとはじめるための手引書

# Go のインストール

``` bash
$ mkdir $HOME/.go

# Add this line to ~/.zshrc
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Install
brew install go
```

# Go Package のインストール

``` bash
$ go get github.com/rogpeppe/godef               # 関数定義等の参照パッケージ
$ go get -u github.com/nsf/gocode                # 補完パッケージ
$ go get -v github.com/uudashr/gopkgs/cmd/gopkgs # Go パッケージ
$ go get github.com/golang/lint/golint           # flycheckでシンタックスエラーを検知
$ go get github.com/kisielk/errcheck             # flycheckでシンタックスエラーを検知
```

# Emacs Go Package のインストール

Emacs のパッケージ管理は Cask を使っているものとする

以下を Caskfile に追加して `cask install` する

``` bash
(depends-on "flymake-go")
(depends-on "go-mode")
(depends-on "company-go")
(depends-on "go-eldoc")
(depends-on "go-autocomplete")
```

# Elisp の設定

``` emacs-lisp
;;
;;================================================================
;; Go
;;================================================================
(when (and (locate-library "exec-path-from-shell") (locate-library "go-mode"))
  (require 'exec-path-from-shell)
  (let ((envs '("PATH" "GOPATH")))
    (exec-path-from-shell-copy-envs envs))
  (require 'go-autocomplete)
  (add-hook 'go-mode-hook
            (lambda ()
              (setq indent-tabs-mode t)
              (go-eldoc-setup)
              (setq gofmt-command "goimports")
              (add-hook 'before-save-hook 'gofmt-before-save)
              ))
  )
```

# 参考サイト

* [emacsで快適なGo言語ライフを送るための設定](https://qiita.com/kod314/items/2232d480411c5c2ab002)
* [Goプログラミングの環境構築](http://emacs-jp.github.io/programming/golang.html)
* [Emacs の Go の環境を整えるメモ](https://cortyuming.hateblo.jp/entry/2016/03/05/064909)

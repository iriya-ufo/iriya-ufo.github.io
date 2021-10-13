---
layout: post
title: "[2021年版] Emacs に Go の開発環境を整える"
slug: go-setup-on-emacs-ver2
date: 2021-10-13T13:54:35+09:00
lastmod: 2021-10-13T13:54:35+09:00
comments: true
categories:
  - "programming"
tags:
  - "go"
  - "emacs"
---

[以前書いた内容]({{< relref "2019-02-15-go-setup-on-emacs" >}})が古くなったので改めて書き直すことにしました。
大きな変更点としては補完に `gocode` ではなく `gopls (Language Server)` を使うようにしたことです。

## Go のインストール

``` bash
$ mkdir $HOME/.go

# Add this line to ~/.zshrc
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Install
brew install go
```

## Go Package のインストール

まずは `gopls (Language Server)` とその他をインストールします。

```bash
$ go get golang.org/x/tools/gopls@latest         # Language Server
$ go get -v github.com/uudashr/gopkgs/cmd/gopkgs # Go パッケージ
```

## Emacs Go Package のインストール

次に Emacs 関連のパッケージをインストールします。

一番コアとなるのは lsp-mode ですね。
lsp-ui はドキュメントのリファレンスなどを表示するもので company-lsp はコード補完のバックエンドとして company を使うためのパッケージです。

```lisp
(use-package lsp-mode)
(use-package lsp-ui)
(use-package company-lsp)
```

ついでに lsp 関連の設定も書いておきます。

```lisp
;; lsp-mode keybinds
(defun lsp-mode-init ()
  (lsp)
  (global-set-key (kbd "M-*") 'xref-pop-marker-stack)
  (global-set-key (kbd "M-.") 'xref-find-definitions)
  (global-set-key (kbd "M-/") 'xref-find-references))

;; lsp-ui config
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-header t)
(setq lsp-ui-doc-include-signature t)
(setq lsp-ui-doc-max-width 150)
(setq lsp-ui-doc-max-height 30)
(setq lsp-ui-peek-enable t)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
```

go-mode パッケージをインストールしておきます。

```lisp
(use-package go-mode)
```

## Elisp の設定

go-mode に lsp を hook するだけでいい感じに使えます。

``` emacs-lisp
(add-hook 'go-mode-hook #'lsp)
```

lsp-mode は最初に Go ファイルを開くと workspace を聞いてきます。
インポートすると `.emacs.d/` に `.lsp-session-v1` というテキストファイルが作られます。

少し触ってみましたがいい感じですね。
簡単な設定でそこそこいい感じに使えるので他の言語でも lsp を導入したくなってきました。

## VSCode からインストールされたパッケージ群

余談ですが VSCode で Go の環境を整えて Go ファイルのあるディレクトリを開くと、いくつかパッケージのインストールを勧められます。
そこで `Install All` すると2021年10月現在以下のパッケージが入りました。デフォルトで入るパッケージなので入れておくと吉かもしれません。

```
gopkgs
go-outline
gotests
gomodifytags
impl
goplay
dlv
dlv-dap
staticcheck
gopls
```

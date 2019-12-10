---
layout: post
title: "VSCode に Go の開発環境を整える"
slug: go-env-in-vscode
date: 2019-12-08T01:36:06+09:00
lastmod: 2019-12-08T01:36:06+09:00
comments: true
categories:
  - "programming"
tags:
  - "go"
  - "vscode"
---

Mac で Go をサクッとはじめるための手引書

- [Emacs の場合はこちら]({{< relref "2019-02-15-go-setup-on-emacs" >}})

## Go のインストール
``` bash
$ mkdir $HOME/.go

# Add this line to ~/.zshrc
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Install
brew install go
```

バージョン確認
```bash
$ go version
go version go1.13.4 darwin/amd64
```

## REPL のインストール
``` bash
$ GO111MODULE=off go get -u github.com/motemen/gore/cmd/gore

$ gore # 確認
gore version 0.4.1  :help for help
gore> fmt.Println("hello")
hello
6
<nil>
```

## Go Package のインストール
``` bash
# gopkgs is a tool that provides list of available Go packages that can be imported.
$ GO111MODULE=on go get github.com/uudashr/gopkgs/cmd/gopkgs@latest

# Golint is a linter for Go source code.
$ go get -u golang.org/x/lint/golint

# errcheck is a program for checking for unchecked errors in go programs.
$ go get -u github.com/kisielk/errcheck
```

## 補完ツールのインストール
補完については `gocode` を `go get` してくるという記事がよく見られるが、これは以下のような事情でちょっと使わない方がいい。

- [gocode やめます(そして Language Server へ)](https://mattn.kaoriya.net/software/lang/go/20181217000056.htm)

またこの記事では bingo と golsp について言及しているが、これもまた事情が変わって今は gopls に一本化する方向に向かっている。
こちらの記事が詳しい。

- [Golang開発環境を作成する(module対応) - Ubuntu16.04/VSCode](https://qiita.com/ochipin/items/cae787d75ae91247c722)

それらを踏まえて設定していく。

### gopls をインストール
Language Server の `gopls` をインストールする。

```bash
$ GO111MODULE=on go get golang.org/x/tools/gopls@latest
```

(cf. https://github.com/golang/tools/blob/master/gopls/doc/user.md)

### VSCode に Go のプラグインをインストール
[こちら](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go)の Go のプラグインをインストールする。

### settings.json の設定
こんな感じで `settings.json` に追記して VSCode を再起動する。

```json
{
    "go.useLanguageServer": true,
    "go.alternateTools": {
        "go-langserver": "gopls"
    },
    "go.languageServerExperimentalFeatures": {
        "format": true,
        "autoComplete": true,
        "rename": true,
        "goToDefinition": true,
        "hover": true,
        "signatureHelp": true,
        "goToTypeDefinition": true,
        "goToImplementation": true,
        "documentSymbols": true,
        "workspaceSymbols": true,
        "findReferences": true,
        "diagnostics": true
    },
    "[go]": {
        "editor.snippetSuggestions": "none",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.organizeImports": true
        },
    },
    "gopls": {
        "usePlaceholders": false
    }
}
```

以上で補完が効くようになった。
---
layout: post
title: "Go でインストールしたパッケージのアップデート"
slug: go-pkg-update-all
date: 2024-09-24T12:24:24+09:00
lastmod: 2024-09-24T12:24:24+09:00
comments: true
categories:
  - "programming"
tags:
  - "go"
---

`go get` もしくは `go install` でインストールしたパッケージのアップデート方法

```bash
$ go get -u <pkg>
$ go install <pkg>@latest
```

`<pkg>` の情報(パス)を知りたい場合、以下のようにする

```bash
$ cd $GOPATH/bin
$ go version -m <pkg-name> | head -n2 | tail -n1 | awk '{print $2}'
```

## 参考サイト

- [go installしたものを一括で更新する方法](https://zenn.dev/kyoh86/articles/291618538dcf0d)

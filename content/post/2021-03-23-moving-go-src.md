---
layout: post
title: "Go の src ディレクトリを移動した"
slug: moving-go-src
date: 2021-03-23T15:27:54+09:00
lastmod: 2021-03-23T15:27:54+09:00
comments: true
categories:
  - "programming"
tags:
  - "go"
  - "ghq"
---

以前[「リポジトリ管理ツール ghq を導入した」]({{< relref "2019-11-28-ghq-setup" >}})という記事を書きましたが、Go も Modules が主流になって様子が変わったので、一度整理することにしました。

Go の Modules についての説明はこちらが分かりやすかったです。

- [GOPATHを掃除してGo Modulesに移行しよう](https://techblog.kayac.com/migration-gopath-to-go-modules)
- [最近のGo Modulesプラクティス ~ ghqユーザーの場合も添えて](https://songmu.jp/riji/entry/2019-03-28-go-modules.html)

今までは `ghq get` したものは `~/.ghq` に `go get` したものは `$GOPATH/src` 配下に置いていました。
Go Modules 利用時では src ディレクトリの制限がなくなったため ghq と同じ場所に置くようにします。
$GOPATH は特段変更する必要がないのでそのままにしておきます。

一度きれいさっぱりにしたいので $GOPATH 配下を全部消します。必要なものは後でダウンロードするためメモしておきます。
```shell
$ rm -rf $GOPATH/bin $GOPATH/pkg $GOPATH/src
```

`.gitconfig` の root 設定で `~/.go/src` を消します。

```diff
 [ghq]
-       root = /Users/iriya/.go/src
        root = /Users/iriya/.ghq
```

運用方法としては Go のツールやライブラリなどが欲しいときは `go get` で取ってきて、ソースコードが欲しいときは `ghq get` で取ってくるようにしました。
これでソースコードの管理は `~/.ghq` 配下に収まります。
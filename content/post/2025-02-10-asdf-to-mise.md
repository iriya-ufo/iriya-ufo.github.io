---
layout: post
title: "asdf から mise に移行する"
slug: asdf-to-mise
date: 2025-02-10T22:01:30+09:00
lastmod: 2025-02-10T22:01:30+09:00
comments: true
categories:
  - "programming"
tags:
  - "asdf"
  - "mise"
---

## asdf が壊れた

[この記事]({{< relref "2022-04-29-asdf-install" >}})を書いて以降ずっと asdf を使ってきましたが `brew upgrade` のタイミングで壊れてしまいました。

```
/Users/iriya/.zshrc:source:126: no such file or directory: /usr/local/opt/asdf/libexec/asdf.sh
```

公式サイトで見てもインストール方法は変わっておらず brew のタイミングでなぜか libexec が消失していた感じです。
治し方が分からないので mise に移行することにしました。


## asdf のアンインストール

今までありがとう

```
$ brew uninstall asdf
$ brew autoremove
$ rm -rf ~/.asdf

.zshrc から以下を消す
source /usr/local/opt/asdf/libexec/asdf.sh
```


## mise のインストール

[公式の Getting Started](https://mise.jdx.dev/getting-started.html)

```
$ brew install mise
$ echo 'eval "$(mise activate zsh)"' >> "${ZDOTDIR-$HOME}/.zshrc"
```

簡単な使用方法

| コマンド | 説明 |
|----------|------|
| mise use foo@x.x | 特定バージョンの foo を現在のディレクトリにインストールする |
| mise install | 設定ファイルを読み込んでインストールする(asdf互換) |
| mise use foo@x.x -g | 特定バージョンの foo をグローバルにインストールする |
| mise list | 一覧表示 |

asdf と違い plugin のインストールがないので楽なのとインストールが速い


## その他

起動時間に何か変化あるかなと思って計測してみました。

### asdf 使用時
```
$ time ( zsh -i -c exit )
( zsh -i -c exit; )  0.16s user 0.16s system 98% cpu 0.333 total
```

### mise 使用時
```
$ time ( zsh -i -c exit )
( zsh -i -c exit; )  0.18s user 0.18s system 102% cpu 0.352 total
```

ほとんど変わらなかった。

---
layout: post
title: 高速検索の ag を入れてみた
date: 2014-09-09T23:43:08+00:00
comments: true
categories: programming
tags:
  - ag
  - emacs
  - zsh
---

プログラムを書いてると<strong>検索</strong>という行為一つで大きく生産性が変わることをプログラマーは知っています。僕は今まで grep を使ってた、というか grep しか知らなかったのですが同僚から ag について教えてもらったのでいれてみました。とにかく検索が爆速でびっくりです。

## インストールと設定
超カンタンです。

    $ brew install ag

検索対象外にしたいファイルやディレクトリを `~/.agignore` に書きます。ag はこれができるのがいいですね。

```sh ~/.agignore
*~
*.swp
*.sql
*.tags*
*.tmp*
*.old
*.pdf
*.log
.git
.svn
jquery-*.js
jquery.js
zsh-completions
```

## 補完を有効にする
zsh を使ってるのが前提ですが、ag のオプションの補完ができるようにします。またこれを入れると ag に限らず便利な補完機能がもれなくついてきます。どのようなコマンドの補完があるかはインストールすれば分かります。とりあえず便利なので入れておいて損はない。

    $ brew install zsh-completions

以下を `~/.zshrc` に追加します。ちなみに僕はここで少し躓いて時間を食ってしまいました。僕は zsh の設定ファイルを分割してそれぞれ読み込むようにしているのですが、autoload の実行が fpath よりも前にされていたので補完機能が働いていませんでした。autoload は fpath の後に書きましょう。

```sh
fpath=(~/.zsh/functions/Completion(N-/) /usr/local/share/zsh-completions /usr/local/share/zsh/functions ${fpath})
autoload -U compinit
compinit -u
```

zcompdump をリビルドします。

    $ rm -f ~/.zcompdump; compinit

シェルの再起動で補完が有効になります。

## Emacs から ag を使う
さて高速検索の ag ですが、普段使ってるエディターと組み合わせることで真価を発揮します。vim の人はググってもらうとして Emacs ユーザーは `helm-ag` をインストールすれば幸せになれるんじゃないでしょうか。

インストールはいつもの通り、パッケージリストから探してインストールします。後は特に設定をしないでも使えます。起動は `M-x helm-ag` です。毎度打つのは面倒なので適当にキーバインドするといいでしょう。

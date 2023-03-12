---
layout: post
title: "Emacs に Rust の開発環境を整える"
slug: rust-setup-on-emacs
date: 2023-02-18T18:01:07+09:00
lastmod: 2023-02-18T18:01:07+09:00
comments: true
categories:
  - "programming"
tags:
  - "rust"
  - "emacs"
---

Rust の勉強を始めました。
Mac + Emacs に Rust の開発環境を整えたのでその備忘録です。

## Rust のインストール

[公式サイト](https://www.rust-lang.org/ja/tools/install)に習い `rustup` ツールを使って Rust をインストールします。
`rustup` は Rust のバージョン管理と関連ツールの管理を行うことができるツールです。

``` bash
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

続けて `rustfmt`（フォーマッタ）と `clippy`（リンタ）をインストールします。

``` bash
$ rustup component add rustfmt clippy
# 実行方法
$ cargo fmt
$ cargo clippy
```

これで Rust がインストールできました。Rust をバージョンアップする場合は、以下のようにします。

``` bash
$ rustup update stable
```

## Emacs のセットアップ

[rust-analyzer](https://rust-analyzer.github.io/) をインストールします。
`rust-analyzer` は Rust のための LSP（Language Server Protocol） 実装です。
そのため LSP の構築がまだの場合は、先にそちらを終わらせます。
LSP のセットアップ方法は Go の環境を整えるときに作ったので、こちらの記事を参考にしてください。

- [[2021年版] Emacs に Go の開発環境を整える]({{< relref "2021-10-13-go-setup-on-emacs-ver2" >}})

では話しを戻して `rust-analyzer` のインストールです。

``` bash
$ brew install rust-analyzer
```

続いて `rustic-mode` のインストールと設定をします。
Rust のモードは `rust-mode` が有名かもしれませんが `rustic-mode` は `rust-mode` を Fork したもので、より便利になっているためそちらを使います。

Emacs の設定ファイルに以下を書きます。パッケージ管理に `straight.el` を使っていますので適宜読み替えてください。

``` lisp
(use-package rustic)
(add-hook 'rustic-mode-hook #'lsp)
```

これで設定完了です。もし `cargo` や `rust-analyzer` などが実行できないようでしたら PATH が通ってない可能性があるので適宜 PATH を設定します。

``` lisp
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))
```

## 使い方

helm などを使っている場合は `M-x rustic` まで打つと候補がいろいろ表示されるので、なんとなく見れば分かるかと思います。

よく使いそうなコマンドは以下ですかね。

- `cargo run` > `C-c C-c C-r`
- `cargo fmt` > `C-c C-c C-f`
- `cargo test` > `C-c C-c C-t`

mini popup を表示させて一覧から選んで実行する場合は `C-c C-p` とすればよいです。

`M-.` で定義元にジャンプできます。`M-,` で戻ることができます。

## 余談

### VSCode の場合

VSCode の場合は `rust-analyzer` という拡張機能を探してインストールすれば完了です。簡単ですね。
`rust-analyzer` バイナリは VSCode の管理ディレクトリにインストールされるようになっているようです。

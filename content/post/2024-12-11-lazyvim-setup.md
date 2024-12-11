---
layout: post
title: "LazyVim をはじめました"
slug: lazyvim-setup
date: 2024-12-11T22:26:23+09:00
lastmod: 2024-12-11T22:26:23+09:00
comments: true
categories:
  - "programming"
tags:
  - "vim"
---

[TechCommit AdventCalendar2024](https://adventar.org/calendars/10584) 9日目の記事です。

最近 LazyVim を触り始めたのでそのセットアップ備忘録になります。
自分は今まで Emacs を長年触ってきましたが最近は動作のもっさり感とたまにクラッシュするのでどうしたものかなぁと思っていたところ、たまたま LazyVim の存在を知ったので入門してみました。
Vim は NeoVim で拡張できることは知ってましたが、セットアップが大変なイメージがあったのでこれまで躊躇してました。

## Install

```bash
$ brew install neovim
$ git clone https://github.com/LazyVim/starter ~/.config/nvim
$ rm -rf ~/.config/nvim/.git
$ nvim
```

`~/.zshrc` に alias を追加

```bash
alias nv='nvim'
```

Nerd Font をインストール

- Nerd Font とは各種プログラミング用フォントにアイコンなどが加わったセット
- Nerd Font がないと LazyVim 起動時のアイコンなどが tofu になる
- [このサイト](https://www.programmingfonts.org)で比較できる

```bash
$ brew tap homebrew/cask-fonts # M1 以上の Mac では必要なし
$ brew install --cask font-Hack-nerd-font

$ fc-list # インストール済みフォント一覧
```

ターミナルで Nerd Font を使用する設定を書く

- `.alacritty` の設定ファイルに追記
- https://github.com/iriya-ufo/dotfiles/commit/6727358dc41930f2ee2ed7398edeec1bc4b5aeb8

コンフィグを Git 管理する

```bash
$ mv ~/.config/nvim ~/.dotfiles/Mac/
$ ln -s ~/.dotfiles/Mac/nvim ~/.config
```

不必要な設定を消して config からやり直す方法

```bash
$ rm -rf ~/.local/share/nvim
$ rm -rf ~/.local/state/nvim
$ rm -rf ~/.cache/nvim
```

## 設定の基本方針

基本は LazyVim が用意されているものを使用する

- LazyVim のプラグインを有効化するときは公式に習って `lua/config/lazy.lua` でインポートする
- そのデフォルト動作を上書きしたい場合に限って `plugins` ディレクトリにファイルを作成して設定する
- その他、用意されているプラグインではないものは直接 `plugins` ディレクトリにファイルを作って書く

## Tailwind有効化

- Tailwindを有効化したときに出たエラーの解決
- `lua/config/lazy.lua` で tailwind を import したとき以下のエラーが出た

```
module 'lspconfig.server_configurations.tailwindcss' not found:
```

- エラーを解決しようと以下の作業を行った（以下では解決できない）

```bash
nvim 起動
:Mason
/tailwind 検索
tailwindcss-language-server をインストールしようとしたがすでにインストールされていた

terminal からコマンド実行
$ npm install -g @tailwindcss/language-server
```

- `lua/plugins/tailwindcss.lua` ファイルを作成し以下の設定を入れることで解決した

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {},
      },
      setup = {
        tailwindcss = function(_, opts)
          local tw = require("lspconfig.configs.tailwindcss")
        end,
      },
    },
  },
}
```

## Cheat Sheet

[⌨️ Keymaps | LazyVim](https://www.lazyvim.org/keymaps)

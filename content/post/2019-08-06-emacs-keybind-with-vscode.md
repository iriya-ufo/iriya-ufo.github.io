---
layout: post
title: "VSCode で Emacs キーバインドを使う"
slug: emacs-keybind-with-vscode
date: 2019-08-06T17:31:53+09:00
lastmod: 2019-08-06T17:31:53+09:00
comments: true
categories:
  - "programming"
tags:
  - "emacs"
  - "vscode"
---

長年使ってきた Emacs から徐々に VSCode に乗り換えています。
できるだけ VSCode のデフォルトや流儀に従うつもりで慣れようと思ったのですが、さすがに素のキーバインドを覚え直すのは骨が折れるので拡張機能でいい感じのものを探しました。

使い始めて最初のうちは [Emacs Friendly Keymap](https://marketplace.visualstudio.com/items?itemName=lfs.vscode-emacs-friendly) を使用していたのですが、なかなか使いづらい感じの拡張でどうにかならんかなと思いつつ我慢して使っていました。

色々調べ直して [Awesome Emacs Keymap](https://marketplace.visualstudio.com/items?itemName=tuttieee.emacs-mcx) というのがいい感じに使えるという発見がありました。

Emacs Friendly Keymap では `Ctrl + k` で一行削除しますが、これ末尾の RET も削除してしまっていました。この動作がどうしても慣れなくて困っていたのですが Awesome Emacs Keymap はちゃんと末尾の RET は残してくれています。

またこの拡張機能のよいところはマルチカーソル機能を損なわずに使えることです。もともと Emacs でもオレオレ Elisp でマルチカーソルを使っていたのですが、キーバインドが特殊なため、これを移植するのは面倒でした。Awesome Emacs Keymap は VSCode のデフォルトマルチカーソル機能をそのまま使えるのがよいです。

これでしばらく戦えそうです。

参考までによく使う便利なコマンドはこちら。

| コマンド           | 動作                                     |
| ------------------ | ---------------------------------------- |
| ⌘+d                | 一個ずつ選択を増やしながらマルチカーソル |
| ⌘+Shift+L          | 該当単語を一斉に選択                     |
| Option + Shift + I | 選択範囲の末尾にマルチカーソル           |
| M-g g (M-g M-g)    | 該当行にジャンンプ                       |
| Ctrl-x z         | Zen Mode                                 |

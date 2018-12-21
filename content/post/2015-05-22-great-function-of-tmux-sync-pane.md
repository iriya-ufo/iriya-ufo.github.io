---
layout: post
title: tmux の sync pane 機能に感動した
slug: great-function-of-tmux-sync-pane
date: 2015-05-22T22:22:24+00:00
comments: true
categories:
  - "programming"
tags:
  - "tmux"
---

「ターミナルの仮想端末といえば screen」ってな感じで使ってたんですが、とあるレンタルサーバーで tmux 設定がデフォになってたんで重い腰をあげて tmux に移行してみました。そしたら思いのほか感動したという話しです。

目玉機能は分割したペインに対して一斉に同じコマンドを発行できることでした。これでサーバー作業がだいぶ楽になりますね。どんな感じかは以下の youtube を見ていただけるとわかります。

<iframe width="420" height="315" src="https://www.youtube.com/embed/tfSuKj3Xrsc" frameborder="0" allowfullscreen></iframe>

設定ファイルは github にあげてます。

- [.tmux.conf](https://github.com/iriya-ufo/dotfiles/blob/b5948b4a6a0b4914d2fb68fdf3b3b584afdbcd5d/Mac/.tmux.conf)

少し簡単に解説

    unbind-key s
    bind-key s split-window -h

こんな感じで書くと、プレフィクス押下してから一旦 Ctrl を離さないといけないです。ペイン分割系はあまり使わないのでこうしてます。

    unbind-key h
    bind C-h select-pane -L

一方でペインの移動やウィンドウの移動はいちいち Ctrl を離すのはやりにくいので、上記設定で押しっぱなしでも移動できるようにしています。

    # sync-pane
    bind e setw synchronize-panes on
    bind E setw synchronize-panes off

そしてこれが目玉機能の sync pane のキーバインドです。

まだ活用しきれていないですがいい感じです。

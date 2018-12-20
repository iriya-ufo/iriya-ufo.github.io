---
layout: post
title: MacOS のパッケージ管理で便利な Homebrew の使い方
date: 2013-10-30T03:24:39+00:00
comments: true
categories: programming
tags:
  - homebrew
  - mac
---

備忘録のため使い方をまとめます。インストールの仕方は割愛します。

    $ brew update   # brew を最新にする
    $ brew outdated # インストール済のパッケージのうち最新のバージョンが公開されてるものを表示
    $ brew upgrade  # インストールしている Formula をアップデート
    $ brew doctor   # エラーなどのチェック
    $ brew cleanup  # 旧バージョンのパッケージを削除

---
layout: post
title: Mac に Node.js インストールした
slug: nodejs-on-mac
date: 2016-04-07T22:54:11+00:00
comments: true
categories:
  - "programming"
tags:
  - "nodejs"
---

今更すぎるけどいれた。

まず brew を使って Node.js のバージョン管理を行う nodebrew（ruby でいう rbenv のようなもの） をインストールする。

    $ brew install nodebrew

PATH を `.zshrc` に追加

    export PATH=$HOME/.nodebrew/current/bin:$PATH

ディレクトリを作成

    $ mkdir -p ~/.nodebrew/src

Node.js のインストール(安定版)

    $ nodebrew install-binary stable
    $ nodebrew use stable

以上です。

ちなみにパッケージのインストールは以下のようにします。

    $ npm install bower -g # -g はグローバルオプション

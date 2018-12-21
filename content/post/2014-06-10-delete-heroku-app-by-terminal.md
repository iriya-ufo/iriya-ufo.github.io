---
layout: post
title: コマンドから Heroku アプリを削除
slug: delete-heroku-app-by-terminal
date: 2014-06-10T01:35:28+00:00
comments: true
categories:
  - "programming"
tags:
  - "heroku"
---

Heroku に作ったアプリをコマンドから削除する方法です。GUI画面から削除するより簡単で、git remote の設定の削除なども一緒にしてくれるのでコマンドで削除するのがオススメです。
なお Heroku アプリを削除するとそのアプリで使っていたオプションなども根こそぎ削除されるので気をつけてください。

以下のコマンドで削除できます。

    $ heroku apps:info # アプリの確認
    $ heroku apps:destroy --app アプリ名

### 参考
[Heroku でよく使うコマンド一覧](http://morizyun.github.io/blog/heroku-postgresql-useful-commands/)

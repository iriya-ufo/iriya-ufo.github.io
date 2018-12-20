---
layout: post
title: Mac OS X で locate エラーの直し方
slug: fix-locate-error
date: 2014-06-07T22:35:26+00:00
comments: true
categories: programming
tags:
  - mac
  - shell
---

Linux でお世話になってるファイルを探すコマンドの `locate` ですが、当然 Mac にもあります。
しかしデータベースを更新するコマンドが違ってて Linux だと `updatedb` ですが Mac は `/usr/libexec/locate.updatedb` になります。
毎回コマンドを打つのはたるいのでエイリアスを張っていたのですが、あるときうまくDBが更新されていないようだと気づきました。
こんなエラーがでます。

    $ updatedb 
    Password:
    mktemp: too few X's in template ‘updatedb’
    chown: missing operand after ‘nobody’
    Try 'chown --help' for more information.
    shell-init: error retrieving current directory: getcwd: cannot access parent directories: Permission denied
    shell-init: error retrieving current directory: getcwd: cannot access parent directories: Permission denied
    shell-init: error retrieving current directory: getcwd: cannot access parent directories: Permission denied
    /usr/libexec/locate.updatedb: line 97: /var/db/locate.database: Permission denied
    rm: missing operand
    Try 'rm --help' for more information.

こいつの原因は GNU 由来の mktemp が Mac デフォルトの mktemp と動作が違うためのエラーのようです。そういえば coreutils をインストールしたんでした。

いくつか解決策は考えられそうです。もしかしたら他のコマンドも GNU と BSD の違いで気付かずにエラーが発生してる可能性がありそうなので、GNU コマンドを使いたい場合はコマンドの先頭に `g` を明示的につけて実行することにします。
ということで今まで設定していた以下の一行を消すことにしました。
    
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

これで無事解決です。

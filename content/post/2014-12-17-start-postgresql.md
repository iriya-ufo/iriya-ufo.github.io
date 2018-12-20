---
layout: post
title: PostgreSQL の基本
date: 2014-12-17T21:43:32+00:00
comments: true
categories: programming
tags: postgresql
---

環境は Mac でやってますが Linux でもほぼ同じです。

## インストールから初期設定まで
Mac なので brew でインストールします。

    $ brew install postgresql

最初にデータベースの初期化をします。

    $ initdb /usr/local/var/postgres -E utf8

試しに PostgreSQL サーバーの起動を確認してみます。

    $ postgres -D /usr/local/var/postgres

起動に問題なければ、環境変数の設定をします。`.zshrc` とか `.bashrc` とかに追記してください。

    export PGDATA=/usr/local/var/postgres

マシン立ち上げと同時に起動しておくようにします。Linux だとディストリビューションによるので割愛します。

    $ cp /usr/local/Cellar/postgresql/9.*.*/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
    $ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

これで準備ができました。


## データベース準備の基本
データベースの一覧を取得します。

    $ psql -l

デフォルトで postgres , template0 , template1 のデータベースが用意されています。

ユーザーの作成をしてみましょう。

    $ createuser -a alice

データベースの作成をしてみましょう。

    $ createdb -E UTF8 -O alice alice_db

作成したデータベースに接続してみましょう。

    $ psql -U alice alice_db
    psql (9.3.2)
    Type "help" for help.

    alice_db=#

このようにDB名のプロンプトに切り替わったら成功です。


## 基本のコマンド
psql で使う基本的なコマンドです。"バックスラッシュ + 1文字"というコマンドはなかなか覚えられないですね。英語の先頭文字と結びつけて覚えるのが近道です。
<table>
<tr><th>コマンド</th><th>説明</th></tr>
<tr><td>¥q</td><td>psqlを終了</td></tr>
<tr><td>¥d</td><td>テーブルやシーケンスの一覧を全て表示</td></tr>
<tr><td>¥dt</td><td>テーブルの一覧を表示</td></tr>
<tr><td>¥ds</td><td>シーケンスの一覧を表示</td></tr>
<tr><td>¥z</td><td>アクセス権を含めてテーブルの一覧を表示</td></tr>
<tr><td>¥l</td><td>データベースの一覧を表示</td></tr>
<tr><td>¥i</td><td>ファイルに書かれたSQL文を読み込んで実行</td></tr>
</table>


## 素晴らしいサイト
PostgreSQL を練習するのにすばらしいサイトがありますので紹介します。こちらです。
<a href="http://pgexercises.com/" title="PostgreSQL Exercises" target="_blank">PostgreSQL Exercises</a>

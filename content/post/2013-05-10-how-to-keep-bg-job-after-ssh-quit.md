---
layout: post
title: SSH 接続が切れた後でもバックグラウンドジョブを継続させる方法
date: 2013-05-10T08:47:32+00:00
comments: true
categories: programming
tags: unix
---

サーバーに SSH でログインしている時に、長い時間のかかるプロセスを起動しちゃうと、ふと SSH 接続が切れたりしたらそのプロセスも道連れになって困ります。
また普通にバックグラウンドジョブとして動かしてもだめです。
以下のように `nohup` シグナル送ってプロセスとして動かし続けてあげたら大丈夫です。

    $ nohup command [arg...] &

詳しくは『[ログアウトしてもバックグラウンド ジョブを継続する方法](http://www.codereading.com/notebook/moin.cgi/IgnoreTheHangupSignal)』を参照してください。
さらに詳しく知りたい場合は『[なぜnohupをバックグランドジョブとして起動するのが定番なのか？](http://www.glamenv-septzen.net/view/854)』を参照するとよいです。

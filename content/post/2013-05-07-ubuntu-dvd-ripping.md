---
layout: post
title: "Ubuntu で DVD リッピング"
slug: ubuntu-dvd-ripping
date: 2013-05-07T17:29:47+00:00
comments: true
categories:
  - "programming"
tags:
  - "ubuntu"
---

Ubuntu で DVD をリッピングする方法はいくつかあります。

- k9copy
- dvd::rip
- wine で DVD Decrypter

私の環境ではいずれもうまくいきませんでした。最終的にコマンドラインから丸ごと iso イメージとして取り出す方法がうまくいったので書いておきます。環境は Ubuntu 12.04 LTS です。

まずデバイスファイルを調べます。

    $ wodim --devices
    wodim: Overview of accessible drives (1 found) :
    -------------------------------------------------------------------------
     0  dev='/dev/sg1'	rwrw-- : 'Optiarc' 'DVD RW AD-7710H'
    -------------------------------------------------------------------------

マウントされていれば外しておきます。

     $ sudo umount /dev/sg1

iso ファイルを作成します。

    $ readom dev=/dev/sg1 f=filename.iso

iso ファイルが作成されているので後はそれを VLC などを使って再生すると観られます。

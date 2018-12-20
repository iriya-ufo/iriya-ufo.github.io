---
layout: post
title: "Deep Learning Machine に Ubuntu のインストール"
slug: install-ubuntu-to-deep-learning-machine
date: 2016-11-10 01:38:43 +0900
comments: true
categories: machine_learning
---

[『Hardware Architecture for Machine Learning』]({% post_url 2016-11-09-hardware-architecture-for-machine-learning %})で作ったマシンに Ubuntu 16.04 LTS をインストールしました。

Nvidia GTX-1080 を使っていたせいで、インストーラーが表示されず躓いたのでその解決法を記載します。

状況としては Ubuntu 16.04 を DVD に焼いたあと起動するも、インストーラー画面までいかずに `snd_hda_intel failed to add i915_bpo component master` というエラーが出て落ちていました。

まず BIOS の設定でマルチモニターを有効化します。具体的には `BIOS起動` → `Advanced` → `Chipset Configration` → `IGPU Multi-Monitor` を `Enable` に変更します。
そして、いったんマシンの電源を切り、HDMI をマザーボード側に繋ぐとインストーラーが起動しました。

インストーラー画面は問題なく進んでいき、Ubuntu のインストール自体は正常に終了します。
ところが再起動がかかると画面に何も映りません。マザーボード側、グラフィックボード側とどちらに挿してもダメでした。
これは Nvidia GTX-1080 のドライバが入っていないためらしいです。困ったことにドライバを入れようにも画面に映らないので、とにかく Ubuntu の画面を出してコマンドが打てるようにするため
グラフィックボードを一度筐体から取り外します。そして再起動すると Ubuntu が起動しました。

ターミナルから以下のコマンドでドライバーをインストールします。

    $ sudo add-apt-repository ppa:graphics-drivers/ppa
    $ sudo apt-get update
    $ sudo apt-get install nvidia-367
    $ sudo apt-get install mesa-common-dev
    $ sudo apt-get install freeglut3-dev

これで、グラフィックボードをつけて再起動すれば Ubuntu が起動します。

次回は[『GPU 経由で TensorFlow を実行』]({% post_url 2016-11-19-tensorflow-running-by-gpu %})できるようにします。

[『Deep Learning from scratch』]({{ root_url }}/products)

---
layout: post
title: Ubuntu に Android Studio をインストール
slug: android-studio-to-ubuntu
date: 2013-06-01T03:41:13+00:00
comments: true
categories:
  - "programming"
tags:
  - "android"
---

興味本位でいれてみました。
Ubuntu のバージョンは 12.04 です。

公式から Linux 版の tgz をダウンロードして解凍します。

[Getting Started with Android Studio](http://developer.android.com/sdk/installing/studio.html)

シェルに PATH を設定します。

```sh
# Android Studio
export PATH=$PATH:$HOME/Downloads/android-studio/bin
```

端末から以下を実行で起動します。
(ただ私の環境では JDK のエラーがでました。Android Studio は Oracle JDK 推奨ですが、Open JDK が入っていたためです。)

    $ studio.sh

上記コマンドで無事起動した方はいいとして、JDKでエラーが出た人のために解決策を書いておきます。
まず Open JDK 関連のパッケージを削除します。

    $ sudo apt-get purge openjdk-\* icedtea-\* icedtea6-\*
    $ dpkg -l # jdk 関連が削除されているかと思います

そして Oracle JDK をインストールします。

    $ sudo add-apt-repository ppa:webupd8team/java
    $ sudo apt-get update
    $ sudo apt-get install oracle-java6-installer

また複数のバージョンの JAVA を入れた場合に、バージョンを切り替えたい場合は、下記のようにします。

    $ sudo update-alternatives --config java

これで Android Studio が起動できました。
後は **New Project** をクリックしてプロジェクトを作成します。
実際の開発では種々の Android バージョンに対応できるようにするため、ツールバーから **SDK Manager** をインストールしておくとよいでしょう。

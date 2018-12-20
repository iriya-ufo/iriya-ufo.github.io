---
layout: post
title: '&lt;unknown&gt;:0: error: the SDK &#8216;MacOSX10.9.sdk&#8217; does not support Swift'
date: 2014-08-24T18:13:51+00:00
comments: true
categories: programming
tags:
  - mac
  - swift
  - xcode
---

Xcode6-beta6 にて swift をコマンドラインから起動するとタイトルの通りのエラーがでます。

    <unknown>:0: error: the SDK 'MacOSX10.9.sdk' does not support Swift

MacOSX 10.9 というのは Mavericks ですね。どうやら最新の Xcode は古い sdk はサポート対象外ということで起動すらできません。さすが Apple 切り捨て方が潔い。さてどうやって起動するかというと、Xcode6 に付随している最新の sdk を使うように swift の起動オプションに渡してあげたら大丈夫です。以下コマンドです。

    $ /Applications/Xcode6-Beta6.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift -target x86_64-apple-macosx10.9 -sdk /Applications/Xcode6-Beta6.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk

また Xcode のバージョンアップをした人は[「Swift をとりあえず実行するまでの手順」]({% post_url 2014-07-23-quick-start-swift %})の「コマンドラインから実行する」で雑多な設定をやってあげるといいでしょう。

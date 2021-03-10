---
layout: post
title: Swift をとりあえず実行するまでの手順
slug: quick-start-swift
date: 2014-07-23T03:06:46+00:00
comments: true
categories:
  - "programming"
tags:
  - "swift"
  - "xcode"
---

<img src="/images/2014/07/swift.png" class="image">

WWDC2014 にて発表された Apple の新言語 Swift が話題になっています。これから iOS アプリを開発するなら間違いなく Swift が使えるようになる必要がありますね。ここでは Swift に関する情報のまとめと簡単なプログラムを Swift で実行するまでの流れを書きたいと思います。

## 情報まとめ
まず最初にブックマークしておくべきサイト達です。たびたび覗きにくることになるでしょう。

- [公式サイト - The Swift Programming Language](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)
- [iPhone Tutorials](http://www.raywenderlich.com/tutorials)
- [作って学ぶSwift/iOSアプリ入門](http://tech.camph.net/?p=363)
- [Swift を学べる記事のまとめ](http://dev.classmethod.jp/smartphone/iphone/learn-swift/)
- [Swift Cheat Sheet](http://kpbp.github.io/swiftcheatsheet/)

## Xcode で実行する
Swift を実行するには Xcode 6 beta が必要です。コマンドラインから swift を実行する方法は後述します。まずここから<a href="https://developer.apple.com/xcode/downloads/" title="Download Xcode" target="_blank">ダウンロード</a>してください。Xcode 6 beta のインストールにはデベロッパープログラムに入らないといけないので事前に登録しておきましょう。頻繁にアップデートされていくと思うので時々チェックするといいでしょう。ちなみに Xcode4 から Xcode5 にアップデートした際にアプリケーション一覧で Developer からコンポーネントがいくつかなくなっていると思います。インストール場所が `/Developer` から `/Applications` に変更されたためです。LaunchPad に表示されるのもうっとおしいので削除しましょう。削除の仕方は<a href="http://lv4.hateblo.jp/entry/2013/10/06/230858" target="_blank">こちら</a>から。

脱線したので戻します。先ほどダウンロードしてきた Xcode 6 beta をインストールしましょう。いつものように dmg ファイルを起動して Applications フォルダーに移すだけです。インストールが終わったら早速起動してみましょう。起動したら Welcome 画面が出てくるのでおもむろに閉じます。

まず File > New > Project を選択し、iOS の「Single View Application」を選択して、Next ボタンを押します。そして Project 名の入力と Language に Swift を選択して Next ボタンで進みます。保存場所を聞かれるので任意の場所を決めます。

画面が立ち上がりますので `ViewController.swift` ファイルの中の `override func viewDidLoad()` の場所に `println("Hello, World")` を記述します。これで実行するとシミュレータ上で `Hellow, World` が表示されます。

以上駆け足で Xcode で Hello, World をやってみました。実行まで結構面倒くさいですね。でも安心してください Swift はコンパイラプログラミング言語だけど、Xcode の Playgrounds の上やターミナルでインタラクティブにデバッグする事が可能になっています。Playgrounds のやり方は割愛させて頂きますが、コマンドラインから Swift をインタラクティブに行う方法を述べます。

## コマンドラインから実行する
Swift REPL は以下のようにして実行できます (Xcode のインストールが必要)。

    $ /Applications/Xcode6-Beta4.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift
    Welcome to Swift!  Type :help for assistance.
    1>

毎回打つのはめんどくさいのでシェルのエイリアスに登録しておくとよいでしょう。

また `xcrun` というコマンドを使うと Xcode 周りの面倒をいい感じに見てくれるらしいので Swift REPL を使うときはセットでの使用をオススメします。
使い方は簡単で以下のようにするだけです。

    $ xcrun swift

もしエラーが出るような場合 Xcode の PATH が見つけられていないので、下記のようにして正しく設定します。

    $ sudo xcode-select -switch /Applications/Xcode6-Beta.app/Contents/Developer

これでコマンド引数にファイルを与えてあげるとバイナリーが生成されるようなのでそいつを直接実行してやるといいですね。

以上コマンドラインツールからの実行でした。

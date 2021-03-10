---
layout: post
title: Slack に Hubot をいれてみた
slug: hubot-on-slack
date: 2016-03-04T18:10:03+00:00
comments: true
categories:
  - "programming"
tags:
  - "hubot"
---

Hubot は GitHub が開発した bot のフレームワークです。Node.js の上で走って CoffeeScript で動きます。実装環境は AWS にしました。常時稼働させとかなきゃいけないからね。

インストール方法はここを参考にします。参考というかまるパクリです。先人の知恵ってありがたい。あざーす！！

- [hubotと戯れてみる #1 slackと連携するhubotを3分でインストールする。（動画付き）](http://bitwave.showcase-tv.com/slack%E3%81%A8%E9%80%A3%E6%90%BA%E3%81%99%E3%82%8Bhubot%E3%82%923%E5%88%86%E3%81%A7%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB/)

Hubot の起動が確認できたらバックグラウンド (デーモン) で動かしたいと思うのが人間の心理です。最初はうんこなスクリプト書いてたらいろいろめんどくさくなったのでまじめにググりました。そしたらやっぱりありましたね。先人さん、まじあざーす！

- [hubotと戯れてみる #番外編 hubotをデーモン化する](http://bitwave.showcase-tv.com/hubot%E3%81%A8%E6%88%AF%E3%82%8C%E3%81%A6%E3%81%BF%E3%82%8B-%E7%95%AA%E5%A4%96%E7%B7%A8-hubot%E3%82%92%E3%83%87%E3%83%BC%E3%83%A2%E3%83%B3%E5%8C%96%E3%81%99%E3%82%8B/)

あとここを参考にすると、かんなちゃん画像スクリプトとか寿司スクリプトとか書けます。

- [こんな僕でも30分でSlackのbotを作れた。](http://lab.aratana.jp/entry/2014/12/04/185053)

がっつりやりたい時はやっぱりドキュメント

- [HUBOT DOCUMENTATION](https://hubot.github.com/docs/)

なんというか全体的にただのリンクになってしまっただけですが、これで bot 事始めが出来ますね。やったね。

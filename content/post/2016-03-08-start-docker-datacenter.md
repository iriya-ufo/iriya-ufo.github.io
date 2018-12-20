---
layout: post
title: Docker DataCenter さわってみた
date: 2016-03-08T04:38:29+00:00
comments: true
categories: programming
tags: docker
---

{% img /images/2016/03/ddc.png %}

以下の記事をみかけて、これはやらずにいられないと思っていじってみた感想。

- [コンテナ化したアプリケーションの総合的一元的管理コンソールDocker DatacenterをDockerが提供](http://jp.techcrunch.com/2016/02/24/20160223new-docker-data-center-admin-suite-should-bring-order-to-containerization/)

## インストール
AWS に small 環境でつくってみた。Amazon Linux だとうまくいかなかったので Ubuntu でやり直した。
インストールの方法は以下の通り。(画像のみですが・・・

### ステップ 1
Ubuntu なので DEB の内容をコピペ。

{% img /images/2016/03/ddc1.png %}

### ステップ 2
UCP のインストールはすっ飛ばしでOK。ここまでで https://your-ip-address で接続できる。すごい！

{% img /images/2016/03/ddc2.png %}

### ステップ 3
ライセンスファイルをダウンロードして先ほどの画面の Settings > Licenses でアップロードして完了。

{% img /images/2016/03/ddc3.png %}

### ステップ 4
こっから先はドキュメントみてね的な何か。

{% img /images/2016/03/ddc4.png %}

## 管理画面
こんな感じの管理画面ができる。たぶんここにレポジトリ作っていけるんだと思う。これすごい便利。今後も使ってみたいけど1ヶ月1ノードでUSD150と少しお高いです。

{% img /images/2016/03/ddc-dashboard.png %}

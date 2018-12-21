---
layout: post
title: Meteor が想像以上にすごかった
slug: start-meteor
date: 2015-05-24T05:17:20+00:00
comments: true
categories:
  - "programming"
tags:
  - "meteor"
---

友人に勧められて、ウェブアプリケーションフレームワークの [Meteor](https://www.meteor.com/) で遊んでみました。想像以上にすごかったです。Meteor って聞いたことあるけどどんなの？って人のためにざっくり言うとこんな感じ。

## メリット
- 環境構築が圧倒的に楽。むしろ構築なにそれおいしいの？という感じ。
- 一行のコマンドで環境が用意でき、デプロイ機構まで内包してる。
- 明瞭なディレクトリ構成。それに沿うと JS や CSS ファイルのディレクトリ指定が必要ない。
- DB へのアクセスが容易。サーバーサイドの Collection は Mongo DB への API として振る舞う。
- クライアントサイドの DB 同期が秀逸。普段はブラウザのメモリーに展開されたデータへアクセスするので超高速。
- ログイン処理が1行で済んだ。
- パッケージ追加が簡単。
- Meteor だけで全て事足りる。しかしこれは Meteor 依存になるためデメリットでもある。
- プロダクトサーバーへのデプロイも Meteor のコマンドでパッケージ化してあげればいいだけ、かついい感じに minimize してくれる。

## デメリット
- Meteor 全てに依存する。ただしこれは Meteor だけ考えておけばよいというメリットでもある。
- Meteor が全て内包してるのでフロントエンド、バックエンドを切り離したサーバー構成とかが難しい。
- データベースは基本的に Mongo だけ。
- 日本語の情報がすくない。

## 所感
- きっちりリリースするプロダクトでは使わないほうがいい。使い捨てか超光速プロトタイプ向け。
- DB が Mongo な点でお察し。(※ 別に Mongo が悪いわけじゃないです。向き不向きをきちんと理解しておくということです)
- [Spacebars](https://github.com/meteor/meteor/blob/devel/packages/spacebars/README.md) が気持ち悪い。

**ここまで読んだうえでちょっと触ってみたい、という人は以下に進みましょう。**

## Meteor アプリを動かすまで
こちらの[チュートリアル](https://book.discovermeteor.com/chapter/getting-started)が素晴らしいです。英語ダメとか言わずに読みましょう。

## インストール
一行瞬殺です。

    $ curl https://install.meteor.com | sh

## アプリの作成と起動
任意のディレクトリにて

    $ meteor create microscope
    $ cd microscope
    $ meteor

http://localhost:3000 にアクセスすると起動確認できます。

## パッケージの追加
**bootstrap** と **underscore** をいれてみます。Meteor は公式にあるものはそのまま追加でき、無いものは Github のグループ名またはユーザー名を : (コロン) の前につけて指定するようです。

    $ meteor add twbs:bootstrap
    $ meteor add underscore

## ディレクトリとファイル構成
[こちら](http://docs.meteor.com/#structuringyourapp)の通りにしてください。とりあえず `/client`, `/lib`, `/public`, `/server` があればいいです。

## デプロイ
主な方法は3つです。所感に書いた通りプロダクトリリースは今のところ想定してないので 1. を採用しています。

### 1. Meteor.com にデプロイ

    $ meteor deploy app-name.meteor.com

これだけで自分の好きな名前でデプロイできます。当然一意の URL である必要があります。パスワードも何も聞かれないので設定しておくとよいでしょう。
また独自ドメインで運用したい場合は適用したいドメインの CNAME を origin.meteor.com に向けます。dig コマンドなどで CNAME が有効になっていることが確認できたら以下コマンドでデプロイします。

    $ meteor deploy your-domain-name.com

【補足】
デプロイに meteor.com を使用した場合はこんな感じでサーバーの様子が見れます。

    $ meteor mongo myApp
    $ meteor logs myApp

### 2. PaaS でデプロイ
Meteor をサポートしてる PaaS は知ってる限りだと [Modulus](http://help.modulus.io/customer/portal/articles/1647770-using-meteor-with-modulus) くらいです。独自ドメインはもちろん、SSL なんかもサポートしていますが、金額が高いです。

### 3. Meteor Up コマンドでデプロイ
**mup** というデプロイのコマンドユーティリティがあります。**npm** でインストールして任意のサーバーに push する感じです。デプロイ先サーバーは [DigitalOcean](https://www.digitalocean.com/) か [AWS](http://aws.amazon.com/jp/) がオススメです。

メリット・デメリットに書いた通りリリース前提の本番環境で使うには難しいと思いますが、ガチでやるなら AWS と Elastic BeansTalk なんかを使うのがいいかも。

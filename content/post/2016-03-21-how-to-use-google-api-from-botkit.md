---
layout: post
title: Botkit から Google API 叩いてみた
slug: how-to-use-google-api-from-botkit
date: 2016-03-21T01:34:27+00:00
comments: true
categories: programming
tags:
  - botkit
  - google api
  - nodejs
---

前回『Slack に Hubot をいれてみた』という記事を書きました。今回は Botkit をインストールして遊んでみました。Hubot と Botkit の違いはこんな感じです。

### Hubot
GitHub が開発した Bot 開発用のフレームワーク
Node.js で動き、プラグインなどは CoffeeScript で書く

### Botkit
howdyai が開発した Slack 特化の Bot 開発用フレームワーク
Node.js で動き、プラグインなどは JavaScript で書く

Hubot の方がフォルダ構成などはシンプルな感じです。Botkit は Slack がサポートしているということもあってか Slack との連携が非常にやりやすいです。Slack の公式 Bot アプリを作りたい場合などは Botkit 一択ですね。

## Node.js インストール
Botkit は Node.js で動作するのでまず Node.js の環境構築が必要です。AWS に構築します。ローカルでやりたい人はローカル上で Node.js が動く環境まで構築しておきましょう。

ではまず AWS にインスタンスを作って SSH できるようにしておきます。

Node.js をインストールします。パッケージもありますがバージョン管理したいので nvm でインストールします。

    $ git clone https://github.com/creationix/nvm.git ~/.nvm
    $ source ~/.nvm/nvm.sh

これで nvm が使えます。続けて Node.js をインストールします。

    $ nvm ls-remote # バージョン確認
    $ nvm install 5.9.0
    $ node -v # 確認

nvm でバージョンリストを出した時に v0.12.x 系 と v4.x.x や v5.x.x などの大きく乖離したバージョンが表示されたかと思います。これは Node.js から派生したプロジェクトの io.js が混ざっているためです。元々は Node.js からフォークして開発が進んだ io.js ですが、今は Node.js との互換性を持ちながら開発が進んでいるとのことなのでこちらを使うことにしました。不安な人は 0.12.x 系を使っておくといいと思います。

次にバージョンのデフォルト設定などをします。

    $ nvm alias default v5.9.0

次回ログイン時も node コマンドが使用できるようにするため `.bashrc` に以下を追記します。

    if [[ -s ~/.nvm/nvm.sh ]];
      then source ~/.nvm/nvm.sh
    fi

ここまでで Node.js の環境構築が終わりました。

## Botkit インストール
こちらの記事に丁寧に書かれています。ローカルユーザーで動かしたかったので sudo はつけませんでした。

- [BotkitでSlackのBotをサクッと作る方法](http://toach.click/2016/01/10/slack-botkit/)

使い方などは公式を参照しましょう。

- [Botkit 公式](https://github.com/howdyai/botkit)

## Google Calendar API を叩いてみる
では、Google API を叩いてみます。Google Developers サイトに Node.js からカレンダー API を叩くサンプルがあるのでその通りすれば動きます。

- [Node.js Quickstart](https://developers.google.com/google-apps/calendar/quickstart/nodejs#prerequisites)

大まかな流れはだいたいこんな感じです。

- Google Developers Console でプロジェクトを作成
- ダッシュボードから「APIを利用する」をクリック
- CalendarAPI を探して「有効にする」をクリック
- 認証情報をクリック ※「認証情報に進む」だとうまくいかないので左側のペインから選択する
- 認証情報を作成 => OAuth Client ID をクリック
- 同意画面に進み、メアド、サービス名を入力して保存
- クライアント ID の作成で「その他」を選び名前は"Google Calendar API Quickstart"とする
- json ファイルができるのでダウンロードする
- `client_secret.json` という名前で botkit の直下に置く
- google パッケージをインストールする 

```
$ npm install google-auth-library --save
$ npm install googleapis --save
```
- サンプルプログラムを置いて下記コマンドを打つ

```
$ node quickstart.js
```

- 初回起動時はターミナルに URL が貼ってあるのでそこにアクセスし、アクセプトする
- 認証に必要なコードが帰ってくるので、それをターミナルに貼って Enter
- カレンダーに予定があれば API 経由でデータが取れる
- 認証情報は `~/.credentials/` の `calendar-nodejs-quickstart.json`

以上です。とても簡単でした。Node.js は初めて触ってみましたけど Rails に比べてシンプルですね。まぁ View とかやってないし API しか叩いてないので比べるのもおかしな話しですが。今後は本番構成はどうするべきか調べてやってみたいと思います。

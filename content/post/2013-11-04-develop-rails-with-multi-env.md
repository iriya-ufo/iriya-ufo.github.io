---
layout: post
title: 複数の環境で Rails を開発する
slug: develop-rails-with-multi-env
date: 2013-11-04T00:15:10+00:00
comments: true
categories: programming
tags:
  - gem
  - git
  - heroku
  - mac
  - postgresql
  - rails
  - ubuntu
---

普段は MacOS 使って Rails いじってますが Ubuntu を使った時も同じように開発できたらなと思ったのでやり方を書きます。また開発環境は以下を想定しています。
<ul>
  <li>既存の Rails プロジェクトのコードは github で管理</li>
  <li>Rails アプリは heroku で公開</li>
  <li>これから述べる環境構築は Ubuntu プラットフォームの話</li>
</ul>
また Ubuntu に開発環境が一切入ってない状態の場合、たくさんインストールすべきものがあるのでここでは割愛します。あくまで私の環境だとこうやれば動いたということです。

## ローカル開発環境を整える
まず既存のアプリを github からクローンします。
    
    $ git clone "https://github.com/yourname/app.git"

gem を揃えるため `$ bundle update` します。私の環境では Ubuntu に PostgreSQL Server がないよとエラーが出たので psql をインストール後 `$ bundle update` しました。

    $ sudo apt-get install postgresql postgresql-server-dev-9.1
    $ rehash
    $ bundle update

ここで Rails サーバーを起動してみると JavaScript runtime error が出ました。私は以下をインストールしましたが nodejs があるので therubyracer は必要ないかもしれません。

    $ gem install therubyracer # nodejs があるので必要ないかも
    $ gem install execjs
    $ sudo apt-get install nodejs

マイグレーションの実行をします。
    
    $ bundle exec rake db:migrate RAILS_ENV=development

ここまで出来ればローカルアクセスで Rails アプリが動作すると思います。

## Heroku で動かす
アプリは heroku という PaaS で公開します。普段は MacOS の開発環境から heroku にアクセスしていますが、Ubuntu でも同様に heroku に push できるようにしたいと思います。

まず `~/.ssh` に USB などで rsa キーをコピーしてきます。なお heroku 用にデフォルトとは別の名前でキーを保存した場合、config ファイルも必要となります。
config ファイルはこんな感じ。

    Host heroku.com
     User git
     port 22
     Hostname heroku.com
     IdentityFile ~/.ssh/heroku_rsa
     TCPKeepAlive yes
     IdentitiesOnly yes

このまま `$ heroku open` しても No app specified. と言われます。
解決方法は簡単で git remote でリポジトリを追加すればOKです。

    $ git remote add heroku git@heroku.com:blooming-wildwood-xxxx.git

### 参照
<a href="http://d.hatena.ne.jp/cybaron/20111002/p1" title="複数パソコンからherokuの同一サービスにデプロイする方法" target="_blank">複数パソコンからherokuの同一サービスにデプロイする方法</a>

以上です。

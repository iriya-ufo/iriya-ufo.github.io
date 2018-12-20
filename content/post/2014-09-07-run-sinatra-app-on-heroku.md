---
layout: post
title: Sinatra アプリを Heroku で動かすまで
slug: run-sinatra-app-on-heroku
date: 2014-09-07T17:32:36+00:00
comments: true
categories: programming
tags:
  - heroku
  - postgresql
  - sinatra
  - unicorn
---

## 環境
以下のような環境で動かします。
<ul>
  <li>Sinatra</li>
  <li>Heroku</li>
  <li>PostgreSQL</li>
  <li>Unicorn</li>
  <li>ActiveRecord</li>
</ul>

## 初期設定
まず Ruby と Git などの環境を整えます。環境が構築できたら Sinatra で作るアプリ用にディレクトリを作ります。そこで `$ bundle init` して Gemfile を作成します。

```ruby
source "https://rubygems.org"
ruby '2.0.0'

gem 'sinatra'
gem 'haml'
gem 'unicorn'
gem 'pg'

# ActiveRecord
gem 'sinatra-activerecord'
gem 'activerecord'

group :development, :test do
  gem 'rake'
  gem 'sinatra-contrib'
  # Foreman
  # To run the app from Procfile.
  gem 'foreman'
end
```

Gemfile ができたらおなじみの以下コマンドで gem をインストールします。

    $ bundle install --path vendor/bundle --without production

## Heroku で動かすために
次に Heroku で動作させるために必要な設定を行っていきます。`config.ru` と `unicorn.rb` と `Procfile` の3つが必要です。ちなみに Gemfile に foreman という gem があったかと思いますが、こいつは Procfile を読み込むことで複数のプロセスを管理できるツールです。こちらに詳しく書いてくれています。

<a href="http://qiita.com/7kaji/items/6a59977d2ad85604e7fd" title="foraman でアプリケーションを動かす" target="_blank">foreman でアプリケーションを動かす</a>

```ruby config.ru
require './main.rb'
run App.new
```

```ruby config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
```

```ruby Procfile
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
```

## ローカルで動作確認
ここで一度ローカルで動かしてみましょう。Sinatra のルートディレクトリにおいて `main.rb` などの名前でファイルを作成してみます。

```ruby main.rb
require 'sinatra'
require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    'Hello, World!'
  end
end
```

foreman という gem で起動してみます。
    
    $ bundle exec foreman start

これで http://localhost:5000 にアクセスすれば Sinatra アプリの動作確認ができるかと思います。

## Heroku にデプロイ
ここまでのアプリを一度 Heroku にデプロイしてみましょう。

    $ heroku create APP_NAME
    $ git add .
    $ git commit -m "first commit"
    $ git push heroku master

問題がなければ http://APP_NAME.herokuapp.com で公開されているでしょう。

## PostgreSQL を使う
さてここからデータベースを使った Sinatra アプリの作成に移ります。上記の Heroku デプロイまでは比較的つまづくことなくできるのですが、DBを使う段階で少し嵌ってしまいました。最初は `database.yml` を使う方向で実装していたのですが(他のサイトでもそのようにしているところがたくさんある)うまくいきません。というのも Heroku はどうやら `database.yml` を自動的に作成するらしくそちらの設定がうまくできなかったためです。なので今回は使わない方向で実装しています。

下準備として PostgreSQL でデータベースを作成しておきましょう。ローカルに構築する方法は割愛します。Heroku 上に作成するには以下のようにします。

    $ heroku addons:add heroku-postgresql:dev

できたら Rakefile を作成します。

```ruby Rakefile
require './main.rb'
require 'sinatra/activerecord/rake'
```

次にローカルでマイグレーションファイルを作成します。適当に users テーブルを作ることとします。

    $ bundle exec rake db:create_migration NAME="create_users"

`db/migrate` 配下にマイグレーションファイルが作成されているのでこれを編集します。

```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :registration_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
```

## データベースに接続
この段階で `database.yml` に DB の接続情報を設定して作業したのですが、ローカルではうまくいくものの Heroku で動きませんでした。なので DB の接続情報を `main.rb` ではなく `models/ar.rb` というファイルに切り出すことにしました。`ar.rb` を以下のようにしましょう。

```ruby models/ar.rb
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

class Ar < ActiveRecord::Base
end
```

ここでのポイントは DATABASE_URL です。Heroku はこの値に設定された URL をデータベース先として接続しにいきます。`$ heroku config` とすれば確認できます。
またローカルで起動したときには DATABASE_URL はローカルの PostgreSQL に接続して欲しいですね。そのようにするためには `.env` ファイルを作成してそこに設定すればいいです。`.env` ファイルは `.gitignore` に追加しておきましょう。

```ruby .env
DATABASE_URL='postgresql://user_name:@localhost/db_name'
```

マイグレーションファイルに従ってデータを作成します。

    $ bundle exec rake db:migrate

ここまで問題なくできればローカルの環境は終わりです。最後に Heroku にアップしましょう。

## 再度 Heroku にデプロイ
さて、いよいよです。コマンドが通ることを祈ってデプロイしてください。

    $ git push heroku master

## 参考
本記事を書くにあたって参考にさせて頂いたサイトです。ありがとうございました。
<ul>
  <li><a href="http://dev.classmethod.jp/server-side/ruby-on-rails/sinatra-postgresql-unicorn-on-heroku/" target="_blank">[Ruby] Sinatra + PostgreSQL + Unicorn な Web サーバーを Heroku に構築する</a></li>
  <li><a href="http://blog.notsobad.jp/post/60131290938/sinatra-heroku-db" target="_blank">Sinatra x HerokuのDB設定をいい感じにする。</a></li>
  <li><a href="http://qiita.com/myokkie/items/6f65db5d53f19d34a27c" target="_blank">Sinatra-ActiverecordをHerokuにPushする</a></li>
</ul>

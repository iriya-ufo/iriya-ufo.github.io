---
layout: post
title: Ruby on Rails 4 のアプリを Heroku で公開する
slug: ruby-on-rails-4-to-heroku
date: 2013-05-28T18:00:47+00:00
comments: true
categories: programming
tags:
  - gem
  - git
  - heroku
  - homebrew
  - mac
  - rbenv
  - ruby
  - rails
---

Rails 4 が出たということなので Heroku で公開するまでの手順を書いてみます。
環境構築は Mac OS X で行っています。

## 事前準備

パッケージ管理に Homebrew を使っています。ちょうどいい機会です、アップデートしておきましょう。
brew でインストールしておくといいのは git, rbenv, zsh といった感じでしょうか。

    $ brew update  # brew を最新にする
    $ brew upgrade # インストールしている Formula をアップデート
    $ brew doctor  # エラーなどのチェック

rbenv で Ruby 2.0.0 をインストールします。

    $ rbenv install 2.0.0-p195
    $ rbenv global 2.0.0-p195 # 2.0.0 をデフォルトにする

gem をアップデートして Rails 4 をインストールします。

    $ gem update --system
    $ gem update bundler
    $ gem i bundler
    $ gem search -r rails             # Rails のバージョンが検索できる
    $ gem i rails --version 4.0.0.rc1 # 検索コマンドで3系が表示された場合、4系のバージョン指定してインストール

## Rails アプリ作成

準備は整ったのでアプリを作ります。

    $ rails new rails_app

## Gemfile 編集

いくつかポイントを記しておきます。

- Heroku で Rails 4 を使うには `ruby "2.0.0"` の一行が必須です。
- 開発環境、テスト環境、プロダクション環境でそれぞれデータベースを分けています。
- ブラウザをリロードする手間を省くため [LiveReload](http://naoty.hatenablog.com/entry/2012/05/20/032251) を使っています。アドオンをインストールしておきましょう。
- foreman を使って環境変数をロードしています。

```ruby
source 'https://rubygems.org'

# Ruby 2.0.0 on Heroku
# Heroku で Rails 4 を使うために下の一行が必須です
ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

### Development and Test Setting
# 開発環境とテスト環境では sqlite3 を使うようにします
group :development, :test do
  # Use sqlite3
  gem 'sqlite3'

  # Testing framework
  gem 'rspec-rails'

  # Speeding up Testing
  gem 'spork'

  # Detect the change of file for OSX
  gem 'rb-fsevent'
end

### Development Setting
group :development do
  gem 'heroku'
 
  # Manage Procfile-based applications
  gem 'foreman'

  # Auto reload the browser when files are changed
  # ブラウザのオートロード
  gem 'guard-livereload'

  # Use debugger
  gem 'pry-rails'
end

### Production Setting
# Heroku は PostgreSQL が必須です
group :production do
  gem 'pg' # Heroku use PostgreSQL
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use Haml
gem 'haml-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
```

## 起動確認

Rails を立ち上げてブラウザから確認します。

    $ bundle update
    $ bundle install
    $ guard init livereload
    $ rails s # CTRL+C で終了

## GitHub に公開

ここからバージョン管理システムである Git を使って開発していきます。
ついでに GitHub にアップできるようにします。
準備として GitHub サイトで新規レポジトリを作成しておきます。その際 README ファイルは作らなくていいです。
また SSH Key などの登録をし、GitHub にアクセスできるようにしておきます。
そして Git で管理したくない余計なファイルを除くため `.gitignore` ファイルを編集します。

```
# Ignore un-needed files.
doc/
*.swp
*~
.DS_Store
.idea

# Template .gitignore file for Rails from github
*.rbc
*.sassc
.sass-cache
capybara-*.html
.rspec
.rvmrc
/.bundle
/vendor/bundle
/log/*
/tmp/*
/db/*.sqlite3
/db/*.sqlite3-journal
/public/system/*
/coverage/
/spec/tmp/*
**.orig
rerun.txt
pickle-email-*.html
.project
```

レポジトリを作って GitHub にアップします。

    $ git init
    $ git add .
    $ git commit -m "Initial commit"
    $ git remote add origin git@github.com:user-name/rails_app.git
    $ git push -u origin master

## Heroku を使う準備

まず Heroku のサイトへいって Sign Up します。
Mac OS X 用のツール(Toolbelt)をダウンロード、インストールします。
Heroku 用の SSH key を作成します。GitHub で作った鍵があればそれを使えばいいと思います。
私は別々に分けて作ったのでちょっとトラブルがありました。
デフォルトでは秘密鍵は `id_rsa` が読み込まれるようですが、Heroku 用に名前を変えて作ったためオートロードできなかったっぽいです。
よって `.ssh/config` を作ることで解決しました。

```
Host heroku.com
 User git
 port 22
 Hostname heroku.com
 IdentityFile ~/.ssh/heroku_rsa
 TCPKeepAlive yes
 IdentitiesOnly yes
```

Heroku にログインします。
    
    $ heroku login
    Email: # メールアドレスを入力します
    Password: # パスワードを入力します
    ssh-key: # 秘密鍵の場所を指定します

## Heroku にアプリを登録

Heroku には本番環境と開発環境を分ける方法があります。
Production 環境には Cedar Stack が使われます。
詳しくは『[Heroku Dev Center](https://devcenter.heroku.com/articles/cedar)』を参照してください。

まず heroku のバージョン確認しておきましょう。

    $ heroku --version # 2.1.0 以上であればデフォルトで Cedar スタックが使われます

Heroku にアプリを登録します。
app_name を指定すれば http://app_name.herokuapp.com のURLでアクセスできます。
指定しなければ適当な名前で作られますが、独自ドメインで運用するなら気にしなくてもいいでしょう。

    $ heroku create app_name
    $ bundle install --without production
    $ git push heroku master # ここで Gemfile に ruby "2.0.0" の追記がないとエラーで失敗します
    $ heroku run rake db:migrate
    $ heroku open # ブラウザーが起動し、作成した Rails アプリが開かれます

**The page you were looking for doesn't exist.** というメッセージがでますがこれでOKです。

## 独自ドメインで公開

このままだとアクセスする時の URL が覚えづらいので独自ドメインで運用します。
下記参照ください。

- [Qiita の投稿](http://qiita.com/icb54615/items/76acf2a1ea151535c5dc)
- [Heroku dev center Custom Domains](https://devcenter.heroku.com/articles/custom-domains)

ざっくりですが以上で Heroku に Rails 4 のアプリを公開できると思います。

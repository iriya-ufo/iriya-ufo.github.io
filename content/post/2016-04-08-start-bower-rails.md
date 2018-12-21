---
layout: post
title: bower-rails 使ってみた
slug: start-bower-rails
date: 2016-04-08T00:52:01+00:00
comments: true
categories:
  - "programming"
tags:
  - "ruby on rails"
---

Rails 開発で js とか css とかマジだるい。管理とかだるい。なので bower-rails 使ってみた。

## 事前準備
bower は node package なので最初に Node.js とかインストールしておく。

[Mac に Node.js インストールした]({% post_url 2016-04-07-nodejs-on-mac %})

## Rails で使う
Gemfile を書いて `$ bundle install` する。

    gem 'bower-rails'

## bower をインストールする

    $ bundle exec rails g bower_rails:initialize

これで Bowerfile と `config/initializers/bower_rails.rb` が生成される。

## 好きなパッケージをいれる
Bowerfile に入れたいパッケージを追加する。

    aseet 'bootstrap'

パッケージをインストールする。

     $ bundle exec rake bower:install

`vendor/assets/bower_components` 以下にいろいろ入る。

## assets path に追加する
`config/initializers/assets.rb` ファイルに以下を追加する。

    Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

## インクルードして使う
先ほどいれたパッケージをインクルードするには以下ファイルで require すればいい。

    app/assets/javascripts/application.js
    app/assets/stylesheets/application.css

## Tips
bower_components は git 管理しなくていいようなので `.gitignore` に追加する。

    /vendor/assets/bower_components

ちょっとした注意ですが、以下参考サイトより引用です。

> bowerに統一する必要がある

> jquery-railsなどのgemで管理しているjsやcssのライブラリはbowerで統一する必要がある
> だからjquery-railsは必要なくなる
> coffee-railsやless-railsやsass-railsはそのまま。gemで管理。
> 確かjquery-fileupload-railsなど、特定のgemは独自でjqueryのversionをfixしたりしているので、js系のライブラリはbowerに統一するのはすごく良さそう

## 参考
- http://qiita.com/reikubonaga/items/5a6037e067b79e5f9849
- http://blog.mah-lab.com/2014/04/14/bower-rails/

---
layout: post
title: Rails 4.0.0.rc1 から 4.0.0 にアップデートしたら嵌った
slug: update-rails-4-0-0-rc1-to-rails-4-0-0
date: 2013-11-03T04:24:00+00:00
comments: true
categories: programming
tags:
  - gem
  - mac
  - rbenv
  - ruby
  - rails
---

3系から4系のアップデートを参考にしたのだけれど、変にエラーが出て嵌ったので解決方法を書く。

## ruby アップデート
まず ruby を最新のバージョンにアップデートする。
ruby は rbenv で管理している。

    $ rbenv install 2.0.0-p247
    $ rbenv global 2.0.0-p247
    $ rbenv rehash
    $ ruby -v # バージョンの確認

## gem アップデート
    
    $ gem update --system
    $ gem update bundler
    $ gem i bundler

## Gemfile 編集
Rails アプリの Gemfile を編集します。
プロジェクトによって使ってる gem が違うと思うのであまり参考にならないかもしれません。
ポイントとしてはエラーがでた場合などは、インストール済みの gem のバージョンを固定するといいです。

```diff    
-gem 'rails', '4.0.0.rc1'
+gem 'rails', '4.0.0'

-gem 'sass-rails', '~> 4.0.0.rc1'
+gem 'sass-rails'

-gem 'bootstrap-sass'
+gem 'bootstrap-sass', '2.3.2.2'

-gem 'jbuilder', '~> 1.0.1'
+gem 'jbuilder', '1.0.2'
```

`$ bundle update` にて Rails をインストールして起動したらエラーメッセージがでました。

    /Users/iriya/.rbenv/versions/2.0.0-p247/lib/ruby/site_ruby/2.0.0/rubygems.rb:286:in `bin_path': can't find gem rails ([">= 0"]) with executable rails (Gem::GemNotFoundException)
    from /Users/iriya/.rbenv/versions/2.0.0-p247/bin/rails:23:in `<main>'

パスが無いよって言われました。
railties という gem をインストールすることで解決できました。
    
    $ gem i railties

以上です。

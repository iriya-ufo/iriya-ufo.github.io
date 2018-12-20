---
layout: post
title: Windows 7 64bit に Rails の環境を構築
date: 2014-05-08T23:39:00+00:00
comments: true
categories: programming
tags:
  - git
  - ruby
  - rails
  - windows
---

最初に言っておきますと Windows で Rails 開発することは全くオススメしません。Mac か Linux を使いましょう。それが分かった上で Windows でやるっていう人はとりあえずここを参考にしてもらえればと思います。

<a href="http://rubyinstaller.org/downloads/" target="_blank">『Ruby 2.0.0-p451 (x64)』</a>をダウンロードします。

以下インストールを行う際のポイント
<ul>
<li>PATH を追加するにチェックをいれる</li>
<li>C:\Ruby200-x64 にインストール</li>
</ul>

コマンドプロンプトで以下を行います。

    gem update --system
    gem update rake

先ほどの<a href="http://rubyinstaller.org/downloads/" target="_blank">リンク</a>から `DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe` をダウンロードします。
自己解凍形式のファイルなので `C:\DevKit` に解凍します。

コマンドプロンプトで以下を実行します。

    C:\DevKit\devkitvars.bat 
    gem install json --no-ri --no-rdoc
    gem install bundler
    > cd C:\DevKit
    > ruby dk.rb init # 生成された config.yml に Ruby のルートを指定
    > ruby dk.rb install

次は Git の環境を構築します。

http://msysgit.github.io/ から git をダウンロードします。

`C:\project` 配下に rails プロジェクトを作成します。

まず `$ bundle init` で Gemfile を作り編集します。

```ruby
source "https://rubygems.org"

gem "rails"
gem "tzinfo-data"
gem "sqlite3"
```

必要な gem をインストールします。

    $ bundle install --path vendor/bundle

起動確認します。

    $ bundle exec rails -v
    $ bundle exec rails new sample
    $ bundle exec rails s

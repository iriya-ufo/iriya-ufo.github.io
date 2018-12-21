---
layout: post
title: Rails のアップデート
slug: rails-update
date: 2013-05-12T04:22:10+00:00
comments: true
categories:
  - "programming"
tags:
  - "ruby on rails"
---

Ruby on Rails の 3.2.9 に脆弱性が発見されたため 3.2.11 にアップデートした際の方法を記す。

## Gem のアップデート

    $ sudo gem update --system
    $ gem -v
    1.8.24

## Rails のアップデート

    $ sudo gem update rails
    $ rails -v
    Rails 3.2.11

## 古い Rails をアンインストール

古いバージョンの Rails を削除します。新しいバージョンの Rails で動作確認していないなら、念の為に残しておいたほうがよいでしょう。

    $ sudo gem uninstall rails
    Select gem to uninstall:
    1. rails-3.2.9
    2. rails-3.2.11
    3. All versions
    > 1

## bundler のアップデート

    $ sudo gem update bundler

## 既存のプロジェクトのアップデート

既存のプロジェクトとの差分を確認するため、テストプロジェクトを作成します。

    $ rails new app_test

## 差分確認

既存アプリと新しく作ったアプリの Gemfile の diff を取って正しく編集する。

```diff
$ diff app_test/Gemfile app_rails/Gemfile
3c3
< gem 'rails', '3.2.11'
---
> gem 'rails', '3.2.9'
18c18
<   # gem 'therubyracer', :platforms => :ruby
---
>   gem 'therubyracer', '0.10.2'
```

## bundle のアップデート

    $ bundle update

## ビルドツール rake でアップデート

念の為、 config のバックアップを取ってから実行します。

    $ cp -r config config_old
    $ rake rails:update

## 設定ファイルのマージ

以下の設定ファイルを比較して編集する。

- `config/routes.rb`
- `config/application.rb`
- `config/environment.rb`
- `config/initializers/serect_token.rb`

環境によっては他にも編集すべきファイルがあるかと思います。以上で Rails のアップデートが終了します。

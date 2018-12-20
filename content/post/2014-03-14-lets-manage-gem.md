---
layout: post
title: gem を管理しよう
slug: lets-manage-gem
date: 2014-03-14T02:23:08+00:00
comments: true
categories: programming
tags:
  - gem
  - ruby
  - rails
---

Ruby でプログラミングしていると gem という便利なパッケージ管理ツールを使うことになるでしょう。最初のうちは `$ gem install hoge` とかやってるかと思います。そんなこんなでいろいろインストールするとぐちゃぐちゃになってきて Rails を動かし始めたらもう訳が分からなくなるでしょう。一つの環境でしか使わないならいいでしょうが、複数で同じ環境を構築したいなどとなると少し大変です。
そこで bundler の出番です。bundler は gem パッケージの管理を依存関係の問題も含めて解決してくれます。

まずは gem をアップデートしましょう。

    $ gem update --system

既存の gem が入ってぐちゃぐちゃになってる場合、全部綺麗に削除してしまいましょう。デフォルトではいる gem は削除できませんとメッセージが出るのでそれ以外を削除します。

    $ gem uni $(gem li --no-versions)

bundler をインストールしましょう。他にも、これはシステム全体にインストールしてもいいかなと思うものは入れちゃってOKです。私は pry だけ入れました。

    $ gem i bundler
    $ gem i pry

あとはプロジェクト毎に入れたい gem を Gemfile というファイルに記述していけば大丈夫です。`$ bundle init` コマンドで Gemfile のひな形ができます。

例えば Rails プロジェクトなどでは以下のようにして gem を管理するとよいでしょう。

    $ bundle install --path vendor/bundle --without production

実行時は `$ bundle exec` をつけて実行してください。

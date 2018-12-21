---
layout: post
title: brew のアップグレードで rails プロジェクトなどが動かなくなったら
slug: fix-rails-error-occurred-by-brew-update
date: 2014-12-17T23:05:08+00:00
comments: true
categories:
  - "programming"
tags:
  - "homebrew"
---

brew をちょくちょくアップグレードしてると古い rails プロジェクトが動作しなくなったりします。直接的な影響ではなく間接的に影響して動作しなくなっています。よくあるのは keg-only なパッケージによる影響です。

## エラーの例
openssl 周りでエラーが起こっているのだと思われます。brew でインストールした openssl のバージョンが上がったのでしょう。

    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/site_ruby/2.0.0/rubygems/core_ext/kernel_require.rb:55:in `require': dlopen(/Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/2.
    0.0/x86_64-darwin11.4.2/openssl.bundle, 9): Symbol not found: _SSLv2_client_method (LoadError)

解決方法は関係ありそうな brew のパッケージをリンクし直すことです。上記例なら openssl です。そして openssl は keg-only なパッケージですので force をつけることに注意します。また OS に元々入ってる openssl を使っていないかも確かめましょう。

    $ brew link openssl --force
    $ which openssl            # openssl の呼び出し元を調べます
    $ openssl version          # バージョンを調べます
    $ /usr/bin/openssl version # システムにインストールされているバージョンを調べます

ここで一度エラーが起こった内容のコマンドをもう一度実行してみます。例えば rails の起動とか gem のインストールとかです。動けばOK。もし動かなかったら ruby の再インストールをします。ここでは rbenv を使っている前提です。

    $ CONFIGURE_OPTS="--with-readline-dir=/usr/local --with-openssl-dir=/usr/local" rbenv install 2.0.0-p353

これでもう一度実行してみましょう。直ってるはずです。え？直ってない？自力で解決してください。

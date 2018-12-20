---
layout: post
title: rbenv で Mac OS X に Ruby 2.0.0 をインストールする
date: 2013-05-13T18:08:14+00:00
comments: true
categories: programming
tags:
  - mac
  - rbenv
  - ruby
---

rvm はクールじゃないので rbenv を使って Ruby をインストールします。

## 事前準備

はじめに『[Ruby on Rails 3.2 を Mac OS X にインストールする手順をかなり丁寧に説明してみました](http://www.oiax.jp/rails/zakkan/rails_3_1_installation_on_macosx.html)』を参考に準備をしておきます。
このサイトは Rails のインストールについてですが Xcode, Homebrew など初歩からかなり丁寧に書いているのでオススメです。

## Ruby のインストール

準備が出来たら以下コマンドを順次行います。

    $ brew update
    $ brew upgrade ruby-build
    $ CONFIGURE_OPTS="--with-readline-dir=/usr/local --with-openssl-dir=/usr/local" rbenv install 2.0.0-dev

## デフォルト使用設定

デフォルトで使用する Ruby のバージョンを決定します。

    $ rbenv global VERSION_NUMBER
    $ rbenv versions # 確認

## Ruby や Gem のパスを通す

rbenv の場合、インストールした Gem などを使う前に `$ rbenv rehash` としてパスを通してやる必要があります。
ただ毎回これを行うのは面倒かつ忘れてしまうので、自動化します。
`rbenv-rehash` という Gem をインストールするのも一つの方法ですが、シェルにラッパーを書いてあげるのがいいでしょう。

『[rbenv で gem を使った時に rbenv rehash しなくて良くする](http://rhysd.hatenablog.com/entry/20120226/1330265121)』が大変参考になります。

---
layout: post
title: Ubuntu の rbenv で管理している ruby を新しくする
date: 2013-10-19T02:00:50+00:00
comments: true
categories: programming
tags:
  - rbenv
  - ruby
  - ubuntu
---

Ubuntu の rbenv で管理している ruby を新しくする方法です。
MacOS だと多分 homebrew とか使ってると思います。今回は割愛です。

## 利用可能な ruby のバージョンを確認
ruby-build で利用可能な ruby のバージョンを確認します。

    $ ruby-build --definitions

ここに最新の ruby が入ってなかったら、ruby-build を更新します。

## ruby-build の更新
多くの人が github からインストールしてると思いますので、まず ruby-build をインストールしたディレクトリに入ります。
そこで pull master してインストールします。

    $ cd ~/Downloads/ruby-build
    $ git remote -v #確認
    origin	git://github.com/sstephenson/ruby-build.git (fetch)
    origin	git://github.com/sstephenson/ruby-build.git (push)
    $ git pull origin master
    $ sudo ./install.sh

## rbenv で ruby の最新バージョンをインストール
ruby-build を更新したので rbenv で最新の ruby をインストールします。

    $ rbenv install 2.0.0-p247 

## デフォルトで使用する ruby のバージョン変更
先程インストールした最新の ruby をデフォルトとして使うには以下を行います。
    
    $ rbenv global 2.0.0-p247
    $ rbenv rehash

以上。

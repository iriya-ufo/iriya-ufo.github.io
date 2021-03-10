---
layout: post
title: 土日で出来る Node.js 入門
slug: start-nodejs-at-weekend
date: 2014-03-08T17:29:27+00:00
comments: true
categories:
  - "programming"
tags:
  - "heroku"
  - "node.js"
---

そろそろ流行りの Node.js 勉強しようと思いたち土日にあそんでみました。Ubuntu 12.04 にインストールしてみたよ。

## インストール方法
Node.js はまだまだ開発まっしぐらなのですぐにバージョンが古くなります。調べたところバージョン管理してくれる nvm (Node Version Manager) というのがあるらしいのでそれを使いましょう。

### 準備
もう入ってるなら必要ないです。

    $ sudo apt-get install build-essential libssl-dev curl

### nvm のインストール
nvm をインストールします。

    $ git clone git://github.com/creationix/nvm.git ~/.nvm
    $ source ~/.nvm/nvm.sh

### node のインストール
node.js をインストールします。

    $ nvm ls-remote # インストールできるバージョンを確認
    $ nvm install 0.11 # 好きなものをインストール (最新がいい)
    $ nvm use 0.11
    $ nvm ls # 使っているバージョンの確認
    $ node -v # 確認
    $ npm -v # npm も確認

### シェルの設定
ログアウトなどすると nvm が使えないのでシェルの設定ファイルに以下を追記します。

    source ~/.nvm/nvm.sh
    nvm use 0.11 >/dev/null

## インストールが終わったら
以下のリンク先を参考に遊んでみましょう。Heroku のデプロイまですごく簡単に行えました。Ruby on Rails より簡単だったなぁ。
<ul>
  <li>
    <a href="http://libro.tuyano.com/index2?id=1115003" title="ビギナーのための Node.jsプログラミング入門" target="_blank">ビギナーのための Node.jsプログラミング入門</a>
  </li>
  <li>
    <a href="http://dotinstall.com/lessons/basic_nodejs" title="Node.js入門 @ ドットインストール" target="_blank">Node.js入門 @ ドットインストール</a>
  </li>
</ul>

## 参考サイト
<ul>
  <li>
    <a href="http://mollifier.hatenablog.com/entry/20110221/p1" title="Node.jsとnvmを初めてインストールするときのハマりポイントと対策" target="_blank">Node.jsとnvmを初めてインストールするときのハマりポイントと対策</a>
  </li>
  <li>
    <a href="https://github.com/creationix/nvm" title="Github nvm" target="_blank">Github NVM</a>
  </li>
  <li>
    <a href="https://devcenter.heroku.com/articles/nodejs-support" title="Heroku Node.js Support" target="_blank">Heroku Node.js Support</a>
  </li>
</ul>

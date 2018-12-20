---
layout: post
title: Docker for Mac を使う
date: 2016-07-31 14:11:03 +0900
comments: true
categories: programming
tags: docker
---

[『Mac に Docker 環境を構築する』]({% post_url 2015-07-20-docker-on-mac %})を書いてしばらくしたら `boot2docker` が非推奨となって[『Docker-machine で Mac に Docker 環境を構築する』]({% post_url 2015-10-10-docker-machine-on-mac %})を書いたら今度は [Docker for Mac](https://docs.docker.com/docker-for-mac/) がナウいとかなって今回の記事に至ります。仮想環境は変化が速くていろいろ大変です。

Docker for Mac はネイティブに動作する Docker 環境らしく先日β版から正式公開となったようです。Docker が Linux カーネル上で動作するのにネイティブってどういう意味や？と思ってましたが、どうやら VirtualBox のようなホスト型仮想環境ではなく Mac OS X 組み込みのハイパーバイザー型の HyperKit を使って仮想環境を作るから速いらしいとのことでした。ネットワーク周りに面倒ごともなさそうなので今から環境作るなら Docker for Mac 一択かなという感じがします。

## 概要

初めてインストールする場合は [Docker for Mac](https://docs.docker.com/docker-for-mac/) にしたがっていけばすぐに終わります。
Docker Toolbox などを使っていた場合は移行が必要です。僕は brew で各種コマンドをインストールして使っていました。

基本的な差異はここに丁寧にまとめられています。

- https://docs.docker.com/docker-for-mac/docker-toolbox/

簡単にポイントだけ抜き出して書くと

### Docker Toolbox

- Docker Toolbox は各種 docker コマンドが `/usr/local/bin` に入る
- 証明書とかの情報は `$HOME/.docker/machine/machines/default` に入る
- `eval $(docker-machine env default)` で環境変数をロードする

### Docker for Mac

- `/Applications` にアプリがインストールされる
- 各種コマンドは `/usr/local/bin` に symlink が貼られる
- 実体は `/Applications/Docker.app/Contents/Resources/bin`

さらに Docker for Mac の特徴として以下があります。

- VirtualBox ではなく HyperKit を使う
- docker-machine で作成したものには影響を与えない
- Docker for Mac のインストール時に `default` イメージやコンテナに関してはローカルにあるものからコピーされオリジナルは維持する
- `/var/tmp/docker.sock` ソケットを使ってやり取りするから環境変数とかいらない

## 設定

以上を踏まえると以下の手順でよさそうです。

- VirtualBox はそのままでもアンインストールしてもいい
- `.zsh` などに書いた環境変数設定は `unset` する
- brew でいれた docker ツール群はアンインストールする
- Docker for Mac をインストールする

また Docker Toolbox が使いたくなったときは環境変数をセットするだけで良さそうです。

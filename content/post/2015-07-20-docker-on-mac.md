---
layout: post
title: Mac に Docker 環境を構築する
slug: docker-on-mac
date: 2015-07-20T14:28:57+00:00
comments: true
categories: programming
tags:
  - docker
  - mac
  - ubuntu
  - unix
---

<img src="/images/2015/07/homepage-docker-logo.png" class="image">

とあるプロジェクトで古い Ruby と Rails をいれて動かさなくちゃいけない、みたいな場面って開発やってる方はあるあるだと思います。そして現最新の Mac OS Yosemite では簡単には環境構築できなかったりするのもあるあるですよね。レガシーな環境っていやですね。そこでプログラムを動かす環境を仮想で作ってしまおうという考えに至るわけですが、一昔前と違って様々な手段が登場しました。

今回はコンテナ型の仮想環境を構築できる [Docker](https://www.docker.com/) を使ってみます。なお Docker にはセキュリティ上の根本的欠陥があるとして、Docker と決別した Linxu ディストリビューションもあったりします。

[CoreOSが「Docker」と決別--独自のコンテナ実装「Rocket」を公開](http://japan.zdnet.com/article/35057363/)

Rocket の方がナウイ感じがしますが、いかんせん情報が少ないので今回は Docker でいきます。

## 事前準備
[VirtualBox](https://www.virtualbox.org/wiki/Downloads) と [homebrew](http://brew.sh/index_ja.html) をインストールしておいてください。
VirtualBox は Linux カーネルでしか動作しない Docker を Mac で動かすために必要です。homebrew は boot2docker と呼ばれる Docker 用の Linux イメージのパッケージ管理と docker コマンド郡の管理のために必要です。

## docker パッケージのインストール
docker ツール群をインストールしましょう。Mac だと簡単です。

    $ brew install docker boot2docker
    $ docker -v

バージョンが表示されたらインストールできています。

## docker イメージのダウンロード

    $ boot2docker init

Docker の仮想イメージが `~/.boot2docker` にダウンロードされます。

## docker イメージの起動・停止・確認
次のコマンドで docker イメージが起動されます。

    $ boot2docker up

初回は環境変数などが表示されるので、`zshrc` とか `.bashrc` に追記しておきましょう。また VirtualBox を起動すると boot2docker が動作しているのがわかると思います。

    Waiting for VM and Docker daemon to start...
    ........................oooooooooooooooooo
    Started.
    Writing /Users/iriya/.boot2docker/certs/boot2docker-vm/ca.pem
    Writing /Users/iriya/.boot2docker/certs/boot2docker-vm/cert.pem
    Writing /Users/iriya/.boot2docker/certs/boot2docker-vm/key.pem

    To connect the Docker client to the Docker daemon, please set:
    # 以下に環境変数が表示されるのでそれぞれシェルに設定
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/iriya/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1

停止と状態確認は以下の通りです。

    $ boot2docker stop
    $ boot2docker status

## Docker の操作
ここまでで Docker の環境は用意できました。実際の仮想環境は Docker ホスト上に**コンテナ**という形で作っていくことになります。動作イメージはこのような感じです。

<img src="/images/2015/07/docker-image-2.png" class="image">

それでは練習として CentOS イメージのダウンロードと確認をしてみましょう。

    $ docker pull centos:centos6
    $ docker images

オプションの確認は下記コマンドでできます。

    $ docker —help
    $ docker COMMAND —help

では次にコンテナの起動をしてみましょう。

    $ docker run -t -i -d --name centos6 centos:centos6 /bin/bash

    -d はバックグラウンド
    -i は Keep STDIN open even if not attached
    -t は Allocate a pseudo-TTY

プロセスの確認をしてみます。

    $ docker ps

コンテナにアタッチしたりデタッチするには以下のようにします。アタッチする際はプロセスで確認したID番号を指定します。なおアタッチしている状態で exit するとデタッチではなくプロセスの終了になるので注意しましょう。

    $ docker attach a732c1346103 # アタッチ
    C-p C-q                      # デタッチ

いろいろいじってるとゴミができます。ゴミは整理したほうがいいですね。レポジトリ名が`<none>`のイメージを全て削除する方法です。

    $ docker rmi -f `docker images | grep "<none>" | awk '{ print $3 }'`

イメージIDを指定して削除する方法です。

    $ docker rmi a005304e4e74

## Dockerfile の作成
先ほどは centos のミニマムバージョンを起動していろいろ試してみました。ここでは実際に Ruby と MySQL が入った環境を作ってみましょう。構築は Dockerfile というものを作ってそこに書いていく感じになります。用途ごとにディレクトリを作成するとよいでしょう。

    $ mkdir ~/docker/rbenv-mysql
    $ vim ~/docker/rbenv-mysql/Dockerfile

```sh ~/docker/rbenv-mysql/Dockerfile
FROM ubuntu:14.04
MAINTAINER Naoto Inoue

# パッケージのインストールとアップデート
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install build-essential
RUN apt-get -y install git vim curl
RUN apt-get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev

# rbenv のインストール
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# ruby のインストール
ENV CONFIGURE_OPTS --disable-install-doc
ADD ./versions.txt /root/versions.txt
RUN xargs -L 1 rbenv install < /root/versions.txt
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bash -l -c 'for v in $(cat /root/versions.txt); do rbenv global $v; gem install bundler; done'
RUN rbenv global 1.9.2-p320

# mysql のインストール
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections && \
    apt-get -y install mysql-server
RUN apt-get clean

# mysql の設定ファイル
ADD ./mysql-listen.cnf /etc/mysql/conf.d/mysql-listen.cnf
ADD ./my.cnf /etc/mysql/my.cnf

# password なしでリモートから root でログインできるようにする
RUN (/usr/bin/mysqld_safe &); sleep 3; echo "grant all privileges on *.* to root@'%';" | mysql -u root -proot

# ポート開放
EXPOSE 3306

# 起動オプション
CMD ["/usr/bin/mysqld_safe"]
```

Linux 触ったことある人なら何をやっているかはだいたい分かると思います。上記の **ADD** コマンドはファイルを Docker 側に渡す書き方です。同じディレクトリに `my.cnf`、`mysql-listen.cnf`、`versions.txt` のファイルを作っておきましょう。versions.txt にはインストールしたい Ruby のバージョンを書いておきます。

Dockerfile ができたらビルドします。ビルドする際に `-t` オプションでイメージ名を決められるのですが、`<アカウント名>/<パッケージ名>` という形式が推奨されているようです。

    $ docker build -t iriya/rbenv-mysql .
    $ docker images # 作成されたイメージの確認

作成したイメージからの起動はこのようにします。

    $ docker run -i -t iriya/rbenv-mysql /bin/bash

## Docker Hub
Docker には [Docker Hub](https://hub.docker.com/account/signup/) という GitHub のようなコミュニティがあります。ここに作成したイメージをアップしておくと誰かの役にたつかもしれません。アップの仕方は非常に簡単です。アカウントを作った後に以下のコマンドを打つだけで終わります。

    $ docker login
    $ docker push iriya/rbenv-mysql

<a href="https://registry.hub.docker.com/u/iriya/rbenv-mysql/" target="_blank">こちら</a>がイメージになります。**pull** コマンドでダウンロードできます。よかったら使ってみてください。

## 参考
[すぐにDockerを試したい人のための基礎コマンド](http://deeeet.com/writing/2013/12/08/docker-cheat/)

---
layout: post
title: docker-machine で Mac に Docker 環境を構築する
date: 2015-10-10T21:33:25+00:00
comments: true
categories: programming
tags: docker
---

boot2docker で Docker 環境を作っていたのだが、アップデートしてみたら以下の警告が出た。

    WARNING: The 'boot2docker' command line interface is officially deprecated.
    Please switch to Docker Machine (https://docs.docker.com/machine/) ASAP.
    Docker Toolbox (https://docker.com/toolbox) is the recommended install method.
    error in run: Failed to get machine "boot2docker-vm": machine does not exist (Did you run `boot2docker init`?)

boot2docker が非推奨になって docker-machine を使えとあるので移行作業をした。β版なので production では使わないでと書いてある。

docker-machine はこんなやつ

https://docs.docker.com/machine/

## インストール

    $ brew install docker-machine

## boot2docker で作った VM の移行

    $ docker-machine create -d virtualbox --virtualbox-import-boot2docker-vm boot2docker-vm docker-vm

## 環境変数の設定を書き換える
`.zshrc` などに書いていた環境変数を新しい書き方に変える

    今まで
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=/Users/iriya/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1

    これから
    eval "$(docker-machine env docker-vm)"

## コマンドの差分
今まで docker でやってたコマンドは代わりに docker-machine コマンドを使うようにする。差分は以下を参考。

http://docs.docker.com/installation/mac/#migrate-from-boot2docker

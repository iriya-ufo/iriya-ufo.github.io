---
layout: post
title: "Docker コンテナに anaconda 環境を構築"
slug: pyenv-and-anaconda-on-docker
date: 2016-11-18 12:17:31 +0900
comments: true
categories:
  - "programming"
tags:
  - "machine learning"
---

機械学習の主流言語といえば Python ですよね。最近はインストール方法も変わってきており、より便利な方法があるようです。

今回は Anaconda の環境を Docker で作って、さらに各種ライブラリを Anaconda の仮想として作成していくような予定でいます。
Docker にすると各OS毎に環境を作らないで済むのがいいですね。Anaconda 公式でも Docker はいいよって言ってます。

- [ANACONDA AND DOCKER - BETTER TOGETHER FOR REPRODUCIBLE DATA SCIENCE](https://www.continuum.io/blog/developer-blog/anaconda-and-docker-better-together-reproducible-data-science)

Anaconda にする理由と各OS実機にインストールする方法が下記に詳しく書いておりました。

- [データサイエンティストを目指す人のpython環境構築 2016](http://qiita.com/y__sama/items/5b62d31cb7e6ed50f02c)

今回はOS毎の差異をなくすため pyenv + anaconda + ubuntu という組み合わせを Docker コンテナに構築します。
実機にいれる場合はこちら[『pyenv + Anaconda (Ubuntu 16.04 LTS) で機械学習のPython開発環境をオールインワンで整える』](http://blog.algolab.jp/post/2016/08/21/pyenv-anaconda-ubuntu/)が参考になります。
ライブラリの紹介もあるのでいいですね。

Docker を使う方法は下記の README を参照してください。Pyenv と Anaconda3 の環境を一つにした Docker イメージになります。

- https://github.com/iriya-ufo/ml-anaconda

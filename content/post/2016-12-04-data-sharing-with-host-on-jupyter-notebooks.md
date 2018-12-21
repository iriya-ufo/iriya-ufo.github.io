---
layout: post
title: "Docker 版 Jupyter Notebooks でホストとデータを共有する"
slug: data-sharing-with-host-on-jupyter-notebooks
date: 2016-12-04 14:17:17 +0900
comments: true
categories:
  - "programming"
tags:
  - "machine learning"
  - "jupyter"
---

[前回 Anaconda 環境の Docker イメージ]({% post_url 2016-11-18-pyenv-and-anaconda-on-docker %})を作ったのですが、機械学習をやるには Jupyter Notebooks という統合開発環境の方がいろいろ便利だということなので、そちらをメインに使うことにします。

Jupyter ってなんぞっていう説明はググレばいっぱい出てきますので、そちらを参照ください。下記記事はよくまとまっていてよかったです。

- [Jupyter の Docker イメージを使ってみる](http://qiita.com/kshigeru/items/2cd504e927869163b4c8)

Jupyter Notebooks は公式の Docker イメージが配布されているので、それを使うのが楽です。
ただ、ホストとデータ共有して起動しないとデータ保存ができません。最初ちょっと困ったのですが、下記コマンドの起動で大丈夫でした。

    $ docker run -d -p 8888:8888 -v $HOME/project/notebooks:/home/jovyan/work jupyter/datascience-notebook
    # -v オプションでデータ共有を指定
    # -v ホスト側ディレクトリ:コンテナ側ディレクトリ
    # Jupyter Notebooks ではコンテナ側ディレクトリは /home/jovyan/work となる

[『Deep Learning from scratch』]({{ root_url }}/products)

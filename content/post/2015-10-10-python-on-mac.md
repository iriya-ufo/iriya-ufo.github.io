---
layout: post
title: Mac に Python 環境構築
date: 2015-10-10T19:00:23+00:00
comments: true
categories: programming
tags: python
---

普段は Ruby 使いの自分です。ちょっと Python のライブラリを使いたい状況に出くわしたので、環境構築を含めまじめにやってみました。昔と違い随分と便利になってますね。

## Python のインストール
Mac も Linux もデフォルトで python はインストールされているが、今後バージョンを切り分けたい時があるかもしれないので、Python 自体のバージョン管理は brew に任せることにする。Linux なら apt-get や yum で代用する。

    $ brew update
    $ brew install python

シェル再起動後、有効になっているか確認します。

    $ which python
    /usr/local/bin/python
    # システムの python は /usr/bin/python なので、これで成功

## pip のインストール
pip とは Python のパッケージ管理ツールのこと。brew でインストールした場合、pip も同梱されるのでこの手順はやらなくてよい。

Linux の場合はこんな感じ

    curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python

ちなみに upgrade は以下のようにする。

    $ pip install --upgrade pip

## virtualenv のインストール
virtualenv とは Python の仮想実行環境をつくるもの。プロジェクト毎に独立した環境を切りたい場合などに使う。微妙に違うけど Ruby の rbenv のようなものだと思えばよい。

インストールは pip で行う。

    $ pip install virtualenv virtualenvwrapper

`.zshrc` に環境変数を書いてリロード

    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    source /usr/local/bin/virtualenvwrapper.sh

### virtualenvwrapper の使い方
先ほど virtualenvwrapper も一緒にいれたので、このツールからいろいろやる。

仮想環境を作る (ホームディレクトリの `.virtualenvs` に hoge 環境ができる)

    $ mkvirtualenv hoge

作った仮想環境に入る (プロンプトが変わる)

    $ workon hoge

仮想環境にライブラリ入れる (プロンプトの先頭に (hoge) と変更されている状態で行うこと)

    $ pip install numpy

仮想環境から抜ける (プロンプトが消える)

    $ deactivate

仮想環境の削除

    $ rmvirtualenv hoge

その他 virtualenv の詳細

- http://qiita.com/caad1229/items/325ca5c8ad198b0ebce7

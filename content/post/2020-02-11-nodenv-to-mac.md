---
layout: post
title: "Mac に nodenv インストールした"
slug: nodenv-to-mac
date: 2020-02-11T15:55:10+09:00
lastmod: 2020-12-05T15:55:10+09:00
comments: true
categories:
  - "programming"
tags:
  - "node.js"
---

brew でいれてたけど限界がきたのでバージョン管理ツール使う。
`nodenv` を使うことにした。宗教的理由により `anyenv` 経由でのインストールはしない。

## 既存環境のアンインストール

とりあえず今の環境を消してきれいにする。

```shell
$ which yarn
/usr/local/bin/yarn
$ which node
/usr/local/bin/node
$ which npm # npm 自体は node のインストールで自動的に入ってくる
/usr/local/bin/npm
$ which n # 昔 n を入れてた気がしたがそんなことはなかった
n not found
```

消していく。

```shell
$ npm uninstall npm -g # node の削除の前にこれをやる
$ rm -rf ~/.npm
$ brew uninstall yarn
Uninstalling /usr/local/Cellar/yarn/1.22.0... (14 files, 5MB)
$ brew uninstall node
Uninstalling /usr/local/Cellar/node/13.8.0... (4,686 files, 60.2MB)
```

消えた。

```shell
$ which yarn
yarn not found
$ which node
node not found
$ which npm
npm not found
```

## nodenv インストール

[公式サイト](https://github.com/nodenv/nodenv)の通りに進めていく。

```shell
$ brew install nodenv # node-build もインストールされる
```

`~/.zshrc` に下記を追記してターミナル再起動。

```.zshrc
export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"
```

正常にインストールできたかチェックしてくれるツールらしい。

```
$ curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-doctor | bash
Checking for `nodenv' in PATH: /usr/local/bin/nodenv
Checking for nodenv shims in PATH: OK
Checking `nodenv install' support: /usr/local/bin/nodenv-install (node-build 4.7.1)
Counting installed Node versions: none
  There aren't any Node versions installed under `/Users/iriya/.nodenv/versions'.
  You can install Node versions like so: nodenv install 2.2.4
Auditing installed plugins: OK
```

※ Arch Linux で同じことをやった場合 node-build がないため install に失敗した、解消方法を後述。

## インストール可能な node の一覧

`rbenv` とほぼ使い方は一緒。fooenv 系はどれもそうなのかな。

```shell
$ nodenv install -l
```

## node インストール

インストールしてグローバルに設定。

```shell
$ nodenv install 12.14.1
$ nodenv global 12.14.1
$ nodenv versions
* 12.14.1 (set by /Users/iriya/.nodenv/version)
```

`npm` の場所を確認。

```shell
$ nodenv which npm
/Users/iriya/.nodenv/versions/12.14.1/bin/npm
$ which npm
/Users/iriya/.nodenv/shims/npm
```

特定のディレクトリでバージョンを固定したい場合。下記コマンドを実行した場所に `.node-version` というファイルが作成される。

```shell
$ nodenv local 12.14.1
```

## yarn のインストール

yarn を使いたい場合はいれる。ただ[こちらのサイト](https://developers.freee.co.jp/entry/sayonara-yarn)にもある通り yarn のメリットだった速度は npm 6 ではほぼ同等となり `package-lock.json` というロックファイルの機構もあるため npm による問題はあまりなくなってきている。

```shell
$ npm install -g yarn
$ yarn -v
1.22.0
$ which yarn
/Users/iriya/.nodenv/shims/yarn
```

## nodenv のアップグレード

```shell
$ brew upgrade nodenv node-build
```

## node-build がないと怒られた場合
チェックツールで `nodenv install` が出来ないと言われた場合 `node-build` をインストールする必要がある。

```
# As a nodenv plugin
$ mkdir -p "$(nodenv root)"/plugins
$ git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
```

(cf. https://github.com/nodenv/node-build#installation)

---
layout: post
title: "Octopress から Hugo へ移行した"
slug: octopress-to-hugo
date: 2018-12-27T10:17:23+09:00
lastmod: 2018-12-27T10:17:23+09:00
comments: true
categories:
  - "programming"
tags:
  - "hugo"
  - "octopress"
---

[以前 Octopress に移行]({{< relref "2016-04-29-how-to-start-octopress" >}}) してから2年弱になるが、アップデートで壊れてしまったのでこの機会にと[別の方法を模索]({{< relref "2018-12-26-blog-services" >}})した。
結果 Hugo に移行することにした。こっから先は Octopress から Hugo への移行方法の備忘録となる。

# Hugo のセットアップ

[Quick Start](https://gohugo.io/getting-started/quick-start/) を参考にしてインストールする。
こちらではテーマのインストールに `submodule` を利用しているが、ややこしくなるので使わないことにする。

## インストール

``` shell
brew install hugo
```

## サイトのセットアップ

``` shell
hugo new site quickstart
cd quickstart;\
git init;\
```

## テーマのインストールと設定

[Hugo Theme Gallery](https://themes.gohugo.io/) から適当に気に入ったものを探す。

気に入ったテーマを `themes` ディレクトリ入れる。
`git submodule add` は使わない方針にする。

## サンプル投稿

サンプル投稿をする。テーマによって `post` か `posts` ディレクトリを使用しているので合わせたほうが無難。

``` shell
hugo new post/my-first-post.md
```

## サーバーを起動して確認

``` shell
hugo server -D
```

http://localhost:1313/ で確認。


# Octopress からのデータ移行

この移行作業がブログ引っ越しにおいて一番大変な作業になる。過去を全部捨てるなら楽でいいんですけどね。

さて[こちら](https://ja.mhatta.org/blog/2016/08/21/migrated-from-octopress-to-hugo/)を見ると以下のようにあるので slug の設定はしたほうがいいだろう。やり方はリンク元を参照されたい。

> Hugoは特に指定しないとfront matterのtitleを記事URLに使うのだが、タイトルが日本語というかマルチバイトの場合アレなので、urlかslugを自分で書いて直接指定することになると思う。

その他の移行は[概ねこちらを参考](https://gam0022.net/blog/2016/09/25/migrated-from-octopress-to-hugo/)にした。
以下ほぼ同じ内容だがいくつかこちらで追記した部分もある。

## 記事と画像データのコピー

Markdown 記事のコピー

``` shell
cp octopress-site/source/_posts/* hugo-site/content/post/
```

画像のコピー

``` shell
cp -r octopress-site/source/images/ hugo-site/static/images
```

## Octopress の独自タグを置換
Octopress のみでしか使えない独自記法を Hugo でも扱えるよう書き換える。

``` shell
# content/post/ ディレクトリで作業する
cd content/post/

# 記事のタイムスタンプの形式を変える
find . -type f -exec sed -i "" -e 's/date: \([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\) \([0-9]\{2\}:[0-9]\{2\}\)$/date: \1T\2:00+09:00/g' {} \;

# コードブロック
find . -type f -exec sed -i "" -e 's/{% codeblock lang:\([a-z]*\) %}/```\1/g' {} \;
find . -type f -exec sed -i "" -e 's/{% codeblock %}/```/g' {} \;
find . -type f -exec sed -i "" -e 's/{% endcodeblock %}/```/g' {} \;

# 画像
find . -type f -exec sed -i "" -e 's/{% img \([^ ]*\) \(.*\) %}/![\2](\1)/g' {} \;
find . -type f -exec sed -i "" -e 's/{%.*img.*\/images\/\([^ ]*\) .*%}/<img src=\"\/images\/\1\" class=\"image\">/g' {} \;

# class付きの画像
find . -type f -exec sed -i "" -e 's/{% img right \([^ ]*\) \(.*\) %}/<img alt="\2" src="\1" class="right">/g' {} \;

# 内部リンク変更
# {% post_url foobar %} を {{&gt; relref "foobar" &lt;}} という形式に変換
# エスケープがうまく効いていないが &gt; の部分は < と読み替える
find . -type f -exec sed -i "" -e 's/{% post_url \(.*\) %}/{{&gt; relref "\1" &lt;}}/g' {} \;

# {{ root_url }} という表記をやめる
```

## パーマリンク設定

Octopress と同じパーマリンク設定を保持したい場合に必要な作業となる。
[こちらを参考](https://gam0022.net/blog/2016/09/25/migrated-from-octopress-to-hugo/)にした。

``` toml
[permalinks]
  post = "/blog/:year/:month/:day/:slug"
```

# テーマのカスタマイズ

テーマはこちらを利用させて頂いている。

https://themes.gohugo.io/hugo-theme-even/

テーマディレクトリの内容をカスタマイズした場合は、以下のコマンドを打つ。

``` shell
cd ./themes/even/
yarn install
yarn build
```

# デプロイ
Octopress と違ってデプロイタスクがないので作る必要がある。

**いくつか注意点**

1. 既存の github.io リポジトリを上書きする形にする
2. 既存のリポジトリはバックアップを取っておく
3. Octopress と同様のブランチ運用にする

**GitHub Pages のルールについて重要な点**

`master` ブランチのリポジトリ直下の内容がホスティングされるということ

**Octopress の仕組みのおさらい**

* github.io には `master` と `source` ブランチがある
* `source` には markdown で書いた記事と Octopress がある
* `master` には markdown から Octopress が生成した静的HTMLファイルがある
* https://[username].github.io/ は `master` を表示している
* 記事を編集する時は `source` で行う
* 基本 `master` に `checkout` することはない

上記を踏まえて hugo でのデプロイ方針は以下の通り

* ドキュメントに該当しない hugo 関連のソースを `source` ブランチに移す
* ビルドした html, css, js などのデータを `subtree` として `master` ブランチに作る
* github.io のドキュメントルートを `/public` とする

## Github Pages の変更作業

Octopress で運用していた Github Pages を Hugo に中身を入れ替える作業となる。

以下 hugo ディレクトリで作業する。

``` shell
# Octopress で運用していたリポジトリを追記
$ git remote -v
origin  git@github.com:[username]/[username].github.io.git (fetch)
origin  git@github.com:[username]/[username].github.io.git (push)
```

マスターブランチから source ブランチをチェックアウト

``` shell
$ git checkout -b source
$ git branch
  master
* source
```

 既存の source に強制 push (**強制 push なので注意する**)

``` shell
$ git push -f origin source
```

Github のページに行って `settings` → `Branches` → Default branch を `source` に変更する (`master` ブランチを消すため)

ローカルとリモートの `master` ブランチを削除する

``` shell
$ git branch -d master
Deleted branch master (was eafdf11).

$ git push -f --delete origin master
To github.com:[username]/[username].github.io.git
 - [deleted]         master
```

hugo コマンドで静的データを生成する

``` shell
$ rm -rf public/
$ hugo
```

コミット && push

``` shell
$ git add .
$ git commit -m "release `date '+%Y-%m-%d %H:%M’`"
$ git subtree push --prefix public/ origin master
```

以上で完了となる。

## 記事の更新方法

なお更新は次のようにする。

* 通常の作業は `source` ブランチで行う
* 記事を書き終えたら `git add --all && git commit` を行う
* デプロイするときは `./deploy.sh` を走らせる

``` shell
#!/bin/bash

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo -e "*** Deleting old publication...\n"
rm -rf public

echo -e "*** Generating site...\n"
hugo

echo -e "*** Adding CNAME...\n"
echo iriya-ufo.net >> public/CNAME

echo -e "*** git add && git commit...\n"
git add public/
git commit -m "release `date '+%Y-%m-%d %H:%M'`"

echo -e "*** Updating master branch...\n"
git subtree push --prefix public/ origin master

echo -e "*** Updating source branch...\n"
git push origin source

echo "*** Success Deploy !!!"
```

## 別PCなどで取り込む場合

通常の `git clone` をした後 `git subtree add --prefix=public/ origin master` で subtree を登録後 `master` の内容を `git subtree pull --prefix=public/ origin master` で取り込む。

# カスタムドメインの設定

カスタムドメイン設定をしている場合 `public/CNAME` ファイルにドメインの記載が必要となる。

https://gohugo.io/hosting-and-deployment/hosting-on-github/#use-a-custom-domain


# 参考にさせて頂いた記事

先人のお世話になりました。

- [GitHub PagesのUser Pagesでドキュメントルートを変更するにはmasterを殺す](https://qiita.com/kwappa/items/03ffdeb89039a7249619)
- [Github pagesで意地でもサブディレクトリをルートにする](https://matsuuratomoya.com/blog/2016-05-07/githubpage-subdirectory/)
- [Hugo + GitHub Pagesでポートフォリオを作る](http://kohki.hatenablog.jp/entry/hugo-portfolio)

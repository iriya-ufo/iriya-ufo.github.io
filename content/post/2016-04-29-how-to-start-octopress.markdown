---
layout: post
title: "WordPress から GitHub Pages + Octopress に移行した"
date: 2016-04-29 19:22:13 +0900
comments: true
categories: diary
---

今まで http://iriya-ufo.net は WordPress で運用してきたのだけれど、GitHub Pages + Octopress に移行することにした。

## WordPress を辞めたくなった理由

WordPress で記事を書くときは Emacs を立ち上げ markdown で書いて、管理画面からコピペしていた。
WordPress は管理画面からいろいろできるが、あまり使ってない上に逆に記事更新とか面倒だと思った。
さらに若干コードのデザインが崩れたりして精神衛生上よろしくなかった。

レンタルサーバー台をけちりたくなった。ホスティングには Gehirn RS2 を利用していて大変便利だった。今でもレンタルサーバーとしてはハッカー御用達のおもちゃだと思う。ちょっとお値段上がったので移動することにした。

WordPress は汎用性に欠ける。ブログのメインはテキストコンテンツである。であるならば、markdown でささっと書けて、どこでも移植できるような汎用性を持てるはず。だが WordPress を使うと MySQL やら PHP やらが必要な上にデータの移植性が乏しい。

## GitHub Pages + Octopress にした理由

WordPress を辞めたくなった理由を解決できる一つの手段だった。markdown で書けてさくっとデプロイできる。お金かからずに GitHub Pages でホスティングできる。以前 middleman + S3 という環境でサイトを作ったことがあるが、S3 の設定が面倒だったので GitHub Pages でいいかなと思った。
Octopress にした理由はブログが簡単に作れる Ruby 製のフレームワークだったから。この部分はもしかしたら今後変えていくかもしれない。

Ruby かわいいよ Ruby

## セットアップ

まず GitHub で username.github.io という名前でリポジトリだけ作成しておく。

[公式](http://octopress.org/docs/setup/)を参考に Octopress をセットアップしていく。

ディレクトリ名はブログ名にした方が分かりやすいと思うので変えておく。

    $ git clone git://github.com/imathis/octopress.git username.github.io
    $ cd username.github.io
    $ gem i bundler
    $ bundle install --path=vendor/bundle

Octopress のデフォルトテーマをインストールしてみる。

    $ bundle exec rake install

GitHub Pages にデプロイするための設定スクリプトを走らせる。リポジトリのURLを聞かれたら入力する。

    $ bundle exec rake setup_github_pages

デプロイする。

    $ bundle exec rake generate
    $ bundle exec rake deploy

ソースをコミットする。

    $ git add .
    $ git commit -m "commit"
    $ git push origin source

## ブログを投稿する

上記手順により http://username.github.io でブログが確認できるはず。
ここからブログの書き方をまとめていく。

    $ cd username.github.io
    $ bundle exec rake new_post\["title"\]

`source/_posts` に markdown ファイルがあるので好きに編集する。以下サンプル。

    ---
    layout: post
    title: "日本語のタイトルはここにいれる"
    date: 2016-04-29 19:22:13 +0900
    comments: true
    categories: [foo, bar, ...]
    ---

    ここに内容を書く。

以下の rake コマンドで http://localhost:4000/ にてプレビューが見られる。

    $ bundle exec rake preview

プレビューでオッケーならデプロイする。コミットも忘れずに。

## ブログの設定をする

`_config.yml` に好きなように設定していく。項目は [Configuring Octopress](http://octopress.org/docs/configuring/) を参照。

## 過去記事を移行する

たぶんいちばん大変なのはここで、かつ重要度も高い部分だと思う。過去記事なんていらない！全部新しくやる！という人には関係ないけど、やっぱり記事も一緒に移行したいよね。
どこまで移行したいかによって作業量が大きく変わると思う。僕の場合は、投稿だけ綺麗に持ってこれたら後はぼちぼち作っていけばいいかなというスタンスでした。

以下の記事が大変参考になりました。

- [WordpressからOctopressに移行](http://blog.restartr.com/2014/04/06/move-from-wordpress-to-octopress/)
- [WordPressからOctopressへきれいに移行する方法](http://hirofukami.com/2014/12/01/right-way-wordpress-to-octopress/)

まず [wordpress-to-jekyll-exporter](https://github.com/benbalter/wordpress-to-jekyll-exporter) を使って WordPress 記事をエクスポートします。プラグインとしてインストールして、管理画面からエクスポートすると zip ファイルができたのですが、なぜか解凍できなかったのでコマンドラインツールを使いました。

できた zip ファイルを解凍すると `_posts` ディレクトリの中に markdown 形式に変換された記事が入っています。これらを octopress の `source/_posts` 以下に移動します。プレビューで表示を確認しながら markdown ファイルをひたすら修正します。
大変でした・・・。

## カスタマイズ

独自ドメインの設定とかテーマの変更とかは後日書こうと思う。

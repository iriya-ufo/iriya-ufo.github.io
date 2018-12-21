---
layout: post
title: "Elastic BeansTalk で遊んでみた"
slug: setup-elastic-beanstalk
date: 2016-05-12 18:46:38 +0900
comments: true
categories:
  - "programming"
tags:
  - "aws"
---

Elastic BeansTalk は AWS が提供している Paas サービスだ。Heroku よりはとっつきにくいけどそれほど難しくはない。慣れてしまえばさくっと環境が作れてよい。今回移行作業を行ってみたが案外ハマりポイントなどがあったり、不向きなアプリだったのでやめたが、機会があればこれで運用してみたいと思う。備忘録として記録しておく。環境は Mac です。

おおまかに以下のような手順で進めていく。

1. AWS CLI ツールのインストール
2. CLI ツールの設定
3. アプリケーションを作る
4. EB 設定ファイルの編集

## AWS CLI ツールのインストール
BeansTalk だけなら `awscli` の方は必要ないが、どこかしらで使うのでついでにインストールしておく。

    $ brew install awscli
    $ brew install awsebcli

以下のコマンド補完をしておくと便利である。

### Bash の場合

    Add the following to ~/.bashrc to enable bash completion:
      complete -C aws_completer aws

### Zsh の場合

    Add the following to ~/.zshrc to enable zsh completion:
      source /usr/local/share/zsh/site-functions/_aws

## CLI ツールの設定
AWS CLI ツールの設定を行う。プロファイル名は適当に。キー設定などのため、事前に IAM で専用ユーザーを作っておく。

    $ aws configure --profile プロファイル名

アクセスキーの設定

    AWS Access Key ID [None]: xxxxxxxxxxxxxxxxxx

シークレットキーの設定

    AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxxxxx

リージョンの設定、ap-northeast-1 は東京リージョン

    Default region name [None]: ap-northeast-1

アウトプットフォーマットの設定、デフォルトは json

    Default output format [None]:

`~/.aws` というディレクトリが作成されおり、その中にコンフィグファイルが入っている。

次に EB CLI ツールの設定を行っていく。こちらも IAM で専用ユーザーを作っておくとよい。先ほどの AWS CLI ツールの時に作成したユーザーでもいいし、別のユーザーでもいい。ポリシーで決める。ここでは対話式での設定となる。

では Rails プロジェクトに移動して `$ eb init` として初期化する。以下の内容について聞かれるので適宜こたえる。

    リージョン	                ap-northeast-1 (東京)
    AWS アクセスキー ID	        お客様のアクセスキー (IAM ユーザー)
    AWS 秘密鍵	                お客様のシークレットキー (IAM ユーザー)
    アプリケーション名	        eb-your-app-name
    Ruby を使用しますか?         	y キー (はい)
    プラットフォームのバージョン	Ruby 2.2 (Puma)
    SSH をセットアップしますか?	y キー (いいえ)

`.elasticbeanstalk/config.yml` というファイルが作成される。
`.gitignore` が更新されているのでコミットしておく。

また間違えてパラメーター設定してしまった場合の消し方は以下の通り。

    $ eb config delete .elasticbeanstalk/config.yml

## アプリケーションを作る
Elastic BeansTalk では一番外側の大きな枠を**アプリケーション**と呼ぶ。開発用と本番用など環境を分けたい場面はよくあると思うが、それは**環境**という呼ばれ方をする。EB でアプリを作る際は環境を意識するとよいだろう。以下のコマンドを実行すると Rails プロジェクトのアップロードから ELB の設定、AutoScaling の設定、EC2 インスタンスの作成など一通り行われる。

    $ eb create 環境名

ここで以下のエラーが発生した。

```
[Instance: i-xxxxxxxx] Command failed on instance. Return code: 11 Output: (TRUNCATED)...ps://rubygems.org/... Fetching dependency metadata from https://rubygems.org/.. You need to install git to be able to use gems from git repositories. For help installing git, please refer to GitHub's tutorial at https://help.github.com/articles/set-up-git. Hook /opt/elasticbeanstalk/hooks/appdeploy/pre/10_bundle_install.sh failed. For more detail, check /var/log/eb-activity.log using console or EB CLI.
```

gem を GitHub のリポジトリからダウンロードするなら git をインストールしろ、とある。
`$ eb ssh` でインスタンスにログインして git をインストールしてもいいがそれではせっかくの Paas の利点が失われるので、設定ファイルを書いて対応する。

## EB 設定ファイルの編集
カスタマイズした設定をサーバーにデプロイしたい場合 `.ebextensions/01packages.config` というように `.ebextensions` というディレクトリを作ってその中にコンフィグを書いていく。コンフィグはアルファベット順に実行されるので 01 02 ... という感じで接頭辞をつけておくとよい。

```sh .ebextensions/01packages.config
packages:
  yum:
    git: []
```

```sh .ebextensions/02database.config
# Symlink the ondeck database.yml to database.yml.example
files:
  "/opt/elasticbeanstalk/hooks/appdeploy/pre/01a_symlink_database_yml.sh":
    mode: "000777"
    content: |
      #!/bin/bash
      cd /var/app/ondeck/config
      ln -sf database.yml.example database.yml
```

```sh .ebextensions/03puma.config
files:
  "/etc/init.d/puma":
    mode: "000777"
    content: |
      #!/usr/bin/env bash

      . /opt/elasticbeanstalk/support/envvars.d/sysenv
      RAILS_ENV=production

      case "$1" in
        start)
          /etc/init.d/passenger stop
          cd /var/app/current
          bundle exec puma -C config/puma.rb
        ;;
        stop)
          if [ -f /var/app/support/pids/puma.pid ]; then
            kill -TERM `cat /var/app/support/pids/puma.pid`
            rm -rf /var/app/support/pids/puma.pid
          fi
        ;;
        *)
          echo "puma [start|stop]"
          exit 1
        ;;
      esac
      exit 0

  "/opt/elasticbeanstalk/hooks/preinit/26_puma_start.sh":
    mode: "000777"
    content: |
      /etc/init.d/puma start

  "/opt/elasticbeanstalk/hooks/restartappserver/enact/01_restart.sh":
    mode: "000777"
    content: |
      /etc/init.d/puma stop
      /etc/init.d/puma start

  "/opt/elasticbeanstalk/hooks/configdeploy/enact/99_reload_app_server.sh":
    mode: "000777"
    content: |
      /etc/init.d/puma stop
      /etc/init.d/puma start

  "/opt/elasticbeanstalk/hooks/appdeploy/enact/99_reload_app_server.sh":
    mode: "000777"
    content: |
      /etc/init.d/puma stop
      /etc/init.d/puma start

commands:
  remove_25_passenger:
    command: "rm -f /opt/elasticbeanstalk/hooks/preinit/25_passenger.sh"
    ignoreErrors: true
  remove_26_passenger_start:
    command: "rm -f /opt/elasticbeanstalk/hooks/preinit/26_passenger_start.sh"
    ignoreErrors: true
```

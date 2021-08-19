---
layout: post
title: "Hacobune で Go のアプリケーションを公開してみた"
slug: hacobune-quick-start
date: 2021-08-19T17:02:52+09:00
lastmod: 2021-08-19T17:02:52+09:00
comments: true
categories:
  - "programming"
tags:
  - "hacobune"
  - "docker"
---

さくらインターネットさんから Hacobune というおもしろそうなサービスが発表されました。

- [インフラを意識せずにSaaS開発ができる 次世代PaaS「Hacobune」のオープンβ版を2021年8月12日に無料提供開始](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)

PaaS 型のクラウドサービスということですけど Docker イメージもしくは Dockerfile が必須ということなのでコンテナの PaaS として考えるとよさそうですね。
さくらインターネット + Docker と聞くと [Arukas を思い出してウッとなりますが](https://www.sakura.ad.jp/information/announcements/2019/09/30/1968201223/) Hacobune はどこまで頑張ってくれるでしょうか……。

今回少し触ってみたので備忘録がてら書き記しておきます。

## クイックスタート

### アカウント作成とログイン

Hacobune はさくらのクラウドサービスの一つなので、さくらインターネットのアカウントを作成するところから始めます。

- [さくらインターネット会員登録](https://secure.sakura.ad.jp/signup3/member-register/input.html)

アカウントが作成できたら以下のリンクより、さくらのクラウドサービスにログインします。

- [さくらのクラウドログイン](https://secure.sakura.ad.jp/cloud/)

### プロジェクトの作成とアプリケーションの構築

クラウドサービスにログインしたら Hacobune を選択します。

![sakura-cloud](/images/2021/08/sakura-cloud.png)

Hacobune の画面で最初に行うのはプロジェクトの作成です。ドキュメントによるとプロジェクトとアプリケーションの関係は以下のようになっているそうです。

**プロジェクト**

> 最初に作成するリソースです。
> ネットワークとローカルDNSを提供します。
> 作成したプロジェクト内部でアプリケーションやボリュームなど各種リソースを作成します。
> Hacobune（β版）における最大単位です。
> ※プロジェクト内ではアプリケーション名やアドオン名、ジョブ名をホスト名として指定することで通信できます。

**アプリケーション**

> 実際にコードが実行されるリソースです。
> DockerイメージやGithubを用いたアプリケーションのデプロイを行うことが可能です。
> その他にも、環境変数設定やIP制限、オートスケール設定を行うことが可能です。
> また、同じプロジェクト配下に作成されたアプリケーション同士は設定したホスト名で通信することができます。 Hacobune（β版）における最小単位です。
> ※アプリケーションへのインターネットからアクセスは、httpsのみ対応しています

#### プロジェクトの作成

新規作成ボタンからプロジェクトの作成を行います。非常にシンプルな作成画面です。

![hacobune-project](/images/2021/08/hacobune-project.png)

#### アプリケーションの作成

以下の内容でアプリケーションを作成しました。
プライベートなコンテナレジストリとして gitlab を登録してみました。レジストリの登録ではユーザー名とパスワードしかなかったので二段階認証は未対応だと思われます。
また Docker イメージ名のプレースホルダーに `docker.io/nginx:latest` とあったので、ドメイン名も含めて必要なのかなと思い試してみましたが Pull エラーになりました。ドメイン名の部分は必要なさそうです。

ちなみにデプロイ方法で GitHub との連携に不具合があったらしく、現時点（2021/08/20）では GitHub でのデプロイは出来なくなっているようでした。

![hacobune-application](/images/2021/08/hacobune-application.png)

ドメインに関して Hacobune ではデフォルトドメインとして `c1.hacobuneapp.com` が与えられていました。
アプリケーション作成画面では、外部公開にチェックをいれるとサブドメインの部分が自由入力できるようになっており、後続のドメインはデフォルトドメインである `c1.hacobuneapp.com` のみ選択可能となっているようです。
この後続の部分はアカウント毎に異なるのかなと思いましたが、サービス全体で共通のようでした。そのため例えばサブドメインに `test` は登録できなかったです。実質早いもの勝ちという感じですね。

ここまででアプリケーションの作成が完了となり、下記 URL で公開することができました。

- https://canaria-api.c1.hacobuneapp.com/

## 総評

全体を触ってみた感じですが、シンプルで分かりやすく好印象です。https がデフォルトで有効化していたり、動作がきびきびして快適なのはいいですね。
機能はまだまだこれからだと思うので楽しみにしています。

Hacobune は Lab プロダクトということで実験的な位置づけのサービスなので今は無料で使うことができます。
現時点での作成上限は以下のようになっていました。ちょっと試してみるにはいい感じのボリューム感ですね。

![hacobune-limit](/images/2021/08/hacobune-limit.png)

## 参考資料

- [Hacobune（β版）ドキュメント](https://manual.c1.hacobuneapp.com/docs)
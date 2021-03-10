---
layout: post
title: "Rails の開発環境を Docker で構築する"
slug: rails-dev-env-on-docker
date: 2019-08-14T10:10:30+09:00
lastmod: 2019-08-14T10:10:30+09:00
comments: true
categories:
  - "programming"
tags:
  - "rails"
  - "docker"
---

開発環境で使える Rails の Docker 環境構築です。
Docker とは関係ない話しも混じってます。

## コンテナ構成

シンプルに Ruby をベースに Rails 環境をビルドします。
DB は PostgreSQL を使います。永続化に Volume を利用します。

- Ruby
- Rails
- PostgreSQL

## ディレクトリ構成

`RAILS_ROOT` 配下の構成です (一部抜粋)。

```
RAILS_ROOT
├── .dockerignore
├── .env
├── .gitignore
├── Dockerfile
├── Gemfile
...
├── Makefile
├── README.md
...
├── config/
│   ...
│   ├── database.yml
...
├── docker-compose.yml
...
```

## ファイルの中身

{{< gist 963f30e7ecd4704ad16358e68d34e394 >}}

---
layout: post
title: Ubuntu の git を最新にする
slug: update-git-by-ubuntu
date: 2014-03-08T15:16:11+00:00
comments: true
categories: programming
tags:
  - git
  - ubuntu
---

Ubuntu への git インストールは apt-get で出来ますがバージョンが古いので最新バージョンをインストールする方法です。ソースコンパイルは行わずパッケージマネジャーで管理します。
    
    $ sudo apt-add-repository ppa:git-core/ppa
    $ sudo apt-get update
    $ sudo sudo apt-get upgrade

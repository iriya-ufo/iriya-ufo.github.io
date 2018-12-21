---
layout: post
title: SSH ログインが遅い問題を解決
slug: why-so-slow-ssh-login
date: 2013-05-10T08:28:07+00:00
comments: true
categories:
  - "programming"
tags:
  - "ssh"
---

SSH でログインそのものはできるが非常に時間がかかるという場合、DNS の設定がよろしくない場合があります。
そんな時は、`sshd_config` に以下を追記してみてください。

    UseDNS no

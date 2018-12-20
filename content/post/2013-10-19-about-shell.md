---
layout: post
title: シェル周りまとめ
slug: about-shell
date: 2013-10-19T18:33:58+00:00
comments: true
categories: programming
tags:
  - bash
  - shell
  - unix
---

## csh tcsh まとめ

### .login (csh, tcsh)
login shellを csh, tcsh にした場合、端末から login した際に読み込まれる設定ファイル。
login 後にシェルを起動しても読み込まれない。

### .tcshrc (tcsh)
tcsh を起動した際に読み込まれる設定ファイル。
login 後にシェルを起動した際にも毎回読み込まれる。

### .cshrc (csh,tcsh)
csh を起動した際に毎回読み込まれる設定ファイル。
tcsh の場合には .tcshrc がない場合にこのファイルが読み込まれる。
.tcshrc の中で .cshrc を読み込むように設定し .cshrc には csh, tcsh に共通する設定を記述することも多い。

### .logout (csh, tcsh)
login shellを csh, tcsh にした場合、端末から logout する際に実行される設定ファイル。
ユーザの tmp ファイルの削除や、画面のクリア、メッセージの表示などを設定することができる。

## bash まとめ
以下の設定ファイルはbashを使用するユーザ向けです。

### .profile (sh, bash)
login shellを sh, bash にした場合(rootのlogin shell を除けば、shにすることはほとんどないが)に端末から login した際に読み込まれる設定ファイル。
login 後にシェルを起動しても読み込まれない。

### .bash_profile (bash)
login shell を bash にした場合に端末から login した際に読み込まれる設定ファイル。
login 後にシェルを起動しても読み込まれない。

### .bash_logout (bash)
login shellを bash にした場合、端末から logout する際に実行される設定ファイル。

### .bashrc (bash)
bash を起動した際に読み込まれる設定ファイル。
login 後にシェルを起動した際にも毎回読み込まれる。 

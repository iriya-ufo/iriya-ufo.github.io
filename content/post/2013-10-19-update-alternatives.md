---
layout: post
title: 標準のコマンドの関連付けを変更 update-alternatives
slug: update-alternatives
date: 2013-10-19T18:17:35+00:00
comments: true
categories: programming
tags:
  - emacs
  - ubuntu
---

Ubuntu にて `update-alternatives` コマンドを使用すると標準コマンドの関連付けを変更できます。
例として Emacs の関連付けを変更する方法をみてみましょう。
Emacs がどこから実行されるか調べてみます。

    $ which emacs
    /usr/bin/emacs

次に実態を調べます。

    $ ll /usr/bin/emacs
    lrwxrwxrwx 1 root root 23 2008-01-06 23:03 /usr/bin/emacs -> /etc/alternatives/emacs

シンボリックリンクになっており実態は `/etc/alternatives/emacs` であることが分かります。

次に alternatives の正体を突き止めます。
    
    $ ll /etc/alternatives/emacs
    lrwxrwxrwx 1 root root 16 2008-03-25 18:47 /etc/alternatives/emacs -> /usr/bin/emacs22

となり結局のところの正体は `/usr/bin/emacs22` だと分かりました。

`ln -s` でシンボリックリンク先を変更してもいいのですが、こんなとき Ubuntu では以下のようにします。

    $ sudo update-alternatives --config emacs

そうすると対話形式でどれを標準にするか聞いてきますので簡単に関連付けの変更ができます。

### 参考
- http://ubulog.blogspot.com/2007/07/blog-post_09.html

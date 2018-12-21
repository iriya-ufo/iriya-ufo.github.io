---
layout: post
title: Mac OS X にインラインパッチの当たった Emacs を Homebrew でインストール
slug: install-emacs-by-homebrew
date: 2013-05-18T08:30:49+00:00
comments: true
categories:
  - "programming"
tags:
  - "emacs"
---

先ほど Homebrew のアップデートをしたところ Emacs が使えなくなりました。
古い Emacs が削除されてリンク先が消滅したのが原因でした。
これはいい機会？と思い最新の Emacs 24.3 を使うことにします。

まず今入っている Emacs を削除します。

    $ brew remove emacs

インラインパッチを当てます。

    $ brew edit emacs

下記コードを加えましょう。

```sh
def patches
  if build.include? "cocoa" and not build.head?
     { :p0 =&gt; "https://gist.github.com/ganta/5139150/raw/8f6fc32747c40a51de597ce73085f56764a7d3ed/japanese-patch-for-emacs-24.3.patch" }
  end
end
```

Emacs をインストールします。

    $ brew install emacs --cocoa --use-git-head

シンボリックリンクを張ります。

    $ ln -s /usr/local/Cellar/emacs/24.3/Emacs.app /Applications

以上となります。

### 参考

- [Homebrewのemacsをeditしてインラインパッチなどを当てる（Emacs-24.3）](http://qiita.com/items/0824b0a4fd1eaae67019")

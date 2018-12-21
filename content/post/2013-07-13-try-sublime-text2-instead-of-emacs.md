---
layout: post
title: Emacs 使いが Sublime Text 2 を練習してみた
slug: try-sublime-text2-instead-of-emacs
date: 2013-07-13T15:43:18+00:00
comments: true
categories:
  - "programming"
tags:
  - "emacs"
  - "sublime text"
---

知り合いのプログラマーが Sublime Text いいよーっていうもんだから、気になったので練習してみました。
普段は Emacs 使ってる私ですが、結論から言いますと、Emacs から Sublime Text への移行は無理です！

理由は単純明快です。今までずっと使ってきた Emacs の資産を捨てられなかったからです。
まず手に馴染んでいないキーバインドは作業効率を著しくさげてしまいます。幸い Sublemacspro というパッケージを導入することで Emacs のキーバインドに変更することができました。
しかし ESC や Meta に相当するものがないので困りました。

まぁキーバインドはいいとして、問題は今まで使ってきた `.elisp` の資産を引き継げないということでした。
そもそも Sublime Text 使うんだから今までの Emacs は捨てるべきなんですよね。移行とかいう考えがおかしい。でもそれが私にはできなかった。

確かに Sublime Text はすばらしいエディターです。カスタマイズは柔軟にできるし、デフォルトの機能だけでもすごく充実してるものがたくさんあります。
マルチカーソルとかいう変態機能、なんですか、あれ。びっくりです。

もし、これからプログラムを始めるという人でエディターで迷ってるなら、Sublime Text はあなたの能力を引き上げる強力な味方になるでしょう。

老害の私は Emacs と共にしんでいきます。

## Ubuntu に Sublime Text をインストール

一応、備忘録としてインストール方法を書き残しておきます。
ソースからインストールする方法もありますが、Ubuntu だと以下のようにしてPPAでインストールするのが楽ですね。

    $ sudo add-apt-repository ppa:webupd8team/sublime-text-2
    $ sudo apt-get update
    $ sudo apt-get install sublime-text

後はドットインストールの動画とか見ながら練習するといいですね。

## Emacsキーバインドに変更

Sublime Text のキーバインドを Emacs 風に変更します。

メニューバー View → Show Console でコンソールを表示します。

以下のコードをコンソールに入力して Enter キー押下します。

```python
import urllib2,os; pf='Package Control.sublime-package'; ipp=sublime.installed_packages_path(); os.makedirs(ipp) if not os.path.exists(ipp) else None; urllib2.install_opener(urllib2.build_opener(urllib2.ProxyHandler())); open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read()); print 'Please restart Sublime Text to finish installation'
```

再起動を促すメッセージが表示されるので Sublime Text を再起動します。これで Package Control が有効になります。

そして以下の手順を踏めば Emacs キーバインドが有効になるかと思います。

- ctrl+shift+p でコマンドパレットを表示
- Package Control: Install Package を選択
- 入力フィールドが表示されるので emacs と入力
- Sublemacspro を選択する

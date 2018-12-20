---
layout: post
title: Mavericks にアップグレードしたらターミナルが落ちた
date: 2014-07-22T12:31:08+00:00
comments: true
categories: programming
tags:
  - emacs
  - homebrew
  - mac
  - rbenv
  - shell
  - zsh
---

今更ですが Lion から Mavericks にアップグレードしました。OS のアップグレードは色々トラブルが起こるのであまりしたくないのですが、流行りについていかないのもなぁと思いアップグレードを実行しました。

そしたらターミナルが起動しなくなりました。一瞬起動したような感じがするのですが、すぐにウィンドウが消えます。標準のターミナルでも iTerm でも同様の症状なので zsh 周りの問題だろうと考え、一度ログインシェルを `/bin/bash` へと変更しました。変更の仕方は「システム環境設定」=>「ユーザーとグループ」にて変更するための鍵をクリックし、ログインユーザーを右クリックで詳細オプションを見ます。そこに見えるログインシェルをひとまず `/bin/bash` などに変更すればターミナルが使えるようになります。

色々いじったので順番は定かではないのですが、以下のようにしたら直りました。

まず Xcode を AppStore 経由でアップグレードします。終わったらターミナルからコマンドラインツールをインストールします。

    $ xcode-select --install

ここで zsh のチェックをすると、以下のようなエラーでした。
 
    $ /usr/local/bin/zsh --version
    dyld: Library not loaded: /usr/local/lib/libgdbm.4.dylib
      Referenced from: /usr/local/bin/zsh
      Reason: image not found

brew 周りが怪しいので掃除します。

    $ brew update
    $ brew outdated
    $ brew upgrade foobar # 気になるものだけアップグレード
    $ brew doctor # エラーを潰す

gdbm と pcre 周りの link を再設定します。

    $ brew unlink gdbm && brew link gdbm
    $ brew unlink pcre && brew link pcre

ここまででひとまず `/usr/local/bin/zsh` でログインできるようなりました。ちなみにログインシェルの変更は以下のようにします。

    $ chpass -s /usr/local/bin/zsh
    $ chpass # 確認

またログインシェルは先ほどのユーザーとグループの詳細オプションからも確認できます。

そしてなぜか rbenv のコマンドが見つからないぞ、と怒られたので rbenv は brew で再インストールしたら直りました。

これで一件大丈夫なように思いましたが、その他何か挙動がおかしい気がします。調べてみたところ、Marvericks へのアップグレードで brew へのパスがおかしくなっているようです。以下のようにして全て relink しました。

    $ brew list | xargs brew unlink
    $ brew list | xargs brew link

以下のものについては `--force` 付きで強制的に relink しました。 (brew doctor で keg-only だから unlink しろと怒られます)

    gettext
    libffi
    openssl
    ossp-uuid
    readline

また zsh のパスが重複してることに気づいたので以下を `.zshrc` に書いてパスの重複を無くしました。

    typeset -U path PATH

emacs の起動ができなかったので brew で再インストールします。
 
    $ brew remove emacs
    $ brew install emacs --cocoa --use-git-head
    $ brew linkapps

再度 emacs を起動すると以下のようなエラーがでました。migemo を読み込む際に、IME 周りで変なことになっているっぽいです。

    Symbol's function definition is void: mac-change-language-to-us

僕は普段 Google 日本語入力を使用しているのですが、Mavericks から U.S. の入力ソースが削除できないっぽい感じになっていました。
少しトリッキーですが<a href="http://hetima.hatenablog.jp/entry/2013/10/26/032001" target="_blank">こちら</a>を参考にして、一度ことえりを追加したら U.S. を削除できました。

しかし依然として emacs の起動ができません。どうやらインラインパッチのあたった emacs ではないようなので再度インストールします。 
`/usr/local/Library/Formula/emacs.rb` を見るとオプションで制御できるようになっているっぽいのでオプション付きでインストールします。

    $ brew remove emacs
    $ brew install emacs --cocoa --japanese
    $ brew linkapps

これで無事起動するようになりました。いい機会なので少し `.emacs` の設定を変更しました。<a href="https://github.com/iriya-ufo/dotfiles/blob/master/Mac/.emacs" title=".emacs" target="_blank">こんな感じ</a>に設定してます。

これで Mavericks とも仲良く暮らしていけそうです。

<span style="color: #ff0000;"><u><strong>追記 7/29</strong></u></span>
しばらく問題なく使えていましたが、とある Rails のプロジェクトが動かなくて、この原因が OS アップデートによるものだと分かったので追記します。

その Rails プロジェクトでは ffi という gem を使っていたのですが、それが bundle install できませんでした。brew で libffi を unlink もしくは link しても効果がなかったです。以下のようにして直すことができました。

まず Xcode Command Line Tools をインストールしてみる。

     $ xcode-select --install

すると「このソフトウェアは、現在ソフトウェア・アップデート・サーバから入手できないため、インストールできません。」というメッセージが出てインストールできなかったので<a href="http://blog.mylibs.jp/archives/38" target="_blank">こちら</a>を参考にして GUI からコマンドラインツールをインストールしました。ちなみに Xcode は 6-beta4 というベータ版です。

そして bundle install で ffi をインストールしようとしたときに出たエラーが以下です。

    You have to install development tools first.

<a href="http://qiita.com/mah_lab/items/e3493a99af31d61c81be" target="_blank">ここ</a>を参考にして下記コマンドを実行しました。

    $ sudo ln -s /usr/bin/gcc /usr/bin/gcc-4.2

以上で bundle install ができ ffi が入って Rails も動作しました。

<a href="http://shirusu-ni-tarazu.hatenablog.jp/entry/2013/12/09/002059" target="_blank">こちら</a>のサイトにまとめられています。

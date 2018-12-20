---
layout: post
title: i-node が枯渇してファイルの作成ができなくなった件
date: 2013-09-18T21:35:15+00:00
comments: true
categories: programming
tags: ubuntu
---

久しぶりに Ubuntu を使ってたらカーネルの更新が来てました。
適当にインストールしてたら何を間違えたのかうまくインストールできずに壊れました。

Ubuntu はよくできているので、エラーメッセージに出るコマンドの通りに打つとたいてい治ります、が今回は無理でした。

再度でたエラーメッセージは"デバイスに空き領域がありません"。
あれ、HDDには十分な空き領域があるのになんでだろう。

結果、i-node が枯渇してることが分かりました。
私の Ubuntu は、ずーーーーっとアップデートで対応してきたので相当ムダなファイルが多いのでしょう。

ちなみに i-node は `$ df -i` と打つことで調べられます。

どこに大量のファイルがあるのか以下のコマンドで調査していきます。

    $ sudo find . -xdev -type f | cut -d "/" -f 2 | sort | uniq -c | sort -n

結果、こんな場所に大量のファイルが・・・

    /lib/modules
    /usr/src
    /tmp
    /var/log

原因は昔のカーネルが残っていたことでした。
2.6系のカーネルなんか残してても意味ないですね。
ほとんど削除することで i-node の領域が確保できました。
ちなみに i-node 100% から 35% に減少しました。

これで apt-get できる！と思ったらまたエラー発生です。
apt/lists のパッケージのハッシュ値が違うと怒られました。
以下のコマンドで直せます。

    $ sudo apt-get clean
    $ cd /var/lib/apt
    $ sudo mv lists lists.old
    $ sudo mkdir -p lists/partial
    $ sudo apt-get clean
    $ sudo apt-get update

そして最新のカーネルを強制インストールすることで作業完了です。
またカーネル更新すると必ず virtualbox の更新もしないといけないので(もしインストールしてたらね)更新します。

    $ sudo apt-get install virtualbox-dkms --reinstall

これで終わり！

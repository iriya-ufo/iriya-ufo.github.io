---
layout: post
title: zsh で git のコマンド補完及びブランチ名の表示
slug: git-completion-by-zsh
date: 2013-05-18T07:58:33+00:00
comments: true
categories:
  - "programming"
tags:
  - "git"
  - "homebrew"
  - "zsh"
---

## git のコマンド補完

まず git のコマンド補完ができるようにします。前提として zsh と git は Homebrew でインストールしておきます。私の環境では zsh も git も古かったのでアップデートしました。

    $ brew update   # brew のアップデート
    $ brew outdated # 古い Formula の表示
    $ brew upgrade  # 古い Formula の一括アップデート
    $ brew cleanup  # 古い Formula の削除

久しぶりに brew 使ったら **Warning** がいっぱいでてしまいました。
`/usr/local` 配下を `chown` で `$ whoami` 権限に変更し、後は `$ brew doctor` でちまちま直していきました。

Homebrew についてはこちら『[Homebrew 使い方メモ](http://w.koshigoe.jp/study/?%5Bsystem%5D%5Bosx%5D+Homebrew+%BB%C8%A4%A4%CA%FD%A5%E1%A5%E2")』に詳しく書いてくださっています。すばらしい！

さてこれで zsh も git も新しくなりました。実はこれだけで git の補完は終わりです！

また `zsh のバージョンが 5.0.2 以上` `git のバージョンが 1.8.2.3 以上` この状態であるなら `/usr/local/share/zsh/site-functions` に git 用の補完定義ファイルがあるかと思います。
そして自動で zsh に対して symlink が張られているはずです。ファイルがなければ `$ brew link git` とすればOKです。

最後に `.zshrc` に次の一行を追加します。

    fpath=(~/.zsh/functions/Completion /usr/local/share/zsh/functions ${fpath})

これで git のコマンド補完はできました。

## ブランチ名の表示

調べてみたところ、皆さん色々な方法でやってるみたいですけど、今なら **vcs_info** を使って設定するのがよさそうです。
インストールなどは必要ないので自分の好きなように `.zshrc` をカスタマイズしていけばいいですね。
私はこんな感じでシンプルに使ってます。

```sh
# VCS Setting
autoload -Uz vcs_info
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] &amp;&amp; psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"
```

### 参考

- [zshでGitのブランチ名をプロンプトに表示する](http://liosk.blog103.fc2.com/blog-entry-209.html)
- [zsh の vcs_info に独自の処理を追加して stash 数とか push していない件数とか何でも表示する](http://qiita.com/items/8d5a627d773758dd8078")

---
layout: post
title: "percol から fzf に移行した"
slug: percol-to-fzf
date: 2019-01-16T13:51:53+09:00
lastmod: 2019-01-16T13:51:53+09:00
comments: true
categories:
  - "programming"
tags:
  - "percol"
  - "fzf"
---

新調した Mac mini の開発環境を整えていたら、どうも percol が動作してくれない。Python3 ではうまく動かないらしい。
直そうと思って調べてみるとどうやら peco や fzf の方がナウいらしいので移行することにした。
tmux の相性がいいとのことなので fzf を入れることにする。

# percol のアンインストール

大抵の人は pip でインストールしているはず。

``` bash
$ pip uninstall -y "percol==0.2.1"

# percol 以外のパッケージも全部消していい場合
$ pip freeze | xargs pip uninstall -y
```

設定ファイルを削除する。

``` bash
$ rm -rf ~/.percol.d
```

`.zshrc` などに設定があれば削除する。

``` bash
$ vim ~/.zshrc
```


# fzf のインストール

brew で入れるだけ。

``` bash
$ brew install fzf
```

## 設定ファイル

素直に `~/.zshrc` に関数を追加していくと肥大化するので `~/.zsh/functions/` 配下に関数毎にファイルを作って、それらを読み込むようにした。

``` shell
$ tree ~/.zsh/functions
~/.zsh/functions
├── cdf
├── fd
├── fh
├── fkill
├── frepo
├── fshow
└── fssh

0 directories, 7 files
```

各ファイルの中身

{{< gist 7a46a337562ecb23f3116808aa1d8c54 >}}

`~/.zshrc` で autoload と bindkey の設定をする。

``` shell
fpath=(~/.zsh/functions ${fpath})

# autoload fzf functions
for widget_name in ~/.zsh/functions/*; do
  local function_name="${widget_name:t}"
  zle -N "${function_name}"
  autoload -Uz "${function_name}"
done

bindkey -e     # emacs-like
bindkey '^r'   fh
bindkey '^xf'  cdf
bindkey '^xd'  fd
bindkey '^xk'  fkill
bindkey '^xp'  frepo
bindkey '^xgs' fshow
bindkey '^xs'  fssh
```

これで快適な CLI ライフが送れるようになった。

# 参考

- [公式 Wiki Examples](https://github.com/junegunn/fzf/wiki/examples)
- [おい、peco もいいけど fzf 使えよ](https://qiita.com/b4b4r07/items/9e1bbffb1be70b6ce033)

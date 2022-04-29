---
layout: post
title: "Xenv から asdf に移行する"
slug: asdf-install
date: 2022-04-29T21:09:55+09:00
lastmod: 2022-04-29T21:09:55+09:00
comments: true
categories:
  - "programming"
tags:
  - "asdf"
---

## きっかけ

anyenv 関係をキャッシュするというテクニックで zsh の起動を速くするという記事をみました。
自分は anyenv は使ってませんが、いくつかの Xenv 系を直接インストールしてバージョン管理をしていました。
asdf は速いというのと一つにまとめたいという思いがあったので、移行することにしました。

## 現在の環境

Mac を使っています。

ホームディレクトリ配下にあるディレクトリ

- `.nodenv`
- `.npm`
- `.pyenv`
- `.rbenv`
- `.terraform.d`

brew で入ってるやつ

- `nodenv`
- `node-build`
- `pyenv`
- `rbenv`
- `rbenv-gemset`
- `ruby-build`
- `tfenv`

zsh の起動速度

```bash
$ time ( zsh -i -c exit )
( zsh -i -c exit; )  0.24s user 0.25s system 98% cpu 0.504 total
```

## asdf のインストール

調べた感じだと既存の環境に影響ないようなので、まず asdf の環境を整えます。
公式を見るといくつか方法があるようで、自分は brew と zsh を使いました。
ちなみに Mac 以外にも Arch にインストールしたのですが Paru 経由だとなぜか `asdf.sh` が見つからなかったため Arch 環境では Git でインストールしました。

- [Getting Started | asdf](http://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)

```bash
$ brew install coreutils curl git # すでにある場合は不要
$ brew install asdf
$ echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
```

インストールできたらターミナルを再起動します。

## asdf の使い方

ここから先は、どんな環境を作る場合でも共通の方法になります。

流れとしては以下の通り。

1. プラグインを探す
2. プラグインをインストール
3. 使用したいバージョンをインストール
4. プロジェクト毎で使いたいバージョンを lock する

```bash
$ asdf plugin list all        # プラグインの一覧
$ asdf plugin add python      # プラグインのインストール
$ asdf plugin list            # インストール済みプラグインの一覧
$ asdf list all python        # インストール可能な環境の一覧
$ asdf install python 3.7.10  # 特定のバージョンをインストール
$ asdf global python 3.7.10   # グローバルで利用
$ asdf local python 3.7.10    # バージョンの固定 .tool-versions というファイルが作成される
```

## Xenv 系のアンインストール

asdf は env 系と良い感じに共存できるっぽいことを書いていましたが、両方あるのは気持ち的に落ち着かないので env 系は全削除することにします。

### nodenv のアンインストール

```bash
$ npm uninstall npm -g
$ rm -rf ~/.npm
$ rm -rf ~/.nodenv
$ brew uninstall nodenv node-build
```

`~/.zshrc` から以下を削除します。

```bash
export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"
```

### pyenv のアンインストール

現在の状況

```bash
$ which python
/Users/iriya/.pyenv/shims/python
$ which pip
/Users/iriya/.pyenv/shims/pip
$ which pipenv
/Users/iriya/.pyenv/shims/pipenv
```

削除

```bash
$ rm -rf ~/.pyenv
$ brew uninstall pyenv
```

`~/.zshrc` から以下を削除します。

```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

### rbenv のアンインストール

```bash
$ rm -rf ~/.rbenv
$ brew uninstall rbenv rbenv-gemset ruby-build
$ rm -rf /usr/local/etc/rbenv.d  # もしあれば
```

`~/.zshrc` から以下を削除します。

```bash
eval "$(rbenv init -)"
```

emacs の設定ファイルに下記があったので削除します。

```bash
;; rbenv path setting
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))
```

### tfenv のアンインストール

```bash
$ rm -rf ~/.terraform.d
$ brew uninstall tfenv
```

## 検証

速くなりました。Xenv 系の init 処理は結構重たいんですね。

```bash
$ time ( zsh -i -c exit )
( zsh -i -c exit; ) 0.13s user 0.10s system 98% cpu 0.234 total
```

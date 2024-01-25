---
layout: post
title: "Emacs 小技集"
slug: emacs-tips
date: 2024-01-26T01:26:18+09:00
lastmod: 2024-01-26T01:26:18+09:00
comments: true
categories:
  - "programming"
tags:
  - "emacs"
---

自分のための覚書

使用頻度が低いため忘れやすい、でも覚えておくとチョット便利なやーつ

## Tips

``` bash
C-x r t string RET             # 複数行の先頭に文字列を挿入
M-x delete-trailing-whitespace # 行末の空白を削除
M-x toggle-truncate-lines      # 行の折り返しのオンオフ
M-g g RET 行番号               # 特定の行番号へジャンプ
M-y                            # キルリングのリスト
C-/                            # 取消 Undo
C-o                            # ハイライトシンボル
```

## 検索

``` bash
M-x find-name-dired    # ワイルドカードでファイル名検索
M-x find-grep-dired    # ファイルの内容を検索
```

## 置換

``` bash
M-x replace-string    # 一括置換
M-x query-replace     # 問い合わせ置換

タブ -> スペース置換
C-x h                 # 全選択して
M-x untabify          # タブをスペースに変換
```

## ファイルのリネーム

``` bash
C-x C-f RET    # Dired モードに入る
               # リネームしたいファイルで R
               # バッファにファイル名を打ち込んで RET
               # q で Dired から抜ける
```

## 文字コード

``` bash
C-x RET r utf-8    # 文字化けしてる時(UTF-8のファイルなのにSJISで開いちゃった)
C-x RET f utf-8    # 文字化けしてない時(SJISのファイルをUTF-8で保存したいとき)
```

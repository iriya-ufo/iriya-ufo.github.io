---
layout: post
title: Emacs の info の使い方と info ドキュメントインストールの仕方
slug: how-to-use-emacs-info-and-document-install
date: 2013-10-19T19:19:20+00:00
comments: true
categories: programming
tags:
  - emacs
  - gauche
  - sicp
  - ubuntu
---

## info の使い方
info は Emacs の中で説明を読むしくみ。

`M-x info` または `C-h i` で開始する。

    u       up      一つ上に戻る
    d       dir     入口に戻る
    M-x info        info を開始する
    q       quit    終了
    space           とにかく読み進む
    p       prev    前の節に戻る
    n       next    次の節に進む
    RET             矢印 (cursor) のある節に進む
    m       menu    (その画面の中の) 名前で指定して移動する

## info ドキュメントのインストール
ここでは SICP, Gauche, R5RS の info のインストールをやってみる。

### SICP info
以下より sicp.info.gz をダウンロードし `/usr/share/info` に置く。

- http://www.neilvandyke.org/sicp-texi/

`/usr/share/info` の dir ファイルに以下を付け足す。

    SICP
    * SICP: (sicp).    Structure and Interpretation of Computer Programs.

### Gauche info
Gauche の info をインストールする。
 
    $ sudo apt-get install texinfo
    $ cd Gauche-0.8.11/doc
    $ make -f Makefile.in texi
    $ makeinfo gauche-refj.texi
    $ sudo cp gauche-refj.info* /usr/share/info

dir ファイルを編集する。

     Gauche
     * Gauche(ja):   (gauche-refj.info).     An R5RS Scheme implementation.

### R5RS info
`/home/iriya/lisp/scheme/r5rsj/texi` から info ファイルを `/usr/share/info` にコピーする。

    $ sudo cp *info* /usr/share/info

dir ファイルを編集する。

    R5RS
    * R5RS:         (r5rsj.info).           Revised^5 Report on Algorithmic Language Scheme.

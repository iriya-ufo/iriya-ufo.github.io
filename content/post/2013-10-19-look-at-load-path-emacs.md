---
layout: post
title: Emacs の load-path の調べ方
slug: look-at-load-path-emacs
date: 2013-10-19T18:07:23+00:00
comments: true
categories: programming
tags: emacs
---

Emacs で load-path を調べてそれを見やすく表示させる方法です。

`*scratch*` バッファで以下を評価します。

    load-path [Ctrl+j]

次に `(` にカーソルを移動して以下を実行します。

    M-x query-replace-regexp RET
    Query replace regexp: (半角空白) RET
    Query replace regexp   with: C-q C-j
    RET

そして `!` で全て置換します。

これで load-path が見やすく表示されます。

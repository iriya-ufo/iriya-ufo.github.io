---
layout: post
title: Mac に AUCTeX をインストールした
slug: auctex-to-mac-emacs
date: 2014-04-13T15:34:38+00:00
comments: true
categories: programming
tags:
  - auctex
  - emacs
  - mac
---

昔書いてた TeX を Mac 環境で快適に使う設定を始めたのが運のつき・・・めちゃ時間かかりました。
TeX はもうバッドノウハウの固まりって感じがして好きじゃなくなってきたけど、数学するなら TeX 必須なんですよねぇ。

ということで全部入りで簡単にインストールできる方法を紹介します。

## MacTeX
<a href="http://tug.org/mactex/" title="MacTeX" target="_blank">ここ</a>から全部入りでインストールできます。全部入りなのでファイル容量がすごいことになってます。

## Emacs に AUCTeX をインストール
Emacs のパッケージシステムを使って AUCTeX をインストールします。

    M-x package-list-packages

インストールできたら `.emacs` に設定を書きます。

```lisp
;;
;;====================================
;; AUCTeX
;;====================================
(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-LaTeX-command-default "pLaTeX")
(setq japanese-LaTeX-default-style "jsarticle")
(setq TeX-output-view-style '(("^dvi$" "." "xdvi '%d'")))
(setq preview-image-type 'dvipng)
(setq TeX-file-extensions '("tex" "sty" "cls" "ltx" "texi" "texinfo" "dtx"))
(setq LaTeX-clean-intermediate-suffixes '("\\.aux" "\\.log" "\\.out" "\\.toc" "\\.brf" "\\.nav" "\\.snm"))
(setq TeX-view-program-list '(("TeXShop" "open -a TeXShop.app %o")
                              ("open" "open %o")
                              ))
(setq TeX-view-program-selection '((output-pdf "TeXShop")
                                   (output-html "open")
                                   ))
(add-hook 'LaTeX-mode-hook (function (lambda ()
  (add-to-list 'TeX-command-list
    '("pLaTeX" "%(PDF)platex %`%S%(PDFout)%(mode)%' %t"
     TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX"))
  (add-to-list 'TeX-command-list
    '("dvi" "dvipdfmx -V 4 '%s' " TeX-run-command t nil))
  (add-to-list 'TeX-command-list
    '("pdf" "open -a TeXShop.app '%s.pdf' " TeX-run-command t nil))
)))
(setq kinsoku-limit 10)
(setq LaTeX-indent-level 4)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
```

`C-c C-c` で platex でコンパイルします。あとは同じコマンドを叩いて、dvi と pdf をすれば `TeXShop.app` が起動して見られます。

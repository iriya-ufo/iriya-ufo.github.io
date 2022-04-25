---
layout: post
title: "Emacs に Neotree を導入する"
slug: neotree-to-emacs
date: 2022-04-25T21:16:32+09:00
lastmod: 2022-04-25T21:16:32+09:00
comments: true
categories:
  - "programming"
tags:
  - "emacs"
---

Neotree をインストールしました。
straight を使っているので `use-package` と書くだけでインストールされます。
使い方は以下 elisp 見ればなんとなく分かるでしょう。

```
;; ------------------------------------------------------------------
;; brief   : Neotree
;; note    : https://github.com/jaypei/emacs-neotree
;; ------------------------------------------------------------------
(use-package neotree
  :init
  (setq-default neo-keymap-style 'concise)
  (setq-default neo-show-hidden-files t)
  :config
  (setq neo-smart-open t)
  (setq neo-create-file-auto-open t)
  (setq neo-theme 'arrow)
  (bind-key "C-c C-o" 'neotree-toggle)
  (bind-key "RET" 'neotree-enter-hide neotree-mode-map)
  (bind-key "a" 'neotree-hidden-file-toggle neotree-mode-map)
  (bind-key "<left>" 'neotree-select-up-node neotree-mode-map)
  (bind-key "<right>" 'neotree-change-root neotree-mode-map))

;; Change neotree's font size
;; Tips from https://github.com/jaypei/emacs-neotree/issues/218
(defun neotree-text-scale ()
  "Text scale for neotree."
  (interactive)
  (text-scale-adjust 0)
  (text-scale-decrease 0.5)
  (message nil))
(add-hook 'neo-after-create-hook
          (lambda (_)
            (call-interactively 'neotree-text-scale)))

;; Hide neotree window after open file
;; Tips from https://github.com/jaypei/emacs-neotree/issues/77
(defun neo-open-file-hide (full-path &optional arg)
  "Open file and hiding neotree.
The description of FULL-PATH & ARG is in `neotree-enter'."
  (neo-global--select-mru-window arg)
  (find-file full-path)
  (neotree-hide))

(defun neotree-enter-hide (&optional arg)
  "Neo-open-file-hide if file, Neo-open-dir if dir.
The description of ARG is in `neo-buffer--execute'."
  (interactive "P")
  (neo-buffer--execute arg 'neo-open-file-hide 'neo-open-dir))
```

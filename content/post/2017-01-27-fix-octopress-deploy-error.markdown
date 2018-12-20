---
layout: post
title: "Octopress Deploy エラーなおした"
date: 2017-01-27 16:05:43 +0900
comments: true
categories: programming
---

当ブログは Octopress と GitHub Pages で運用しているのだけれど、別PCに移行したときにデプロイエラーが出たのでそれをなおした。

エラー内容はこんな感じ。

    ## Pushing generated _deploy website
    To github.com:iriya-ufo/iriya-ufo.github.io.git
     ! [rejected]        master -> master (non-fast-forward)
    error: failed to push some refs to 'git@github.com:iriya-ufo/iriya-ufo.github.io.git'
    hint: Updates were rejected because the tip of your current branch is behind
    hint: its remote counterpart. Integrate the remote changes (e.g.
    hint: 'git pull ...') before pushing again.
    hint: See the 'Note about fast-forwards' in 'git push --help' for details.

解決方法は以下の通り。

    cd _deploy
    git reset --hard origin/master
    cd ..

    rake generate
    rake deploy

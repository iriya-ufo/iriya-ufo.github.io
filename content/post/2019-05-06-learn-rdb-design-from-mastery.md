---
layout: post
title: "「達人に学ぶ DB設計 徹底指南書」を読んだ"
slug: learn-rdb-design-from-mastery
date: 2019-05-06T19:31:59+09:00
lastmod: 2019-05-06T19:31:59+09:00
comments: true
categories:
  - "review"
tags:
  - "database"
---

データベース設計ってどうやるの？って所をちゃんと知りたかったので読んでみた。若干期待していたのと違ったがたくさん学びもあった。
自分がタイトルから想像したのは、例題やサンプルアプリケーションみたいなのを提示してそれらをどうモデリングするかっていう感じかなと勝手に思ったんだけど、どっちかっていうと当たり前のことをちゃんと考えて設計していきましょうね、っていう内容だった。

第一章、第二章はデータベース触ったことある人(≠設計者)なら知ってる内容で、第三章は設計したことある人なら知っているであろう正規化の話しが展開されている。
それから六章まではパフォーマンスがメインで、七章、八章あたりはアンチパターンの話しに入る。
九章はこれまでと変わって木構造データの扱いについていくつかの方法を紹介していた。

今まで Rails しか書いてきませんでした、データベース設計とかよく分かっていません、正規化は言葉くらいなら知っている、くらいの段階の人たちにとりあえずこれを読むことをおすすめする。
もし過去に戻れるならば、三年前の自分に『この本をしっかり読んでおけ』と言いたかった。

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4798124702/iriyaufo-22" name="amazletlink" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/61bMuQNwkoL._SL160_.jpg" alt="達人に学ぶDB設計 徹底指南書 初級者で終わりたくないあなたへ" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4798124702/iriyaufo-22" name="amazletlink" target="_blank">達人に学ぶDB設計 徹底指南書 初級者で終わりたくないあなたへ</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 19.05.06</div></div><div class="amazlet-detail">ミック <br />翔泳社 <br />売り上げランキング: 11,263<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4798124702/iriyaufo-22" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>
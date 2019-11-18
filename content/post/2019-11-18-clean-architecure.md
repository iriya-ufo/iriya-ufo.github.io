---
layout: post
title: "「Clean Architecture 達人に学ぶソフトウェアの構造と設計」を読んだ"
slug: clean-architecure
date: 2019-11-18T15:07:17+09:00
lastmod: 2019-11-18T15:30:17+09:00
comments: true
categories:
  - "programming"
tags:
  - "clean architecture"
---

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4048930656/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/51LkcwTMC8L._SL160_.jpg" alt="Clean Architecture 達人に学ぶソフトウェアの構造と設計" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4048930656/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Clean Architecture 達人に学ぶソフトウェアの構造と設計</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 19.11.18</div></div><div class="amazlet-detail">Robert C.Martin <br />KADOKAWA (2018-07-27)<br />売り上げランキング: 8,168<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4048930656/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>

これを読む人は、あの同心円状の The Clean Architecture の図を見たことがあるだろう。
もしかしたら The Clean Architecture についてのより詳しい説明を求めていたかもしれない。
だが本書では詳細は取り扱っていない。
アーキテクチャ全般について、より原理原則の立場からアーキテクトとはなにかを語っている。

アーキテクチャの原理原則とは何なのか、印象深かった部分を引用しながら紹介したい。

## パラダイムは規律を課す

以下の言葉はプログラマーなら当然知っているものだと思う。

- 構造化プログラミング
- オブジェクト指向プログラミング
- 関数型プログラミング

アーキテクトの観点からみれば、これらは **何らかの制限** を加えているものだという。
その制限とは以下の通りだ。

- 構造化プログラミングは **直接的な制御の移行に規律を課す**
- オブジェクト指向プログラミングは **間接的な制御の移行に規律を課す**
- 関数型プログラミングは **代入に規律を課す**

構造化プログラミングではモジュールを機能的に分割する。
上位レベル機能はそれより小さな下位の機能へ、さらに小さな下位の機能へ、といった具合に分割していける。
制御構造とは goto のような直接的制御の移行をしないという制約なのだ。

オブジェクト指向におけるパワーとは、ポリモーフィズムによる依存関係の制御である。
典型的な呼び出しツリーでは main 関数が上位レベルの関数を呼び出しさらに下位レベルの呼び出しへと向かっていく。
この呼び出しはソースコードの依存関係と制御の流れが酷似しているのだ。
ポリモーフィズムを使うことでコードの依存と制御は逆転させることができる。

関数型プログラミングにおける重要な点は「変数は変化しない」という不変性である。
不変しないのだからプログラマは安心してデータにアクセスできる。
どうしても副作用が必要な場合は、不変な部分とそうでない部分でコンポーネントを分ければよい。
不変なコンポーネントは並行して処理を走らせることもできる。

> 「第三章 パラダイムの概要」より

## SOLID 原則

クリーンなコードを書く上で重要な原則だ。それぞれの頭文字をとって SOLID 原則と呼ばれている。

**単一責任の原則 (SRP：SingleResponsibilityPrinciple)**

- モジュールはひとつのアクターに対して責務を負うべきである。アクターの異なるコードは分割する。

**オープン・クローズドの原則 (OCP：OpenClosedPrinciple)**

- ソフトウェアを変更しやすくするために、既存のコードの変更よりも新しいコードの追加によって、システムの振る舞いを変更できるように設計すべきである。

**リスコフの置換原則 (LSP：LiskovSubstitutionPrinciple)**

- 交換可能なパーツを使ってソフトウェアシステムを構築するなら、個々のパーツが交換可能となるような契約に従わなければいけないということ。

**インターフェイス分離の原則 (ISP：InterfaceSegregationPrinciple)**

- ソフトウェアを設計する際には、使っていないものへの依存を回避すべきだという原則。

**依存関係逆転の原則 (DIP：DependencyInversionPrinciple)**

- 上位レベルの方針の実装コードは、下位レベルの詳細の実装コードに依存すべきではなく、逆に詳細側が方針に依存すべきであるという原則。

## 非循環依存関係の原則

コードには依存関係がある。コンポーネントをデプロイの単位で切ったとき、そのコンポーネントは以下のような特徴がなければいけない。

- コンポーネントの依存構造に循環依存があってはいけない、安定したコンポーネントに依存するようにする。
- コンポーネントが独立して循環依存がなければ、他のコンポーネントに影響されることなくデプロイができる。

## まとめ

他にも色々学びがある書籍だったが、図がないと説明が難しい部分も多いので、ここまでにしておく。

---
layout: post
title: "「入門 React」を読んだ"
slug: introduction-react-review
date: 2021-09-27T15:14:47+09:00
lastmod: 2021-09-27T15:14:47+09:00
comments: true
categories:
  - "review"
tags:
  - "react"
---

## 読んだ感想

いい本でした。しかし中身を見ずにタイトルだけで判断して買うと、期待したものと違うなぁってなるかもしれません。
この本の対象読者はチュートリアルを終えた人や「Hello World」の次が欲しいと思っている人たちです。
React に一度も触れていない状態で読むと学習効率が悪いでしょう。

またコードがES6に追いついていなかったのは残念です、少し古い本なので仕方ないかもしれませんが。具体的にはアロー関数や class などのコードを使っていないです。
環境構築に関しても、今は `create-react-app` を使うのが普通でしょう。各パッケージをインストールしたりビルドツールを構築したりする方法は取らなくても始められます。

## 本の内容に関して
各章においてどんなことが書いてあるのか備忘録も兼ねてメモ程度に記しておきます。

### 第二章

- JSX の pros, cons について

### 第三章

- コンポーネントのライフサイクルの詳細
  - どのメソッドがどのタイミングで呼ばれるのか
  - またそれぞれのタイミングで何を実装すべきか

### 第四章

props と state の使い分けについて

- props とは
  - プロパティ
  - コンポーネントに渡される任意のデータ
- state とは
  - コンポーネントの内部状態

### 第六章

- React は継承ではなく合成を利用してアプリケーションを構築する
- コンポーネントは props と state を入力として受け取り、HTMLとして返す一種の関数のようなもの

### 第八章

DOM操作について

- 基本的に直接DOMを触ることはないが、どうしても必要となるシーンが出てきた場合の対処方法

### 第十二章

サーバーサイドレンダリングについて

- サーバーサイドレンダリングというと Next.js で云々というのがよく話題にされるが、ここでは React におけるサーバーサイドレンダリングについて述べていた
  - たとえば `React.renderToString` など

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873117194/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">
      <img src="https://images-na.ssl-images-amazon.com/images/I/51YBn5cnE9L._SL160_.jpg" alt="入門 React ―コンポーネントベースのWebフロントエンド開発" style="border: none;" />
    </a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873117194/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">入門 React ―コンポーネントベースのWebフロントエンド開発</a>
    </div>
    <div class="amazlet-detail">Frankie Bagnardi (著), Jonathan Beebe (著), Richard Feldman (著), Tom Hallett (著), Simon HØjberg (著), Karl Mikkelsen (著), 宮崎 空 (翻訳)<br />オライリージャパン <br />売り上げランキング: 337,835<br />
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873117194/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

---
layout: post
title: "React を完全に理解するために行った学習方法"
slug: how-to-learn-react
date: 2021-11-30T23:38:39+09:00
lastmod: 2021-12-05T23:38:39+09:00
comments: true
categories:
  - "programming"
tags:
  - "react"
---

新しい言語やフレームワーク、触れたことのないアーキテクチャなどを習得しようとするとき、どのようにして学習していますか？
効率の良い学習方法というのは人によってそれぞれ違うと思いますが、自分ならこうしますという記事があれば少しは有益かもしれないと思い本記事を書いています。
ここでは React を学習するにあたって、どのような教材を用い、どのような方法で学んだかを残しておきます。
あくまで僕が行ってきた学習方法を書いていますので、これがベストの方法だ、という内容ではないのでご注意ください。

## 学習の前に

まず僕のバックグラウンドですが、普段は AWS で Web サービスのインフラ構築をしており、バックエンドに Rails を少し触っていた時期がある、という感じです。
フロントエンド領域は苦手意識をもっており、簡単な HTML と CSS および JavaScript(jQuery) が書けるくらいの程度です。
学習の基本方針としては、基礎的な部分はしっかり理解し、細かい書き方などはさっと目を通して、後で見直したときに思い出せればいいくらいの感覚でやっています。
また学習にはインプットとアウトプットが欠かせないと思いますが、僕の場合、学び始めはインプットにかなり時間をかけます。

今回行った学習期間ですが、9月頃から学習を始めたので、以下の内容は3ヶ月間くらいで行った学習量になります。

## 使用した教材など

以下記載の順序で学習していきました。


### Jsprimer

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://jsprimer.net/intro/" data-iframely-url="//cdn.iframe.ly/o76dptv"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

React の前にモダン JavaScript の理解は必須だと思ったので学習しました。非常に有益なサイトでした。オススメです。

### React.js & Next.js 超入門

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4798056928/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">
      <img src="https://images-na.ssl-images-amazon.com/images/I/511zU31nkmL._SL160_.jpg" alt="React.js&Next.js超入門" style="border: none;" />
    </a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4798056928/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">React.js & Next.js 超入門</a>
    </div>
    <div class="amazlet-detail">掌田 津耶乃(著)<br />秀和システム <br />売り上げランキング: 239,043<br />
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4798056928/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

超入門とあったので読んでみましたが、あまり良い本ではなかったです。説明がまわりくどい感じがしました。さっと流し読みして終わりました。

### フロントエンドエンジニアのための React・Redux アプリケーション開発入門

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://www.udemy.com/course/react-application-development/" data-iframely-url="//cdn.iframe.ly/LYgGGf8?card=small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

こちらは Udemy の講座になります。最近は動画での学習も流行っていますね。
この方はコードを書きながら説明をしていくというスタイルなので、実装の流れがみてわかるのが良かったです。

### React 公式チュートリアル

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://ja.reactjs.org/tutorial/tutorial.html" data-iframely-url="//cdn.iframe.ly/TEvyHem?card=small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

この段階で？という感じですが、React 公式のチュートリアルをやりました。
五目並べを実装していくチュートリアルです。とりあえず写経しましたが、この段階ではまだ React のことはよく分からないままです。

### React Hands On 資料

- https://nakanisi-yusuke.gitbooks.io/react-hands-on/content/

教材を探しているときに見つけました。クラスコンポーネントベースで古いためオススメしません。
この時はまだ関数コンポーネントとクラスコンポーネントでどっちがモダンなのかという知識さえ持ってませんでした。

### 入門 React

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

クラスコンポーネントベースであり、またアローファンクションを使ってない、など古い内容となっているためオススメしません。

この頃にようやく Hooks 登場以前の古い React と新しい React では書き方が大きく変わったのだなということを知りました。進化の早いフロントエンドはなるべく新しい情報に触れるのが大事なんだと再認識しました。
以下のサイトをみて useState, useEffect といった関数コンポーネントでの state 管理方法を学ぶ必要があることを知りました。

- [React:関数コンポーネントとクラスコンポーネントの違い](https://www.twilio.com/blog/react-choose-functional-components-jp)
- [Reactでクラスコンポーネントより関数コンポーネントを使うべき理由5選](https://tyotto-good.com/blog/reaseons-to-use-function-component)

### React and Redux Toolkit Full Course (free)

<iframe width="560" height="315" src="https://www.youtube.com/embed/WenErzbaF1M" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

これまでの学習で React の基礎の基礎は理解できたという手応えがあったので、モダンなライブラリや設計、環境構築方法なども学んでいこうという段階に入ってきました。
そこで状態管理として Redux を学ぶことにしました。ただ Redux はそこそこの量のテンプレートを書く必要があるらしいのですが Redux Toolkit を使うことで簡潔に書けるようです。
Youtube で Redux Toolkit と検索して、ヒットした動画をみて勉強することにしました。分かりやすく良かったです。

### React 開発 現場の教科書

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4839960496/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">
      <img src="https://images-na.ssl-images-amazon.com/images/I/51yVWFs-ZtL._SL160_.jpg" alt="React開発 現場の教科書" style="border: none;" />
    </a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4839960496/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">React開発 現場の教科書</a>
    </div>
    <div class="amazlet-detail">石橋 啓太  (著), 丸山 弘詩 (編集)<br />マイナビ出版 <br />売り上げランキング: 108,947<br />
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4839960496/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

Atomic Design に関して知りたかったので本書を購入して読みましたが、この本はオススメできません。理由としては下記の通りです。

- 内容が古い、クラスコンポーネントで書かれている
- 環境構築の方法も古い
- Atomic Design にあまりページ数が割かれていない

Atomic Design は別で勉強したほうがいいでしょう。

### React Hooks 入門 - HooksとReduxを組み合わせて最新のフロントエンド状態管理手法を習得

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://www.udemy.com/course/react-hooks-101/" data-iframely-url="//cdn.iframe.ly/sIsgNce?card=small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

React の基礎を学ぶ際にみた Udemy の講師の方が別の動画を出されていたので購入してみました。Hooks についてよく理解できました。

### モダン JavaScript の基本から始める React 実践の教科書

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/481561072X/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">
      <img src="https://images-na.ssl-images-amazon.com/images/I/51721FPL7JL._SL160_.jpg" alt="モダンJavaScriptの基本から始める React実践の教科書" style="border: none;" />
    </a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/481561072X/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">モダンJavaScriptの基本から始める React実践の教科書</a>
    </div>
    <div class="amazlet-detail">じゃけぇ(岡田 拓巳)<br />SBクリエイティブ <br />売り上げランキング: 1,723<br />
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/481561072X/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

すごく分かりやすい内容かつ書き方もモダンでよかったです。これから React を学ぼうという際に最もふさわしい入門書です。
一番最初にこの本に出会っておきたかった……。本書は別でレビューを書いたので詳細はこちらをみてください。

- [「モダンJavaScriptの基本から始める React実践の教科書」を読んだ]({{< relref "2021-11-17-review-modern-react" >}})

### React ハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873119383/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">
      <img src="https://images-na.ssl-images-amazon.com/images/I/512GaA55o9S._SL160_.jpg" alt="Reactハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス" style="border: none;" />
    </a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873119383/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Reactハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス</a>
    </div>
    <div class="amazlet-detail">Alex Banks (著), Eve Porcello (著), 宮崎 空 (翻訳)<br />オライリージャパン <br />売り上げランキング: 34,900<br />
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873119383/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

React の書籍ならコレ！と言われる鉄板の本らしいです。実際読んでみて納得できました。特にサスペンスコンポーネントの説明はありがたかったです。
こちらも詳細レビューを別で書いているのでよろしければご覧ください。

- [「Reactハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス」を読んだ]({{< relref "2021-11-19-review-react-hands-on-learing" >}})

### 仕事ですぐに使える TypeScript

- [仕事ですぐに使える TypeScript](https://future-architect.github.io/typescript-guide/typescript-guide.pdf)

モダンな開発では TypeScript は切り離せないなと思ったので、この段階で TypeScript を勉強することにします。
非常に充実した分量で、また開発現場に即した内容のためすごく学びになりました。

## もし今から初めて勉強するとしたら

僕の学習順序はこれまでに書いた通りですが、中には古い情報の書籍などを参考にしたため遠回りをしてしまった部分もありました。
もし今から React を学ぶ場合、以下の順序で学んでいくのがいいと思います。

まずはこちらで JavaScript の基礎を抑えます。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://jsprimer.net/intro/" data-iframely-url="//cdn.iframe.ly/o76dptv"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

次にこの本を読んで React の基本を学びます。

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/481561072X/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">
      <img src="https://images-na.ssl-images-amazon.com/images/I/51721FPL7JL._SL160_.jpg" alt="モダンJavaScriptの基本から始める React実践の教科書" style="border: none;" />
    </a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/481561072X/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">モダンJavaScriptの基本から始める React実践の教科書</a>
    </div>
    <div class="amazlet-detail">じゃけぇ(岡田 拓巳)<br />SBクリエイティブ <br />売り上げランキング: 1,723<br />
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/481561072X/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

最後にこれを読んで React の少し深いところを学習します。

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873119383/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">
      <img src="https://images-na.ssl-images-amazon.com/images/I/512GaA55o9S._SL160_.jpg" alt="Reactハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス" style="border: none;" />
    </a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873119383/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Reactハンズオンラーニング 第2版 ―Webアプリケーション開発のベストプラクティス</a>
    </div>
    <div class="amazlet-detail">Alex Banks (著), Eve Porcello (著), 宮崎 空 (翻訳)<br />オライリージャパン <br />売り上げランキング: 34,900<br />
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/4873119383/iriyaufo-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

また TypeScript の勉強はこのサイトがあれば問題ないです。

- [仕事ですぐに使える TypeScript](https://future-architect.github.io/typescript-guide/typescript-guide.pdf)

## 今後実装を始めるときに参考にしたいサイト

React の基礎を学び、状態管理の Redux を学び、TypeScript も勉強しました。
ここまでの学習でなんとなくアプリが実装できそうだなという感覚を得たので React を完全に理解したと言ってよいでしょう。
今後はアーキテクチャの考え方や、ライブラリについて調べたりすることになりそうです。

そこでアプリ実装を始めたら役立ちそうなサイトを貼っておきます。

- [React.js Examples](https://reactjsexample.com/)
- [React TypeScript Cheatsheets](https://react-typescript-cheatsheet.netlify.app/)
- [React with TypeScript Cheatsheet](https://blog.bitsrc.io/react-with-typescript-cheatsheet-9dd891dc5bfe)

## やらなかったこと

今回の学習において Next.js は学習しませんでした。またフルスタックフレームワークの blitz.js なども学習していません。

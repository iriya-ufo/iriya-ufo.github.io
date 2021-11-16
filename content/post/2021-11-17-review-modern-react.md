---
layout: post
title: "「モダンJavaScriptの基本から始める React実践の教科書」を読んだ"
slug: review-modern-react
date: 2021-11-17T00:09:00+09:00
lastmod: 2021-11-17T00:09:00+09:00
comments: true
categories:
  - "review"
tags:
  - "react"
---

## 読んだ感想
React の入門書として一冊あげるとすればこの本でしょう、というくらいオススメできる内容でした。
対象読者としては JavaScript に少し不安もありつつ React をこれから学ぶ人といった感じです。
がっつり第三章まで JavaScript の話しなので React だけ学びたい方は少し分量が少なく感じるかもしれません。
ただ基本的な抑えておかないといけないことはちゃんと書かれてる感じでした。
ボリュームはそれほど多くないので、速ければ数時間で読み終えるでしょう。
随所に書かれたコラムも現場感がある内容でいい感じです。

## 本の内容に関して
印象に残っている内容などをさらっと書きます。

### 第一章〜第三章
モダン JavaScript(ES2015) についての説明でした。以下のような内容です。
個人的には環境構築で Vite について言及しているのはポイント高かったです。

- これまでの歴史的な経緯について
- ES2015
- モジュールバンドラー
- トランスパイラ
- Vite
- アロー関数
- 分割代入
- スプレッド構文
- map, filter

### 第四章
ここから React の章になります。

- JSX
- コンポーネント
  - 拡張子は `.jsx` にするとエディタの補完が効くよ、といった Tips も記載
- Props
- State
- Hooks に関して
  - useState
  - useEffect
- export で default のあるなしの違い

### 第五章
CSSに関する章です。ライブラリについての言及もあるのはいいですね。

- CSS Modules
- CSS in JS
  - styled components
  - Emotion
- Tailwind

### 第六章
メモ化についてです。

- memo
  - コンポーネントのメモ化
- useCallback
  - 関数のメモ化
- useMemo
  - 変数のメモ化

### 第七章
頭を悩ませるステート管理についてです。

- Context での方法を少し丁寧に解説
- Redux, Recoil などは紹介程度に記載
- Apollo Client なども紹介

### 第八章
TypeScript の基本に関する章です。構文的な説明もありました。
ライブラリに関して参考になったのでその部分をまとめます。

#### ライブラリの型定義について

- パターン1
  - 型定義がない場合
    - 自分で作る
- パターン2
  - ライブラリが型定義を包含している場合
    - 普通にインストールすれば有効化した状態で使える
    - 型定義を包含しているかどうかは GitHub のページに行って `~.d.ts` ファイルが存在するかどうかで確認できる
- パターン3
  - 型定義を別でインストールする場合
    - DefinitelyTyped リポジトリで様々なライブラリの型定義が管理されている
    - ここにあるリポジトリは `@types/ライブラリ名` でインストールできる
      - 例） `$ npm install -D @types/react-router-dom`
  - ライブラリがこの DefinitelyTyped リポジトリで管理されているかどうかは以下のコマンドで確認できる
    - `$ npm info @types/ライブラリ名`

### 第九章
カスタムフックについての章です。

### 第十章
これまでの総集編として React x TypeScirpt で簡単なメモアプリの実装例があります。

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

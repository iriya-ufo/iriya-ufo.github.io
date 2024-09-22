---
layout: post
title: "shadcn/ui をセットアップする"
slug: shadcn-setup
date: 2024-09-22T23:49:33+09:00
lastmod: 2024-09-22T23:49:33+09:00
comments: true
categories:
  - "programming"
tags:
  - "react"
---

[Vite で React の環境構築]({{< relref "2024-09-08-how-to-setup-react-ts-by-vite-2024" >}})の記事で作成した React に shadcn/ui をセットアップしました。

## 手順

Tailwind が必要なのでインストールします。

```bash
$ pnpm i -D tailwindcss postcss autoprefixer
$ pnpx tailwindcss init -p
```

Tailwind 関連の初期設定を行います。
[公式サイト](https://tailwindcss.com/docs/guides/vite)にあるように `tailwind.config.js` と `./src/index.css` を編集します。

shadcn/ui ではインポートパスの解決のため `tsconfig.json` に以下を追記します。

```json
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"]
    }
  }
```

shadcn/ui の設定ファイルを生成します。

```bash
$ pnpx shadcn@latest init
```

以下項目が聞かれるので適当に選択します。後から `components.json` を変えることで変更可能です。

```
Which style would you like to use? › Default
Which color would you like to use as base color? › Neutral
Do you want to use CSS variables for colors? › no / yes
```

サンプルでボタンを追加などして動作確認してみます。

- https://ui.shadcn.com/docs/components/button


## 参考サイト

- [ReactのUIコンポーネントならshadcn/uiがちょうどいい](https://zenn.dev/mottox2/articles/react-shadcn-ui)

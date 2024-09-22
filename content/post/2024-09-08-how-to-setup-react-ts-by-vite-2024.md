---
layout: post
title: "Vite で React の環境構築"
slug: how-to-setup-react-ts-by-vite-2024
date: 2024-09-08T02:16:39+09:00
lastmod: 2024-09-08T02:16:39+09:00
comments: true
categories:
  - "programming"
tags:
  - "react"
---

## はじめに

[環境構築の記事]({{< relref "2021-12-17-how-to-setup-react-ts-jest-recoil-mui-emotion-by-vite" >}})を全面的に書き直しました。
違いは ESLint と Prettier を使用せず Biome を利用するようにしたことくらいです。

- 使用する技術スタック
  - React
  - TypeScript
  - Vite
  - pnpm
  - Biome


## 目次

- [Node のインストール](#node-のインストール)
  - [pnpm のインストール](#pnpm-のインストール)
- [Vite で React x TypeScript を構築](#vite-で-react-x-typescript-を構築)
- [Biome セットアップ](#biome-セットアップ)
  - [VSCode 設定](#vscode-設定)
  - [ESLint 削除](#eslint-削除)
- [絶対パスでインポート](#絶対パスでインポート)


## Node のインストール

asdf を利用して Node をインストールします。

```bash
$ asdf install nodejs 22.7.0
$ asdf global nodejs 22.7.0
$ node -v
v22.7.0
```

### pnpm のインストール

npm ではなく pnpm を利用します。

```bash
$ npm i -g pnpm
$ pnpm -v
9.9.0
```

## Vite で React x TypeScript を構築

```bash
$ cd $HOME
$ pnpm create vite myapp --template react-ts
$ cd myapp
$ pnpm install
$ pnpm run dev
```

## Biome セットアップ

```bash
$ pnpm add --save-dev --save-exact @biomejs/biome
$ pnpm biome init # biome.json が生成される
```

`biome.json` を編集します。

```json
{
  "$schema": "https://biomejs.dev/schemas/1.8.3/schema.json",
  "organizeImports": {
    "enabled": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true
    }
  },
  "formatter": {
    "enabled": true,
    "indentStyle": "space"
  }
}
```

`packages.json` を編集します。

```json
- "lint": "eslint .",
+ "lint": "biome lint ./ && biome format ./",
+ "fix:lint": "biome lint --write ./ && biome format --write ./",
```

実行は以下のようにします。

```bash
$ pnpm run lint
$ pnpm run fix:lint # ファイルを書き換える
```

### VSCode 設定

VSCode 拡張機能 [Biome](https://marketplace.visualstudio.com/items?itemName=biomejs.biome) をインストールします。

`settins.json` を編集します

```json
...
  "[json]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[javascript][javascriptreact][typescript][typescriptreact]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "biomejs.biome",
    "editor.codeActionsOnSave": {
      "quickfix.biome": "explicit"
    }
  },
...
```

### ESLint 削除

2024年9月現在 Vite でセットアップを行うと初期から eslint プラグインと設定ファイルが存在します。
Biome を使うため削除します。

```bash
$ rm eslint.config.js
$ pnpm uninstall @eslint/js eslint eslint-plugin-react-hooks eslint-plugin-react-refresh typescript-eslint
```


## 絶対パスでインポート

import などを行うときに相対パスではなく絶対パスで行いたいので `vite.config.ts` に以下を設定します。

```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
+import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
+  root: './',
+  resolve: {
+    alias: {
+      '@/': path.join(__dirname, './src/'),
+    },
+  },
})
```

`tsconfig.json` に追記します。

```json
+  "compilerOptions": {
+    "paths": {
+      "@/*": ["./src/*"]
+    }
+  }
```

このとき下記のようなエラーが出る場合は `$ npm i -D @types/node` とすることで解消されます。

- `Cannot find module 'path' or its corresponding type declarations.`
- `Cannot find name '__dirname'.`

![path-error](/images/2022/02/path-error.png)

ちなみに `vite.config.ts` と `tsconfig.json` で同じようなパスの設定を書いてますが、次のような理由があるためです。
Vite では `tsconfig.json` にパスを書いても無視されてしまいます。
Vite に認識してもらうために `vite.config.ts` にパスの設定を書きます。
`tsconfig.json` でパスの設定をしている理由は VSCode などを使っているときにパスが読み込めるようにするためというエディター側に認識させる都合上書いています。
そのため Vite ではなく `create-react-app` で作成したアプリの場合は `tsconfig.json` に path の設定を書くだけで大丈夫です。

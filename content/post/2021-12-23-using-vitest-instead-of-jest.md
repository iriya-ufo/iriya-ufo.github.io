---
layout: post
title: "Jest の代わりに Vitest 使ってみる"
slug: using-vitest-instead-of-jest
date: 2021-12-23T15:24:24+09:00
lastmod: 2021-12-23T15:24:24+09:00
comments: true
categories:
  - "programming"
tags:
  - "react"
---

つい先日、[環境構築の記事]({{< relref "2021-12-17-how-to-setup-react-ts-jest-recoil-mui-emotion-by-vite" >}})を書いたのですが、その後 [Vitest](https://vitest.dev/) が公開されたので Jest を置き換えてみます（今はまだ開発中で安定版ではないので個人的な範囲で使うのがいいかと思います）。

## Jest 関連のアンインストール

[前回の環境構築]({{< relref "2021-12-17-how-to-setup-react-ts-jest-recoil-mui-emotion-by-vite" >}})からの差分なので、入れていない場合は関係ありません。[Vitest](#vitest) のインストールからどうぞ。

jest をアンインストールします。

```bash
$ npm uninstall jest @types/jest eslint-plugin-jest
$ npm uninstall @testing-library/{react,jest-dom,user-event}
$ npm uninstall @babel/preset-{react,typescript,env}
```

設定ファイル系も削除します。

```bash
$ rm jest.setup.ts
$ rm jest.config.js
$ rm babel.config.js
```

`.eslintrc.json` を編集します。

```json
--- a/.eslintrc.json
+++ b/.eslintrc.json
@@ -4,8 +4,7 @@
     "es6": true,
     "node": true,
     "browser": true,
-    "commonjs": true,
-    "jest/globals": true
+    "commonjs": true
   },
   // パーサー
   "parser": "@typescript-eslint/parser",
@@ -24,7 +23,7 @@
       "version": "detect"
     }
   },
-  "plugins": ["react-hooks", "react", "@typescript-eslint", "jest"],
+  "plugins": ["react-hooks", "react", "@typescript-eslint"],
   // 基本的にルールは recommended に従う
   // prettier は配列の最後尾に書く
   "extends": [
@@ -33,7 +32,6 @@
     "plugin:@typescript-eslint/recommended",
     "plugin:react/recommended",
     "plugin:react-hooks/recommended",
-    "plugin:jest/recommended",
     "prettier"
   ],
   "rules": {
```

`package.json` から `test` を削除します。

```json
--- a/package.json
+++ b/package.json
@@ -7,8 +7,7 @@
     "preview": "vite preview",
     "eslint": "eslint . --ext .js,.ts,.jsx,.tsx --fix",
     "prettier": "prettier --write .",
-    "lint": "npm run eslint && npm run prettier",
-    "test": "jest"
+    "lint": "npm run eslint && npm run prettier"
   },
   "dependencies": {
     "@emotion/react": "^11.7.1",
```

emotion の testing utilities をアンインストールします。

```bash
$ npm uninstall @emotion/jest
```

これで綺麗に消えました。

## Vitest

Vitest をインストールします。c8 はカバレッジを計測するためのものです。

```bash
$ npm i -D vitest c8
```

`.gitignore` に以下を追加します。


```
coverage
```

`package.json` を編集します。

```json
--- a/package.json
+++ b/package.json
@@ -7,7 +7,9 @@
     "preview": "vite preview",
     "eslint": "eslint . --ext .js,.ts,.jsx,.tsx --fix",
     "prettier": "prettier --write .",
-    "lint": "npm run eslint && npm run prettier"
+    "lint": "npm run eslint && npm run prettier",
+    "test": "vitest",
+    "coverage": "vitest --coverage"
   },
   "dependencies": {
     "@emotion/react": "^11.7.1",
```

以上となります。

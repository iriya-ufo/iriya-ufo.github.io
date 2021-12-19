---
layout: post
title: "React x TypeScript x MUIv5 x Recoil x Jest x Docker by Vite"
slug: how-to-setup-react-ts-jest-recoil-mui-emotion-by-vite
date: 2021-12-17T16:16:18+09:00
lastmod: 2021-12-20T16:16:18+09:00
comments: true
categories:
  - "programming"
tags:
  - "react"
---

## はじめに

爆速とウワサの Vite を使って React x TypeScript な環境を作成しました。他にも MUIv5, Recoil, Jest, Docker などもあわせて作りました。

## 目次

- [React の環境とセットアップ](#react-の環境とセットアップ)
  - [VSCode 設定](#vscode-設定)
- [テスト環境](#テスト環境)
- [Material UI](#material-ui)
- [その他ライブラリ](#その他ライブラリ)
  - [Recoil](#recoil)
- [Docker](#docker)

## React の環境とセットアップ

まずは node をインストールします。node 自体はバージョン管理したいので nodenv を使ってインストールします。nodenv を使ったインストール方法はこちらを参照してください。

- [Mac に nodenv インストールした]({{< relref 2020-02-11-nodenv-to-mac >}})

```bash
# バージョンの確認
$ node -v
v16.13.0
$ npm -v
8.1.0
```

React 環境を [vite](https://vitejs.dev) を使って構築します。

```bash
$ npm init vite myapp -- --template react-ts
$ cd myapp
$ npm install
$ npm run dev
```

docker やリモートサーバーの場合は `vite.config.ts` を編集します。

```
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
+  server: {
+    host: '0.0.0.0',
+  },
})
```

開発環境をよりよくするために eslint, prettier などを設定します。
なお [eslint-plugin-prettier](https://github.com/prettier/eslint-plugin-prettier) は非推奨なので使用しません。

```bash
# ESLint と Prettier
$ npm i -D eslint prettier eslint-config-prettier

# TypeScript ESLint Plugin
$ npm i -D @typescript-eslint/{parser,eslint-plugin}

# React ESLint Plugin
$ npm i -D eslint-plugin-{react,react-hooks}
```

`tsconfig.json` を編集します。

```json
{
  "compilerOptions": {
    "target": "es2021",
    "useDefineForClassFields": true,
    "lib": ["es2021", "dom", "dom.iterable"],
    "sourceMap": true,
    "allowJs": false,
    "skipLibCheck": false,
    "esModuleInterop": false,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx"
  },
  "include": ["./src"],
  "exclude": ["node_modules"]
}
```

`.eslintrc.json` を作成します。

```json
{
  // 適用する環境
  "env": {
    "es6": true,
    "node": true,
    "browser": true,
    "commonjs": true
  },
  // パーサー
  "parser": "@typescript-eslint/parser",
  // jsx を使います
  "parserOptions": {
    "ecmaVersion": 2018,
    "ecmaFeatures": {
      "jsx": true
    },
    // import 文でモジュールを使用します
    "sourceType": "module"
  },
  // React のバージョンは自動検出に
  "settings": {
    "react": {
      "version": "detect"
    }
  },
  "plugins": ["react-hooks", "react", "@typescript-eslint"],
  // 基本的にルールは recommended に従う
  // prettier は配列の最後尾に書く
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/eslint-recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "prettier"
  ],
  "rules": {
    // import React from 'react' を書かなくてもいいようにする
    "react/react-in-jsx-scope": "off",
    // TypeScirpt なので prop-types は要らない
    "react/prop-types": "off"
  }
}
```

`.eslintignore` を作成します。

```json
node_modules
.DS_Store
dist
dist-ssr
*.local
node_modules/*
```

`.prettierrc.json` を作成します。

```json
{
  "singleQuote": true,
  "bracketSameLine": true,
  "bracketSpacing": true
}
```

`.prettierignore` を作成します。

```json
node_modules
.DS_Store
dist
dist-ssr
*.local
node_modules/*
```

### VSCode 設定

拡張機能をインストールします。

- [eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

`settings.json` を編集します。複数言語で共通の設定を書く方法がない？みたいなので、冗長な書き方になっています。
やり方ご存知でしたら教えて頂けると嬉しいです。また `javascriptreact` と `typescriptreact` はそれぞれ `jsx` と `tsx` のことです。なんでこんな書き方なんだろうか……

```json
"[json]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode"
},
"[javascript]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": true
    },
},
"[javascriptreact]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": true
    },
},
"[typescript]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": true
    },
},
"[typescriptreact]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": true
    },
},
...
```

`package.json` を編集して lint の実行を簡単にします。実行方法は下記の通りです。

- 個別に実行
    - `$ npm run eslint`
    - `$ npm run prettier`
- 両方実行
    - `$ npm run lint`

```json
"scripts": {
     "dev": "vite",
     "build": "tsc && vite build",
-    "preview": "vite preview"
+    "preview": "vite preview",
+    "eslint": "eslint . --ext .js,.ts,.jsx,.tsx --fix",
+    "prettier": "prettier --write .",
+    "lint": "npm run eslint && npm run prettier"
   },
```

## テスト環境

Jest を使ったテスト環境を作っていきます。まずは必要なパッケージをインストールします。

```bash
$ npm i -D jest @types/jest eslint-plugin-jest
$ npm i -D @testing-library/{react,jest-dom,user-event}
$ npm i -D @babel/preset-{react,typescript,env}
```

なお `eslint-plugin-jest` は `eslint` がインストール&設定済みであることを前提とします。

`jest.setup.ts` を作成します。

```tsx
import '@testing-library/jest-dom';
```

`jest.config.js` を作成します。

```jsx
module.exports = {
  roots: ['<rootDir>/src'],
  testMatch: [
    '**/__tests__/**/*.+(ts|tsx|js)',
    '**/?(*.)+(spec|test).+(ts|tsx|js)',
  ],
  transform: {
    '^.+\\.(ts|tsx)$': '<rootDir>/node_modules/babel-jest',
  },
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
};
```

`babel.config.js` を作成します。

```jsx
module.exports = {
  presets: [
    [
      '@babel/preset-env',
      {
        targets: {
          node: 'current',
        },
      },
    ],
    '@babel/preset-react',
    '@babel/preset-typescript',
  ],
};
```

`.eslintrc.json` を編集します。

```json
--- a/.eslintrc.json
+++ b/.eslintrc.json
@@ -4,7 +4,8 @@
     "es6": true,
     "node": true,
     "browser": true,
-    "commonjs": true
+    "commonjs": true,
+    "jest/globals": true
   },
   // パーサー
   "parser": "@typescript-eslint/parser",
@@ -23,7 +24,7 @@
       "version": "detect"
     }
   },
-  "plugins": ["react-hooks", "react", "@typescript-eslint"],
+  "plugins": ["react-hooks", "react", "@typescript-eslint", "jest"],
   // 基本的にルールは recommended に従う
   // prettier は配列の最後尾に書く
   "extends": [
@@ -32,6 +33,7 @@
     "plugin:@typescript-eslint/recommended",
     "plugin:react/recommended",
     "plugin:react-hooks/recommended",
+    "plugin:jest/recommended",
     "prettier"
   ],
   "rules": {
```

`package.json` を編集します。

```json
--- a/package.json
+++ b/package.json
@@ -7,7 +7,8 @@
     "preview": "vite preview",
     "eslint": "eslint . --ext .js,.ts,.jsx,.tsx --fix",
     "prettier": "prettier --write .",
-    "lint": "npm run eslint && npm run prettier"
+    "lint": "npm run eslint && npm run prettier",
+    "test": "jest"
   },
   "dependencies": {
     "react": "^17.0.2",
```

`src/App.test.tsx` を作成します。

```tsx
test('that jest is working', () => {
  expect(true).toBe(true);
});
```

テストを実行してみます。

```bash
$ npm run test

> myapp@0.0.0 test
> jest

 PASS  src/App.test.tsx
  ✓ that jest is working (2 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
Time:        1.126 s
Ran all test suites.
```

## Material UI

UI ライブラリとして [Material UI](https://mui.com) を使用します。必要なパッケージをインストールします。

```bash
$ npm i @mui/material @emotion/react @emotion/styled
$ npm i @fontsource/roboto # お好みで
$ npm i @mui/icons-material
```

emotion の testing utilities をインストールします。jest の環境構築が済んでいることが前提です。

```bash
$ npm i -D @emotion/jest
```

`jest.config.js` を編集します。

```jsx
--- a/jest.config.js
+++ b/jest.config.js
@@ -9,4 +9,5 @@ module.exports = {
   },
   testEnvironment: 'jsdom',
   setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
+  snapshotSerializers: ['@emotion/jest/serializer'],
 };
```

## その他ライブラリ

その他、使い勝手のよいライブラリをいくつかインストールします。詳しい使い方は他サイト参照してください。

```bash
$ npm i axios           # https://github.com/axios/axios
$ npm i react-hook-form # https://react-hook-form.com/jp/
$ npm i react-location  # https://react-location.tanstack.com
```

### Recoil

```bash
$ npm i recoil # https://recoiljs.org
```

`eslintrc.json` を編集します。

```json
--- a/.eslintrc.json
+++ b/.eslintrc.json
@@ -40,6 +40,14 @@
     // import React from 'react' を書かなくてもいいようにする
     "react/react-in-jsx-scope": "off",
     // TypeScirpt なので prop-types は要らない
-    "react/prop-types": "off"
+    "react/prop-types": "off",
+    // react-hooks with recoil
+    "react-hooks/rules-of-hooks": "error",
+    "react-hooks/exhaustive-deps": [
+      "warn",
+      {
+        "additionalHooks": "(useRecoilCallback|useRecoilTransaction_UNSTABLE)"
+      }
+    ]
   }
 }
```

## Docker

Docker 環境の構築ですが、サービス要件によっては使わないほうがいい場合もあると思っています。
例えば、単純な SPA な Web アプリケーションでフロントとバックエンドが切り離されているような場合、フロント側は DB コンテナもキャッシュコンテナも必要なく、そこまで複雑な構成になりません。
また node のバージョン違いによる問題も起きにくく、かつパッケージ管理も npm があれば問題ありません。
ローカル開発環境も冒頭に紹介した nodenv で node をインストールすれば済みますし、無理に Dockernize しても基本的に I/O ヘビーなフロント開発においてはかえって開発体験が悪くなってしまいます（特に Dokcer for Mac などでは顕著）。
本番環境は CDN などにビルド済みファイルを配置するパターンで済む場合もあります。

一方で Dockernize した方がいい場合というのは、例えばミドルウェアとしてインストールがやっかいな ImageMagick を使う必要があるとか、本番環境に AWS の Fargate や App Runner といったコンテナ環境を動かすことで運用していく前提がある場合などです。

本記事では開発環境は Docker を使わず、本番環境でコンテナを動かすという前提で Dockernize します。Dockernize においてはマルチステージビルドを使います。フェーズ1でビルドを実行し、フェーズ2でビルド済みファイルを Nginx で配信するコンテナを作るようにします。

Dockernize においては、以下の話しから distroless を検討しましたが公式で Nginx のランタイムはなかったので保守運用を考えて alpine を使うことにします。

- [軽量Dockerイメージに安易にAlpineを使うのはやめたほうがいいという話 - inductor's blog](https://blog.inductor.me/entry/alpine-not-recommended)

それでは Dockernize について書いていきます。なお [Dockerizing a React App](https://mherman.org/blog/dockerizing-a-react-app/#production) を参考にしています。

まず `.dockerignore` を作成します。

```
node_modules
.git
```

`Dockerfile` を作成します。

```docker
#
# STAGE 1
#
# Uses a Node LTS image to build
#
FROM node:16-bullseye AS build

WORKDIR /opt/app

COPY package.json package-lock.json ./
RUN npm i -g npm@latest && npm ci --no-optional
COPY tsconfig.json index.html vite.config.ts ./
COPY src ./src
RUN npm run build

#
# STAGE 2
#
# Create final image
#
FROM nginx:stable-alpine

COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /opt/app/dist /public

EXPOSE 80
```

`docker/nginx/nginx.conf` を作成します。

```
worker_processes 2;

events {
    worker_connections 1024;
    multi_accept on;
    use epoll;
}

http {
    include /etc/nginx/mime.types;

    server {
        listen 80;
        server_name 127.0.0.1;
        access_log /dev/stdout;
        error_log stderr;

        location / {
            root /public;
            index index.html;
            try_files $uri $uri/ /index.html =404;
            gzip on;
            gzip_types text/css application/javascript application/json image/svg+xml;
            gzip_comp_level 9;
        }
    }
}
```

`docker-compose.yml` を作成します。

```yaml
version: '3'

services:
  app:
    build: .
    ports:
      - 8080:80
```

`$ docker compose build` でビルドします。

`$ docker compose up` でコンテナを起動します。

[localhost:8080](http://localhost:8080) にアクセスして確認します。

以上で Dockernize 完了です。

## 参考サイト

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://zenn.dev/sprout2000/articles/9f20902d394aa2" data-iframely-url="//cdn.iframe.ly/Y3L3H2N?card=small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>
<br>
<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://egghead.io/lessons/jest-adding-jest-with-typescript-support-to-a-vite-application" data-iframely-url="//cdn.iframe.ly/JnPzQR1?card=small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>
<br>
<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://zenn.dev/h_yoshikawa0724/articles/2021-09-26-material-ui-v5" data-iframely-url="//cdn.iframe.ly/zYL6zRr?card=small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>
<br>
<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://zenn.dev/sprout2000/articles/3aa67a5981f4c0" data-iframely-url="//cdn.iframe.ly/pTmja7K?card=small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

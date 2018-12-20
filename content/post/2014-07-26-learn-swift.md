---
layout: post
title: Swift をインタラクティブに実行しながら勉強しよう (関数編)
date: 2014-07-26T15:55:36+00:00
comments: true
categories: programming
tags: swift
---

> Swift はコンパイラ言語でありながら、インタプリタとしてスクリプトを実行することも可能で、対話実行環境（REPL（英語版））も用意されている。Swift と同時に発表された Xcode バージョン 6 では、コードの実行結果をグラフィカルに確認しながら開発できる Playgrounds が実装された。

> Wikipedia より引用

説明の通り Swift はインタラクティブに実行することが可能となっています。Playgrounds を使ってもいいのですが、もっとお手軽なシェルから実行して遊んでみましょう。

## 環境構築
まず以下を参考にしてコマンドラインから実行できる環境を整えましょう。

[Swift をとりあえず実行するまでの手順]({% post_url 2014-07-23-quick-start-swift %})

## Hellow, World
それではさっそく Hellow, World しましょう。適当な場所に拡張子 `.swift` でファイルを作り以下の一行を書きます。

```swift
println(“Hello World”)
```

実行してみましょう。`-i` オプションをつけるとバイナリファイルを生成せずに直接実行されます。

    $ swift -i sample.swift
    Hello, world

できました！なんと簡単なことか！

## 関数を試す
このまま続けましょう。いきなりですが関数を書きます。

```swift
func doNothing() {
}
doNothing()
```

実行しても何もおきませんね。なので少し変えます。

```swift
func doNothing() {
}
var nothing = doNothing()
```

むむむ **warning** が出ました。

```
sample.swift:3:5: warning: variable 'nothing' inferred to have type '()', which may be unexpected
var nothing = doNothing()
    ^
sample.swift:3:5: note: add an explicit type annotation to silence this warning
var nothing = doNothing()
    ^
           : ()
```

関数の返り値を `nothing` 変数に代入しようとしたのですがダメみたいです。warning によると関数は空のタプル `'()'` を返してるようですね。これを明示的に宣言する必要があるみたいです。このようにします。

```swift
func doNothing() {
}
var foo: () = doNothing()
```

これで warning が消えました。swift では `var` で変数宣言をして `foo` を変数名として `:` コロンの後に型を書くというやり方をします。また以下も動作します。

```swift
func doNothing() {
}
var foo: Void = doNothing()
```

それでは試しに文字列を返す関数を書いてみます。

```swift
func retString() {
    return "Hi"
}
var foo: String = retString()
```

あれ、今度はエラーが出ました。

```
sample.swift:4:19: error: '()' is not convertible to 'String'
var foo: String = retString()
                  ^
sample.swift:2:12: error: type '()' does not conform to protocol 'StringLiteralConvertible'
    return "Hi"
           ^
```
なるほど `retString` 関数は文字列を返して欲しかったのに依然としてタプルを返していますね、そしてそれを文字列に変換できないという旨のエラーです。関数の返り値に Void 以外を返す場合、型を宣言する必要があるようですね。こうしましょう。

```swift
func retString() -> String {
    return "Hi"
}
var foo: String = retString()
```

やりました！エラーが消えました。ついでに引数も渡してみましょうかね。

```swift
func retString(str) -> String {
    return "Hi " + str
}
var foo: String = retString("How's it going?")
```

またエラー発生です。

```
sample.swift:1:16: error: use of undeclared type 'str'
func retString(str) -> String {
               ^~~
```

ほうほう、ここも型宣言が必要なのですか。こうすれば通るかな？

```swift
func retString(str: String) -> String {
    return "Hi " + str
}
var foo: String = retString("How's it going?")
println(foo)
```

やりました！関数を書くには、返り値および引数の型宣言が大切なようですね。

以上 Swift の関数でした。

### 参考
<a href="https://medium.com/swift-programming/1-learn-swift-by-running-scripts-73fdf8507f4b" target="_blank">1. Learn Swift by running Scripts</a>

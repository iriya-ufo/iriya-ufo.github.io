---
title: "機械学習とかの関連まとめ"
date: 2018-12-20T12:38:52+08:00
lastmod: 2018-12-20T12:41:52+08:00
---

# 機械学習とかの関連まとめ

機械学習の基礎も分からない状態から、スクラッチで勉強を始めて深層学習をマスターするまでの記録。

始めた段階のスキルセットは以下。

- ネットワークと UNIX サーバー周りの知識が趣味レベルである
- Rails エンジニア歴二年くらい
- 低レイヤー言語や Python 経験は無し
- 高校レベル数学は分かるが大学レベルは無理

やりたいことおよびゴールは以下。

- 機械学習関連における理論の理解とアルゴリズムの実装
- 面白くて有用なプロダクトを一つ作る (音声認識と自然言語処理あたりを考え中)


## 人工知能への入り口

人工知能という言葉は人によって定義があいまいな場合があります。
何がすごくてどういったことができるようになるのか、俯瞰した知識をいれるために以下の本をオススメします。
数式などもなくて一般の人にも読みやすい本です。

- [人工知能は人間を超えるか](https://www.amazon.co.jp/%E4%BA%BA%E5%B7%A5%E7%9F%A5%E8%83%BD%E3%81%AF%E4%BA%BA%E9%96%93%E3%82%92%E8%B6%85%E3%81%88%E3%82%8B%E3%81%8B-%E8%A7%92%E5%B7%9D%EF%BC%A5%EF%BC%B0%EF%BC%B5%EF%BC%A2%E9%81%B8%E6%9B%B8-%E6%9D%BE%E5%B0%BE-%E8%B1%8A-ebook/dp/B00UAAK07S?ie=UTF8&btkr=1&ref_=dp-kindle-redirect)
- [よくわかる人工知能　最先端の人だけが知っているディープラーニングのひみつ](http://www.amazon.co.jp/exec/obidos/ASIN/B01M3OH87R/iriyaufo-22/ref=nosim/)
- [コンピューターで脳がつくれるか](https://www.amazon.co.jp/dp/B01M07JC4Y/iriya-ufo22/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)

## ハードウェア構築
機械学習をさせるための計算資源は、普通のノートPCではまだまだ不十分です。そこで演算専用マシンを作ります。
コスパ的には20万円くらいかければちょうどいいと思います。それより必要ならスペックアップするか企業に借りるかクラウドを使うといいでしょう。

- [Hardware Architecture for Machine Learning]({{< relref "2016-11-09-hardware-architecture-for-machine-learning" >}})

## 開発環境構築
- [Deep Learning Machine に Ubuntu のインストール]({{< relref "2016-11-10-install-ubuntu-to-deep-learning-machine" >}})
- [TensorFlow を GPU で動かす]({{< relref "2016-11-19-tensorflow-running-by-gpu" >}})
- [Docker コンテナに anaconda 環境を構築]({{< relref "2016-11-18-pyenv-and-anaconda-on-docker" >}})
- [Docker 版 Jupyter Notebooks でホストとデータを共有する]({{< relref "2016-12-04-data-sharing-with-host-on-jupyter-notebooks" >}})

## Python 入門
機械学習では Python を使うことが多いので、初めて触る場合はざっと調べておくといいです。

- [Python チュートリアル](http://docs.python.jp/3/tutorial/index.html) --- 他言語にて開発経験のある方向け

## 機械学習基礎
- [機械学習と数学]({{< relref "2016-11-19-ml-and-math" >}})

## 人工知能関連リンク集
個人的に役に立った記事のリンクをまとめておきます。

### ツール
- [Neural Network Playground](http://playground.tensorflow.org/?utm_medium=email&utm_campaign=2017-01-19_dlnd_jan27notice&utm_source=blueshift&utm_content=2017-01-19_dlnd_jan27notice&bsft_eid=1baa362f-396f-472d-b3f6-ff1eba51866f&bsft_clkid=97244f60-6a5c-4cd7-b813-01ab7a1c3e8c&bsft_uid=1ee6c9a9-f40a-4d8e-93b4-fa8d149d91bd&bsft_mid=013e8172-2a69-480b-881a-7cac7bb4fb8d#activation=tanh&batchSize=10&dataset=circle&regDataset=reg-plane&learningRate=0.03&regularizationRate=0&noise=0&networkShape=4,2&seed=0.89574&showTestData=false&discretize=false&percTrainData=50&x=true&y=true&xTimesY=false&xSquared=false&ySquared=false&cosX=false&sinX=false&cosY=false&sinY=false&collectStats=false&problem=classification&initZero=false&hideText=false)
- [IBM Data Scientist Workbench](https://my.datascientistworkbench.com/)

### オープンデータ
- [Dataset for machine learning](https://docs.google.com/spreadsheets/d/1AQvZ7-Kg0lSZtG1wlgbIsrm90HaTZrJGQMz-uKRRlFw/edit#gid=0)

### 数学関連
- [Paul's Online Math Notes](http://tutorial.math.lamar.edu/cheat_table.aspx)

### チートシート
- [Python for Data Science Cheat Sheet Pandas Basic](https://tensorflowkorea.files.wordpress.com/2017/01/pandaspythonfordatascience.png)
- [Deep Learning Glossary](https://quizlet.com/158702343/deep-learning-glossary-flash-cards/)

### 機械学習編
- [Coursera Machine Learning](https://www.coursera.org/learn/machine-learning)
- [実践Pytonデータサイエンス](https://www.udemy.com/python-jp/)
- [実践Pytonデータサイエンス資料](http://www.tsjshg.info/udemy/notebooks.html)

### Deep Learning 概念編
- [Machine Learning is Fun!](https://medium.com/@ageitgey/machine-learning-is-fun-80ea3ec3c471?bsft_eid=1baa362f-396f-472d-b3f6-ff1eba51866f&bsft_clkid=1dba58e0-ba08-44d9-a990-140eabca0f08&bsft_uid=1ee6c9a9-f40a-4d8e-93b4-fa8d149d91bd&bsft_mid=013e8172-2a69-480b-881a-7cac7bb4fb8d#.1je1dhv23)
- [【Qiita】ゼロからDeepまで学ぶ強化学習](http://qiita.com/icoxfog417/items/242439ecd1a477ece312)
- [【Qiita】はじめるDeep learning](http://qiita.com/icoxfog417/items/65e800c3a2094457c3a0)
- [畳み込みニューラルネットワークの仕組み](http://postd.cc/how-do-convolutional-neural-networks-work/)

### Deep Learning チュートリアル
- [Deep Learning](http://www.deeplearningbook.org/)
- [Deep Learning Tutorials](http://deeplearning.net/tutorial/)
- [【Udacity】Introducing Siraj Raval’s Deep Learning Nanodegree Foundation Program!](http://blog.udacity.com/2017/01/siraj-raval-deep-learning-nanodegree-foundation-program.html)
- [Googleの開発者が作った3時間でディープラーニング(深層学習)をスライドとムービーで学べる集中レッスン](http://gigazine.net/news/20170127-learning-tensorflow-3hours/)
- [Deep Learning基礎講座演習コンテンツ 公開ページ](http://weblab.t.u-tokyo.ac.jp/deep-learning%E5%9F%BA%E7%A4%8E%E8%AC%9B%E5%BA%A7%E6%BC%94%E7%BF%92%E3%82%B3%E3%83%B3%E3%83%86%E3%83%B3%E3%83%84-%E5%85%AC%E9%96%8B%E3%83%9A%E3%83%BC%E3%82%B8/)

### Deep Learning ライブラリ編
- [【Qiita】Chainerで始めるニューラルネットワーク](http://qiita.com/icoxfog417/items/96ecaff323434c8d677b)
- [【Qiita】TensorFlowのチュートリアルを通して、人工知能の原理について学習する](http://qiita.com/jintaka1989/items/3b70b5c5541620536fa2)
- [【Qiita】Theano の 基本メモ](http://qiita.com/mokemokechicken/items/3fbf6af714c1f66f99e9)

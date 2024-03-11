---
layout: post
title: "hardware architecture for machine learning"
slug: hardware-architecture-for-machine-learning
date: 2016-11-09 14:58:31 +0900
comments: true
categories:
  - "programming"
tags:
  - "machine learning"
---

機械学習をさせるための専用演算マシンを構築しました。
クラウドでいいじゃんとも思いますが、自分の手元に自由に使える演算サーバーがあるのはそれはそれで便利だと思います。
テンションあがりますしね。

ということでハードウェアのスペック選定をしなければいけません。
これに関しては、下記ブログが大変参考になります。

[『低火力ディープラーニングのための環境 (自作ハード編)』](http://studylog.hateblo.jp/entry/2016/01/28/011100)

重要ポイントは、メモリーは詰めるだけ詰んだ方がいい、グラフィックボードに金を突っ込む、電源は壊れにくいものを、といった感じです。
それを踏まえて、さくっと作ったマシン構成が以下になります (マシンを組んでくれた友人よ、ありがとう)。

| パーツ | 型番 | 価格 |
|:-----------:|:------------|------------:|
| CPU | [i5-6500 LGA1151](http://ark.intel.com/ja/products/88184/Intel-Core-i5-6500-Processor-6M-Cache-up-to-3_60-GHz) | ¥20,480 |
| マザーボード | [ASRock Z170 Extreme4](http://www.asrock.com/mb/intel/z170%20extreme4/) | ¥11,800 |
| MEM | [DDR4 PC4-17000 16GB 2枚組 CT2K16G4DFD8213](http://www.crucial.com/usa/en/ct2k16g4dfd8213) | ¥17,980 |
| SSD | [ADATA SP900 256GB](http://www.adata.com/jp/ssd/feature/171) | ¥8,480 |
| HDD | [東芝 DT01ACA300 3TB SATA600 7200](http://toshiba.semicon-storage.com/jp/product/storage-products/client-hdd/dt01acaxxx.html) | ¥6,780 |
| GPU | [玄人志向 GF-GTX1080-E8GB/BLF](http://www.kuroutoshikou.com/product/graphics_bord/nvidia/gf-gtx1080-e8gb_blf/release/) | ¥64,800 |
| 電源 | [Fractal Ion+ 2 Platinum 660W](https://www.fractal-design.com/ja/products/power-supplies/ion/ion-2-platinum-660w/black/) | ¥19,790 |
| ケース | [CMS-693-KKN1-JP](http://apac.coolermaster.com/jp/case/mid-tower-cm690-series/cm693/) | ¥8,980 |
| 合計 | | (税込) ¥173,072 |

※ 以前の電源(ENERMAX PLATIMAX 850W)が壊れたので2024年3月に買い替えました。

次回はこのマシンに[『Ubuntu のインストール』]({{< relref "2016-11-10-install-ubuntu-to-deep-learning-machine" >}})を行います。

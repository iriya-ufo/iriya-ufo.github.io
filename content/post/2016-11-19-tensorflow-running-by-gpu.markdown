---
layout: post
title: "TensorFlow を GPU で動かす"
slug: tensorflow-running-by-gpu
date: 2016-11-19 23:37:43 +0900
comments: true
categories: machine_learning
---

[前回]({% post_url 2016-11-10-install-ubuntu-to-deep-learning-machine %})は最低限 Ubuntu が起動するまでの設定だったので、これから GPU で TensorFlow を実行するまでの環境を作っていきます。
移植性の高い方法で構築したいので Docker を使います。

## 前提
- GPU (今回は GEFORCE GTX 1080) を積んだマシンがある
- Ubuntu 16.04 LTS がインストールされている
- Docker がインストールされている

## 構築環境
- [CUDA](https://ja.wikipedia.org/wiki/CUDA) --- Nvidia が提供する GPU 向けの統合開発環境
- [cuDNN](https://developer.nvidia.com/cudnn) --- Nvidia が作ったディープラーニング用のライブラリ(SDK)で GPU をフル活用できるようになっている
- [NVIDIA Docker](https://github.com/NVIDIA/nvidia-docker) --- Nvidia が提供している、コンテナから GPU を操作できるようにするもの
- [TensorFlow](https://www.tensorflow.org/) --- Google が開発したオープンソースの機械学習ライブラリ

## 構築手順

### CUDA インストール
```
$ sudo apt-get install nvidia-cuda-toolkit
```

### cuDNN インストール
https://developer.nvidia.com/cudnn からユーザー登録をしてライブラリをダウンロードする。

```
$ tar xfzv cudnn-8.0-linux-x64-v5.1.tgz
$ cd cuda
$ sudo cp lib64/* /usr/lib/x86_64-linux-gnu
$ sudo cp include/cudnn.h /usr/include
$ sudo chmod a+r /usr/lib/x86_64-linux-gnu/libcudnn*
```

### NVIDIA Docker インストール
```
# Install nvidia-docker and nvidia-docker-plugin
$ wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.0-rc.3/nvidia-docker_1.0.0.rc.3-1_amd64.deb
$ sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

# Test nvidia-smi
$ nvidia-docker run --rm nvidia/cuda nvidia-smi
```

認識できているようだ。

![nvidia-docker](https://i.gyazo.com/91166d8447efd8d74b646c7fd33d3844.png)

### Tensorflow インストール
Google 公式の Tensorflow に Docker イメージと実行方法が書いてある。イメージはもちろん GPU バージョンのものを使う。

- [Download and Setup](https://www.tensorflow.org/versions/master/get_started/os_setup.html#docker-installation)

```
$ nvidia-docker run -it -p 8888:8888 gcr.io/tensorflow/tensorflow:latest-gpu
```

Jupyter Notebook が起動するので `http://ホストIPアドレス:8888/` にアクセスしてみる。

![jupyter_tensorflow](https://i.gyazo.com/dd4f9bcc4d7af38aba37d45439ea30b5.png)

### MNIST サンプルコードを動かしてみる
MNIST サンプルコードを動かして計算させてみる。コードはこちらを利用させてもらった。

- https://github.com/fchollet/keras/blob/master/examples/mnist_cnn.py

まず Jupyter Notebook を起動後、ターミナルを開いて `$ pip install keras` と打つ。

上記サンプルコードを Notebook で実行。

![mnist_cnn](https://i.gyazo.com/36869691dcff0e0264b34b51cdb8a1e2.png)

めっちゃ速い。

Docker 再起動で keras とか書いたコードとか消えちゃうので、イメージ作成とボリュームセットの構築が必要かな。
今回は提供されている Docker を利用しただけなので、次回は自前で Dockerfile 作成とイメージ作成をやっていきたいと思います。

次回は[『Docker コンテナに Anaconda 環境を構築』]({% post_url 2016-11-18-pyenv-and-anaconda-on-docker %})します。

[『Deep Learning from scratch』]({{ root_url }}/products)

---
layout: post
title: middleman-s3_sync で colorize のエラーがでた
slug: middleman-s3_sync-colorize-error
date: 2014-12-27T21:55:29+00:00
comments: true
categories:
  - "programming"
tags:
  - "middleman"
---

静的サイト開発に便利な middleman を使って Amazon S3 バケットにデプロイする際、middleman-s3_sync という gem を使っていましたが、エラーがでました。

    /Users/iriya/project/rabbitcare/rabbitcare-site/vendor/bundle/ruby/2.1.0/gems/padrino-support-0.12.4/lib/padrino-support/core_ext/string/colorize.rb:22:in `colorize': undefined method `light_green' for String::Colorizer:Class (NoMethodError)

<a href="https://github.com/capistrano/sshkit/issues/151" title="issues" target="_blank">ここ</a>を見るとどうやら <strong>colorize</strong> という gem でもう使われていないメソッドを呼び出しているようでした。

0.7.4 のバージョンならOKということなので、Gemfile に以下を追記して `$ bundle update` で直りました。

```sh
# Avoid deployment error
gem "colorize", "0.7.4"
```

    $ bundle update colorize

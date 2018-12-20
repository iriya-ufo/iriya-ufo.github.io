---
layout: post
title: Rails 製アプリの Shapado をインストールしようとしたらとんでもないことになった
date: 2014-03-12T02:12:34+00:00
comments: true
categories: programming
tags:
  - gem
  - homebrew
  - mongodb
  - newrelic
  - ruby
  - rails
---

プログラミング上達のコツはソースを読むことだ、とよく言われます。最近 Ruby on Rails の勉強を始めたので学習のためにオープンソースな Rails アプリを読んでみようと思いました。Shapado というQ&amp;Aアプリが面白そうだったので Mac にインストールして動かしてみました。これが時間を食いつぶすきっかけになるとは思ってもいなかった・・・

<font color="red"><em>最初に結論だけ書きますと起動しませんでした。なのでエラーメッセージとかでググってこのサイトに来て頂いた方には申し訳ないですが解決策はありません。Ruby 1.9 と古い gem を使えば動くかもしれませんが、勉強のためにインストールするアプリでわざわざ古いものを使いたくないので諦めました。</em></font>

それを念頭にいれた上で私の行った作業の備忘録を以下に記します。

## mongodb のインストール
Shapado は mongodb を使用していますのでその環境を整えましょう。brew を使って管理します。

    $ brew update
    $ brew install mongodb

以下のメッセージが出ます、余計なプロセスは立ち上げたくないので自動起動の設定はしません！

    To have launchd start mongodb at login:
        ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents
    Then to load mongodb now:
        launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
    Or, if you don't want/need launchctl, you can just run:
        mongod --config /usr/local/etc/mongod.conf

とりあえず言われた通りに起動します。

    $ mongod --config /usr/local/etc/mongod.conf

起動させた状態で接続を確認します。

    $ mongo
    MongoDB shell version: 2.4.9
    connecting to: test
    Welcome to the MongoDB shell.
    For interactive help, type "help".
    For more comprehensive documentation, see
            http://docs.mongodb.org/
    Questions? Try the support group
            http://groups.google.com/group/mongodb-user
    > 

大丈夫ですね。

`help` とか打てば使い方が表示されます。MySQL などと違って簡単ですね :)
データは `/usr/local/var/mongodb` 配下に入ります。変更したいときは config ファイルを編集してください。

## Shapado を始める
### bundler をいれる
git とか当たり前のように使ってるでしょう？ ruby は rbenv とか使ってますか？ YES ですね。はい OK 次に進みます。

    $ gem install bundler

### ダウンロード
[Shapado](https://github.com/ricodigo/shapado ) を Fork して git clone で手元に持ってきます。ま、別に Fork しなくてもいいですが。

    $ git clone git@github.com:yourname/shapado.git
    $ cd shpado/

### アプリケーションの設定
設定ファイルをコピーして編集します。とりあえずローカルで動かしたいので設定ファイルの編集はすっとばす。

    $ cp config/shapado.yml.sample config/shapado.yml
    $ cp config/mongoid.yml.sample config/mongoid.yml
    $ cp config/auth_providers.yml.sample config/auth_providers.yml

パフォーマンス監視してます(ドヤァ。とかいうとかっこいいので NewRelic いれましょう。
ここでアカウント作ります。

https://rpm.newrelic.com/

アカウント作ったら License Key を取得して `newrelic.yml` に設定します。

    $ cp config/newrelic.yml.sample config/newrelic.yml
    $ vim config/newrelic.yml # License Key をペースト
    $ vim .gitignore # config/newrelic.yml を追加

### 依存関係をインストール

    $ bundle install

以下のエラーがでます。めちゃ古い Twitter の gem なので怒られました。

    Could not find twitter-1.7.2 in any of the sources

Gemfile から twitter 関連を外して再度 `$ bundle install` を。

以下のエラーがでます。ZenTest を利用するには gem が 1.8 でないといけないそうですが、私は 2.1 を使っています。古い gem なんて使いたくないので ZenTest はいれない方向にしました。Gemfile から autotest を外して再度 `$ bundle install` を。

    Gem::InstallError: ZenTest requires RubyGems version ~> 1.8. Try 'gem update --system' to update RubyGems itself.

以下のエラーがでます。Qt をビルドするための qmake が無いせいです。Qt とか大嫌いなんで、Gemfile から capybara-webkit を外します。

    An error occurred while installing capybara-webkit (0.11.0), and Bundler cannot continue.

以下のエラーがでます。Gemfile から ruby-prof を外します。ruby-prof はプロファイリングによりプログラムの高速化を計るものですが今はいりません。

    An error occurred while installing ruby-prof (0.10.8), and Bundler cannot continue.

以下のエラーがでます。Gemfile から ruby-stemmer を外します。ruby-stemmer は語の表層形から活用語尾などを取り除くためのものです。

    An error occurred while installing ruby-stemmer (0.8.5), and Bundler cannot continue.

ここまでしてやっと `$ bundle install` できた・・・

さて次は rake bootstrap です。以下のコマンドを実施します。

    $ bundle exec rake bootstrap RAILS_ENV=development

画像を扱うためのライブラリが無いぞ！と言われ rake bootstrap ができないので libmagic をいれます。

    $ brew install libmagic

次のエラーです。Ruby 2.0 を使ってるので iconv 関連で起動しませんでした。Gemfile に `gem 'iconv'` を足して `$ bundle install` します。mongodb が起動していなかったせいでエラーが出たので起動してから rake bootstrap しました。
 
    Created /Users/iriya/.bughunterrc with username=admin password=admin
    Loaded
    syck has been removed, psych is used instead
    DEPRECATION WARNING: You have Rails 2.3-style plugins in vendor/plugins! Support for these plugins will be removed in Rails 4.0. Move them out and bundle them in your Gemfile, or fold them in to your app as lib/myplugin/* and config/initializers/myplugin.rb. See the release notes for more on this: http://weblog.rubyonrails.org/2012/1/4/rails-3-2-0-rc2-has-been-released. (called from <top (required)> at /Users/iriya/project/shapado/Rakefile:7)
    DEPRECATION WARNING: You have Rails 2.3-style plugins in vendor/plugins! Support for these plugins will be removed in Rails 4.0. Move them out and bundle them in your Gemfile, or fold them in to your app as lib/myplugin/* and config/initializers/myplugin.rb. See the release notes for more on this: http://weblog.rubyonrails.org/2012/1/4/rails-3-2-0-rc2-has-been-released. (called from <top (required)> at /Users/iriya/project/shapado/Rakefile:7)
    rake aborted!

rake bootstrap が出来ないのでここで諦めます。まずは `rails s` での起動を目指す。

`/etc/hosts` に以下を追記して `rails s` で起動しました。
    
    "0.0.0.0 localhost.lan group1.localhost.lan group2.localhost.lan"

ここでうまくいったと思ったのですが、リダイレクトループになってしまったので諦めました。

以下 rake bootstrap の trace です。
    
    iriya@mba> bundle exec rake bootstrap RAILS_ENV=development --trace                                   (git)-[master]-
    Loaded
    syck has been removed, psych is used instead
    DEPRECATION WARNING: You have Rails 2.3-style plugins in vendor/plugins! Support for these plugins will be removed in Rails 4.0. Move them out and bundle them in your Gemfile, or fold them in to your app as lib/myplugin/* and config/initializers/myplugin.rb. See the release notes for more on this: http://weblog.rubyonrails.org/2012/1/4/rails-3-2-0-rc2-has-been-released. (called from <top (required)> at /Users/iriya/project/shapado/Rakefile:7)
    DEPRECATION WARNING: You have Rails 2.3-style plugins in vendor/plugins! Support for these plugins will be removed in Rails 4.0. Move them out and bundle them in your Gemfile, or fold them in to your app as lib/myplugin/* and config/initializers/myplugin.rb. See the release notes for more on this: http://weblog.rubyonrails.org/2012/1/4/rails-3-2-0-rc2-has-been-released. (called from <top (required)> at /Users/iriya/project/shapado/Rakefile:7)
    ** Invoke bootstrap (first_time)
    ** Invoke environment (first_time)
    ** Execute environment
    Missing GeoIP data. Please run '/Users/iriya/project/shapado/script/update_geoip'
    install ruby-stemmer `gem install ruby-stemmer` to activate the full text search support
    install ruby-stemmer `gem install ruby-stemmer` to activate the full text search support
    install ruby-stemmer `gem install ruby-stemmer` to activate the full text search support
    install ruby-stemmer `gem install ruby-stemmer` to activate the full text search support
    >> Setting up Twitter provider
    >> Setting up Facebook provider
    >> Setting up Identica provider
    >> Setting up Github provider
    >> Setting up LinkedIn provider
    ** Invoke db:drop (first_time)
    ** Invoke db:mongoid:drop (first_time)
    ** Invoke environment 
    ** Execute db:mongoid:drop
    ** Execute db:drop
    ** Invoke setup:versions (first_time)
    ** Invoke environment 
    ** Execute setup:versions
    ** Invoke setup:create_admin (first_time)
    ** Invoke environment 
    ** Execute setup:create_admin
    ** Invoke setup:default_theme (first_time)
    ** Invoke environment 
    ** Execute setup:default_theme
    Error processing 531f1f5e3407653ee4000013: undefined method `empty?' for nil:NilClass
    Error processing 531f1f5e3407653ee4000013: undefined method `empty?' for nil:NilClass
    ** Invoke setup:default_group (first_time)
    ** Invoke environment 
    ** Execute setup:default_group
    rake aborted!
    Called id for nil, which would mistakenly be 8 -- if you really wanted the id of nil, use object_id
    /Users/iriya/project/shapado/app/models/group.rb:641:in `set_shapado_version'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:451:in `_run__4383945358378565518__create__3161521134659722749__callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:405:in `__run_callback'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:385:in `_run_create_callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:81:in `run_callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/callbacks.rb:43:in `run_callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence/insertion.rb:25:in `block (2 levels) in prepare'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:447:in `_run__4383945358378565518__save__3161521134659722749__callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:405:in `__run_callback'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:385:in `_run_save_callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/activesupport-3.2.6/lib/active_support/callbacks.rb:81:in `run_callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/callbacks.rb:43:in `run_callbacks'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence/insertion.rb:24:in `block in prepare'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence/insertion.rb:22:in `tap'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence/insertion.rb:22:in `prepare'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence/operations/insert.rb:26:in `persist'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence.rb:49:in `insert'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence.rb:154:in `upsert'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/bundler/gems/mongoid-39f32f964378/lib/mongoid/persistence.rb:75:in `save!'
    /Users/iriya/project/shapado/lib/tasks/setup.rake:48:in `block (2 levels) in <top (required)>'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:205:in `call'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:205:in `block in execute'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:200:in `each'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:200:in `execute'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:158:in `block in invoke_with_call_chain'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/2.0.0/monitor.rb:211:in `mon_synchronize'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:151:in `invoke_with_call_chain'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:176:in `block in invoke_prerequisites'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:174:in `each'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:174:in `invoke_prerequisites'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:157:in `block in invoke_with_call_chain'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/2.0.0/monitor.rb:211:in `mon_synchronize'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:151:in `invoke_with_call_chain'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/task.rb:144:in `invoke'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:116:in `invoke_task'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:94:in `block (2 levels) in top_level'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:94:in `each'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:94:in `block in top_level'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:133:in `standard_exception_handling'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:88:in `top_level'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:66:in `block in run'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:133:in `standard_exception_handling'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/lib/rake/application.rb:63:in `run'
    /Users/iriya/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/rake-0.9.2.2/bin/rake:33:in `<top (required)>'
    /Users/iriya/.rbenv/versions/2.0.0-p353/bin/rake:23:in `load'
    /Users/iriya/.rbenv/versions/2.0.0-p353/bin/rake:23:in `<main>'
    Tasks: TOP => bootstrap => setup:default_group

また Shapado のインストール過程で以下の場所にファイルが作成されています。

- `Created /Users/iriya/.magent_webrc with username=admin password=admin`
- `Created /Users/iriya/.bughunterrc with username=admin password=admin`

以下のファイルを編集しています。

- `config/locales/invitations/en.yml`
- `config/locales/searches/en.yml`

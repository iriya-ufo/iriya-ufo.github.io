---
layout: post
title: "Passenger をやめて Puma にした"
date: 2016-05-07 15:23:21 +0900
comments: true
categories: programming
tags:
  - puma
  - passenger
---

とあるプロジェクトで Nginx + Passenger という組合せで動かしていたのだが、リクエストの同期処理動作で具合が悪かったので Puma に切り替えた話。

## 環境など
- Nginx や Passenger は設定済みで動作していた
- Capistrano でデプロイしている
- システム全体に rbenv で ruby をインストールしている
- デプロイユーザーが別にいる(今回の場合 `deployer`)

## sudo の許可
deployer で puma の再起動ができるようにするため `sudo` 権限を与える。全コマンドの `sudo` は危険なので特定コマンドのみに制限する。

    $ visudo
    deployer ALL=(ALL) ALL
    deployer ALL=(ALL) NOPASSWD: /sbin/service puma restart

## rbenv PATH の設定
```sh /etc/profile.d/rbenv.sh
export RBENV_ROOT="/usr/local/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
```

## 起動スクリプトを作成
所有者は root で `chmod 755`

```sh /etc/init.d/puma
#!/bin/bash
#
# puma-myproject

# chkconfig: 2345 82 55
# processname: puma-myproject
# description: Runs puma-myproject for nginx integration.

# Include RedHat function library
. /etc/rc.d/init.d/functions

# The name of the service
NAME=puma

# The username and path to the myapp source
USER=deployer
APP_PATH=/your-app-path/current

# The PID and LOCK files used by puma and sidekiq
UPID=$APP_PATH/tmp/pids/puma.pid
ULOCK=/var/lock/subsys/$NAME

# The options to use when running puma
#OPTS="-C $APP_PATH/config/puma.rb -e production"
#OPTS="-F $APP_PATH/config/puma.rb"
OPTS="-F /your-app-path/shared/puma.rb"

# Ruby related path update
RUBY_PATH_PATCH="PATH=$PATH:/usr/local/bin:/usr/local/lib && export PATH && "
BUNDLE_CMD=bundle
PUMA_CMD=pumactl
. /etc/profile.d/rbenv.sh

start() {
  cd $APP_PATH
  # Start puma
  echo -n $"Starting $NAME: "
  daemon --pidfile=$UPID --user=$USER $BUNDLE_CMD exec $PUMA_CMD $OPTS start
  puma=$?
  [ $puma -eq 0 ] && touch $ULOCK
  echo

  return $puma
}

stop() {
  cd $APP_PATH

  # Stop puma
  echo -n $"Stopping $NAME: "
  killproc -p $UPID
  puma=$?
  [ $puma -eq 0 ] && rm -f $ULOCK
  echo

  return $puma
}

restart() {
  stop
  start
}

get_status() {
  status -p $UPID $NAME
}

query_status() {
  get_status >/dev/null 2>&1
}

case "$1" in
  start)
    query_status && exit 0
    start
    ;;
  stop)
    query_status || exit 0
    stop
    ;;
  restart)
    restart
    ;;
  status)
    get_status
    exit $?
    ;;
  *)
    N=/etc/init.d/$NAME
    echo "Usage: $N {start|stop|restart|status}" >&2
    exit 1
    ;;
esac

exit 0
```

## puma 設定ファイルを作成
所有者は deployer で `chmod 644`

```ruby /your-app-path/shared/puma.rb
#!/usr/bin/env puma

directory '/your-app-path/current'
rackup "/your-app-path/current/config.ru"
environment 'production'
daemonize true

pidfile "/your-app-path/shared/tmp/pids/puma.pid"
state_path "/your-app-path/shared/tmp/state/puma.state"
stdout_redirect '/your-app-path/current/log/puma.access.log', '/your-app-path/current/log/puma.error.log', true

threads 0,16
workers 0

bind 'unix:///your-app-path/shared/tmp/sockets/puma.sock'

preload_app!

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/your-app-path/current/Gemfile"
end


on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
```

## nginx 設定ファイル
バックアップを作っておく

```diff /usr/local/nginx/conf/nginx.conf
3c3
< worker_processes  auto;
---
> worker_processes  1;
17a18,20
>     passenger_root /usr/local/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/passenger-5.0.23;
>     passenger_ruby /usr/local/rbenv/versions/2.2.2/bin/ruby;
>
```

```diff /usr/local/nginx/conf/conf.d/app.conf
1,4d0
< upstream app {
<     server unix:///your-app-path/current/tmp/sockets/puma.sock;
< }
<
20,27c16,17
<         gzip_static on;
<         proxy_read_timeout 60;
<         proxy_connect_timeout 60;
<         proxy_redirect off;
<         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
<         proxy_set_header Host $http_host;
<         proxy_set_header X-Forwarded-Proto $scheme;
<         proxy_set_header X-Real-IP $remote_addr;
---
>         passenger_enabled on;
>         rails_env sandbox;
30,34d19
<             break;
<         }
<
<         if (!-f $request_filename) {
<             proxy_pass http://app;
```

## 起動確認と自動起動

    $ service nginx configtest
    $ chkconfig puma on

## その他動かなかったので修正など

secret キーが必要だったので再生成する。
`.env` ファイルを作成する。所有者は deployer とする。

```sh /your-app-path/shared/.env
SECRET_KEY_BASE="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
RAILS_ENV="production"
```

secret キーの生成は以下のコマンドで作れる。

    $ bundle exec rake secret

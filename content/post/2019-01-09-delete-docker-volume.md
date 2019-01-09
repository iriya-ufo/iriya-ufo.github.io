---
layout: post
title: "docker-compose up で db が立ち上がらない時は volume を削除してみる"
slug: delete-docker-volume
date: 2019-01-09T11:27:47+09:00
lastmod: 2019-01-09T11:27:47+09:00
comments: true
categories:
  - "programming"
tags:
  - "docker"
---

とある Rails プロジェクトを Docker 化する過程で db にうまく接続できないエラーに遭遇した。

`docker-compose up` するとこんな感じのエラーがでる。

``` bash
Starting app_db_1 ... done
Creating app_web_1 ... done
Attaching to app_db_1, app_web_1
db_1   | 2019-01-09T01:57:45.523451Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
db_1   | 2019-01-09T01:57:45.524650Z 0 [Note] mysqld (mysqld 5.7.24) starting as process 1 ...
db_1   | 2019-01-09T01:57:45.528223Z 0 [Note] InnoDB: PUNCH HOLE support available
db_1   | 2019-01-09T01:57:45.528319Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
db_1   | 2019-01-09T01:57:45.528348Z 0 [Note] InnoDB: Uses event mutexes
db_1   | 2019-01-09T01:57:45.528374Z 0 [Note] InnoDB: GCC builtin __atomic_thread_fence() is used for memory barrier
db_1   | 2019-01-09T01:57:45.528394Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
db_1   | 2019-01-09T01:57:45.528543Z 0 [Note] InnoDB: Using Linux native AIO
db_1   | 2019-01-09T01:57:45.528969Z 0 [Note] InnoDB: Number of pools: 1
db_1   | 2019-01-09T01:57:45.529276Z 0 [Note] InnoDB: Using CPU crc32 instructions
db_1   | 2019-01-09T01:57:45.530867Z 0 [Note] InnoDB: Initializing buffer pool, total size = 128M, instances = 1, chunk size = 128M
db_1   | 2019-01-09T01:57:45.540619Z 0 [Note] InnoDB: Completed initialization of buffer pool
db_1   | 2019-01-09T01:57:45.542550Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
db_1   | 2019-01-09T01:57:45.554602Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
db_1   | 2019-01-09T01:57:45.554769Z 0 [ERROR] InnoDB: Unsupported redo log format. The redo log was created with MariaDB 10.3.10. Please follow the instructions at http://dev.mysql.com/doc/refman/5.7/en/upgrading-downgrading.html
db_1   | 2019-01-09T01:57:45.554873Z 0 [ERROR] InnoDB: Plugin initialization aborted with error Generic error
db_1   | 2019-01-09T01:57:46.160053Z 0 [ERROR] Plugin 'InnoDB' init function returned error.
db_1   | 2019-01-09T01:57:46.160184Z 0 [ERROR] Plugin 'InnoDB' registration as a STORAGE ENGINE failed.
db_1   | 2019-01-09T01:57:46.160209Z 0 [ERROR] Failed to initialize builtin plugins.
db_1   | 2019-01-09T01:57:46.160224Z 0 [ERROR] Aborting
db_1   |
db_1   | 2019-01-09T01:57:46.160239Z 0 [Note] Binlog end
db_1   | 2019-01-09T01:57:46.160356Z 0 [Note] Shutting down plugin 'CSV'
db_1   | 2019-01-09T01:57:46.163497Z 0 [Note] mysqld: Shutdown complete
db_1   |
app_db_1 exited with code 1
```

db のコンテナが起動に失敗しているようだが、エラー内容でググってもあまり有効な解決策に繋がらない。
最終的に volume を削除して立ち上げて治すことで解決できた。

``` bash
# Volume の一覧
$ docker volume ls

# Volume の削除
$ docker volume rm VOLUME_NAME
```

なぜ volume 削除で治ったのかという原因なんだけども、おそらく `docker-compose.yml` を色々いじっていく過程で MySQL のバージョンを変更したためだと思われる。
ここが解決の糸口になった。

- [Laradock v5.5.2 で一度docker-compose upしちゃった後に、v5.5.1に戻しても、MySQLが起動しない問題](https://qiita.com/yamazaki/items/5d7f7ee4daa2c1db5aae)


ちなみに `docker-compose.yml` の中身は以下のようにしている。
他の Rails プロジェクトで同様の書き方で動作していたので、今回のエラーの原因になかなかたどり着けなかった。

``` yaml
version: '3'

services:
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: 'password'
    ports:
      - "3306:3306"
    volumes:
      - "dbdata:/var/lib/mysql"
      - "./resources/containers/mariadb:/etc/mysql/conf.d"

  web:
    build: .
    command: bundle exec rails s -p 3000 -b '0.0.0.0'
    tty: true
    stdin_open: true
    ports:
      - "3000:3000"
    env_file:
      - .env
    environment:
      RAILS_ENV: development
      DATABASE_URL: "mysql2://root:password@db:3306"
    depends_on:
      - db
    volumes:
      - .:/usr/src/app

volumes:
  dbdata:
```

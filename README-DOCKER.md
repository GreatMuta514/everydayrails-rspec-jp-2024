### 事前準備
環境変数の準備
```bash
cp .development.env.example .development.env
```

アプリ名の設定（docker-compose.ymlとconfig/database.ymlが対象）
```docker-compose.yml
  app:
    image: app
    build: .
    container_name: rails
    command: bin/rails server -b 0.0.0.0
    volumes:
      - .:/sample_app # 任意のアプリ名に変更
```

```
test:
  <<: *default
  database: sample_app_test # 任意のアプリ名に変更

production:
  <<: *default
  database: sample_app_production # 任意のアプリ名に変更
  password:

```

### コンテナ立ち上げ手順

```bash
# 最低限のgemでイメージ作成
docker compose build --no-cache

# railsアプリケーションの雛形作成
# 使うデータベースに応じてオプションを変える
docker compose run --rm app rails new . --force --database=mysql
```

### db接続設定の編集
元々用意されていたconfig/database.ymlが勝手に変更されるので、元に戻す。それ以外の変更は放置。

```bash
# rails newによりgemが大量に追加されたので、再度bundle install
docker compose run --rm app bundle install

# railsコンテナの起動
docker compose up -d
```
### ブラウザでページを開く

```
http://localhost:3000/
```

ブラウザで開いてActiveRecord::NoDatabaseErrorと出たらdb立ち上げを実施。（1回目は必ず出る）
###### db立ち上げ手順

```bash
docker compose exec app bash
rails db:create
```

### .gitignoreの追加

rails new実行時に.gitignoreが生成されるので、下記を追加しておく。
初回コミット時に一緒にコミットするのを忘れないこと。
```.gitignore
.development.env
```

### 開発終了時

```bash
# 開発終了時にコンテナを落とす
docker compose down
```

### 開発再開時

```bash
# 開発終了時にコンテナを落とす
docker compose down
```

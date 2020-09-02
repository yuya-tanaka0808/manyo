# README

## schema

### Taskモデル
|カラム名|データ型|
| :---: | :---: |
|id|integer|
|title|string|
|content|text|
|priority|integer|
|time_limit|datetime|
|status|string|
|user_id|integer|



### Userモデル
|カラム名|データ型|
| :---: | :---: |
|id|integer|
|name|string|
|email|string|
|password_digest|string|


### Labelモデル
|カラム名|データ型|
| :---: | :---: |
|id|integer|
|task_id|integer|
|user_id|integer|

## Herokuデプロイ手順

1. デプロイするアプリのディレクトリへ移動
2. Herokuにログイン
   - `$ heroku login`
3. アセットプリコンパイルをする
   - `$ rails assets:precompile RAILS_ENV=production`
4. アプリを追加・コミットする
   - `$ git add -A`
   - `$ git commit -m "coment"`
5. Heroku上にアプリを作成する
   - `$ heroku create`
6. Heroku buildpackを追加する
   - `$ heroku buildpacks:set heroku/ruby`
   - `$ heroku buildpacks:add --index 1 heroku/nodejs`
7. Herokuにデプロイする
   - マスター；`$ git push heroku master`
   - branch：`$ git push heroku <ブランチ名>:master`
8. データベース移行
   - `$heroku run rails db:migrate`

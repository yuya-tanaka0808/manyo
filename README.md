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

# README

## usersテーブル

|Column               |Type     |Options     |
|---------------------|---------|------------|
|email                |string   |null: false |
|password             |string   |null: false |
|nickname             |string   |null: false |
|first_name           |string   |null: false |
|last_name            |string   |null: false |
|first_furigana       |string   |null: false |
|last_furigana        |string   |null: false |
|birthday             |string   |null: false |


### Association
has_many :itemsテーブル
has_many :purchase_recordテーブル

## itemsテーブル

|Column               |Type       |Options                        |
|---------------------|-----------|-------------------------------|
|item_name            |string     |null: false                    |
|explain              |text       |null: false                    |
|category             |text       |null: false                    |
|condition            |text       |null: false                    |
|delivery_fee         |string     |null: false                    |
|delivery_source      |string     |null: false                    |
|delivery_date        |string     |null: false                    |
|users                |references |null: false, foreign_key: true |



### Association
belongs_to :usersテーブル
has_one :purchase_recordテーブル


## purchase_recordテーブル

|Column      |Type      |Options                        |
|------------|----------|-------------------------------|
|users       |references|null: false, foreign_key: true |


### Association
has_one :shipping_addressテーブル
belongs_to :usersテーブル

## shipping_addressテーブル

|Column               |Type   |Options     |
|---------------------|-------|------------|
|postal_code          |string |null: false |
|prefectures          |string |null: false |
|municipality         |string |null: false |
|address              |string |null: false |
|building_name        |string |null: false |
|telephone_number     |string |null: false |


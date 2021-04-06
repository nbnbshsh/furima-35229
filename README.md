# README

## usersテーブル

|Column               |Type     |Options     |
|---------------------|---------|------------|
|email                |string   |null: false |
|encrypted_password   |string   |null: false |
|nickname             |string   |null: false |
|first_name           |string   |null: false |
|last_name            |string   |null: false |
|first_furigana       |string   |null: false |
|last_furigana        |string   |null: false |
|date                 |string   |null: false |


### Association
has_many :items
has_many :purchase_records

## itemsテーブル

|Column               |Type       |Options                        |
|---------------------|-----------|-------------------------------|
|item_name            |string     |null: false                    |
|explain              |text       |null: false                    |
|category_id          |text       |null: false                    |
|condition_id         |text       |null: false                    |
|delivery_fee_id      |string     |null: false                    |
|prefectures_id       |string     |null: false                    |
|delivery_date_id     |string     |null: false                    |
|price                |string     |null: false                    |
|user                 |references |null: false, foreign_key: true |



### Association
belongs_to :user
has_one :purchase_record

## purchase_recordsテーブル

|Column      |Type      |Options                        |
|------------|----------|-------------------------------|
|user        |references|null: false, foreign_key: true |


### Association
has_one :shipping_address
belongs_to :items
belongs_to :user

## shipping_addressテーブル

|Column               |Type   |Options     |
|---------------------|-------|------------|
|postal_code          |string |null: false |
|prefecture_id       |string |null: false |
|municipality         |string |null: false |
|address              |string |null: false |
|building_name        |string |            |
|telephone_number     |string |null: false |

belongs_to :purchase_record
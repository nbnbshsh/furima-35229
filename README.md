# README

## usersテーブル

|Column               |Type     |Options     |
|---------------------|---------|------------|
|email                |string   |null: false,unique: true |
|encrypted_password   |string   |null: false |
|nickname             |string   |null: false |
|first_name           |string   |null: false |
|last_name            |string   |null: false |
|first_furigana       |string   |null: false |
|last_furigana        |string   |null: false |
|birthday             |date     |null: false |


### Association
has_many :items
has_many :purchase_records

## itemsテーブル

|Column               |Type       |Options                        |
|---------------------|-----------|-------------------------------|
|item_name            |string     |null: false                    |
|explain              |text       |null: false                    |
|category_id          |integer    |null: false                    |
|condition_id         |integer    |null: false                    |
|delivery_fee_id      |integer    |null: false                    |
|prefecture_id        |integer    |null: false                    |
|delivery_date_id     |integer    |null: false                    |
|price                |integer    |null: false                    |
|user                 |references |null: false, foreign_key: true |



### Association
belongs_to :user
has_one :purchase_record

## purchase_recordsテーブル

|Column      |Type      |Options                        |
|------------|----------|-------------------------------|
|user        |references|null: false, foreign_key: true |
|item        |references|null: false, foreign_key: true |


### Association
has_one :shipping_address
belongs_to :item
belongs_to :user

## shipping_addressテーブル

|Column               |Type      |Options                        |
|---------------------|----------|-------------------------------|
|postal_code          |string    |null: false                    |
|prefecture_id        |integer   |null: false                    |
|municipality         |string    |null: false                    |
|address              |string    |null: false                    |
|building_name        |string    |                               |
|telephone_number     |string    |null: false                    |
|purchase_record      |references|null: false, foreign_key: true |

belongs_to :purchase_record
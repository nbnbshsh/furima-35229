# README

## usersテーブル

|Column               |Type     |Options                  |
|---------------------|---------|-------------------------|
|email                |string   |null: false,unique: true |
|encrypted_password   |string   |null: false              |
|nickname             |string   |null: false              |
|first_name           |string   |null: false              |
|last_name            |string   |null: false              |
|first_furigana       |string   |null: false              |
|last_furigana        |string   |null: false              |
|birthday             |date     |null: false              |


### Association
has_many :items
has_one :address
has_one :cards

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
has_one :item_order
has_many :tags
has_one :item_tag_relation


## item_ordersテーブル

|Column      |Type      |Options                        |
|------------|----------|-------------------------------|
|item        |references|null: false, foreign_key: true |


### Association
belongs_to :item

## addressesテーブル

|Column               |Type      |Options                        |
|---------------------|----------|-------------------------------|
|postal_code          |string    |null: false                    |
|prefecture_id        |integer   |null: false                    |
|municipality         |string    |null: false                    |
|address              |string    |null: false                    |
|building_name        |string    |                               |
|telephone_number     |string    |null: false                    |
|order                |references|null: false, foreign_key: true |

### Association
belongs_to :user

## cardsテーブル

|Column          |Type      |Options                        |
|----------------|----------|-------------------------------|
|user            |references|null: false, foreign_key: true |
|customer_token  |string    |null: false                    |
|card_token      |string    |null: false                    |

### Association
belongs_to :user

# tagsテーブル
|Column               |Type       |Options                        |
|---------------------|-----------|-------------------------------|
|name                 |string     |null: false                    |

### Association
has_many :items
has_one :item_tag_relation

# item_tag_relationsテーブル
|Column          |Type      |Options                        |
|----------------|----------|-------------------------------|
|item            |references|null: false, foreign_key: true |
|tag             |references|null: false, foreign_key: true |

### Association
belongs_to :item
belongs_to :tag



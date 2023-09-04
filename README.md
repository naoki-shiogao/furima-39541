# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## テーブル設計

## usersテーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| name               | string | null: false |
| name_reading       | string | null: false |
| birth_day          | integer| null: false |
## Association
- has_many :items
- has_many :orders
## itemsテーブル
| Column             | Type   | Options                             |
| ------------------ | ------ | ----------------------------------- |
| name               | string | null: false                         |
| explanation        | text   | null: false                         |
| category           | integer| null: false                         |
| condition          | integer| null: false                         |
| price              | integer| null: false                         |
| user               | references| null: false, foreign_key: true   |
## Association
- belongs_to :user
- has_one :ouder
## ordersテーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |
## Association
- belongs_to :user
- belongs_to :item
- has_one :address
## addressesテーブル
| Column             | Type   | Options                             |
| ------------------ | ------ | ----------------------------------- |
| postal_code        | string | null: false                         |
| prefecture         | integer| null: false                         |
| city               | string | null: false                         |
| house_number       | string | null: false                         |
| building_name      | string |                                     |
| order              | references| null: false, foreign_key: true   |
## Association
- belongs_to :order
* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

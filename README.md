## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false               |
| encrypted_password | string | null: false               |
| nickname           | string | null: false, unique: true |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :purchases
- belongs_to :card


## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| product_name        | string     | null: false                    |
| product_description | text       | null: false                    |
| category            | integer    | null: false                    |
| condition           | integer    | null: false                    |
| shipping_fee        | integer    | null: false                    |
| region              | integer    | null: false                    |
| shipping_day        | integer    | null: false                    |
| price               | integer    | null: false                    |
| user_id             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchases
- belongs_to_active_hash :shipping_fee
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :prefecture_region
- belongs_to_active_hash :shipping_day


## address テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| post_code    | string     | null: false                    |
| prefecture   | integer    | null: false                    |
| city         | string     | null: false                    |
| block        | string     | null: false                    |
| building     | string     | null: false                    |
| phone_number | string     | null: false                    |

### Association

- has_one_active_hash :prefecture_region
- has_many :purchases

## purchases テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user_id    | integer    | null: false, foreign_key: true |
| item_id    | integer    | null: false, foreign_key: true |
| address_id | integer    | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address

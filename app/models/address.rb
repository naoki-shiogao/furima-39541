class Address < ApplicationRecord
  belongs_to :order
  belongs_to :prefecture

  with_options presence: true do
    validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :telephone_number, format: { with: /\d{10,11}/ }
  end
end

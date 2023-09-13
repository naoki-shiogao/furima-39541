class Order < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number

  belongs_to :user
  belongs_to :item
  has_one :address

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :house_number
    validates :telephone_number, format: { with: /\A\d{10,11}\z/,message: "is invalid. Include hyphen(-)"}
  end


end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :delivery_city
  belongs_to :delivery_day
  belongs_to :user
  has_one :order
  has_one_attached :image
  has_many :favorites, dependent: :destroy

  validates :image, presence: true
  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :delivery_charge_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :delivery_city_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :delivery_day_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end

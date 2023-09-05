class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  with_options presence: true do
    # ひらがな、カタカナ、漢字のみ許可する
    validates :last_name, :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters."}
    # カタカナのみ許可する
    validates :last_name_reading, :first_name_reading, format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."}
  end
  validates :password, format:{with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は半角英数を両方含む必要があります"}
  validates :nickname, presence: true
  validates :birth_day, presence: true
end

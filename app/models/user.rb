class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # バリーデーションの設定
  with_options presence: true do
    validates :nickname
    validates :password, :password_confirmation, confirmation: true,
              format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i, message:'Include both letters and numbers' }
    validates :last_name, :first_name, 
              format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message:'Full-width characters' }
    validates :last_name_kana, :first_name_kana,
              format: { with: /\A[ァ-ヶー－]+\z/, message:'Full-width katakana characters' }
    validates :birthday
  end
end

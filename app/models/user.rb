class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # バリーデーションの設定
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i
  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/
  KANA_REGEX = /\A[ァ-ヶー－]+\z/
  with_options presence: true do
    validates :nickname
    validates :last_name, :first_name, 
              format: { with: NAME_REGEX, message:'Full-width characters' }
    validates :last_name_kana, :first_name_kana,
              format: { with: KANA_REGEX, message:'Full-width katakana characters' }
    validates :birthday
  end
  validates :email,
              format: { with: EMAIL_REGEX, message:'Include @'}
  validates :password, :password_confirmation, confirmation: true,
            format: { with: PASSWORD_REGEX, message:'Include both letters and numbers' }
end

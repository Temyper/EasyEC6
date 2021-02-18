class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :goods, dependent: :destroy
  has_many :good_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  
  # 20210217Rubyの正規表現で^、$が文字列頭尾ではないらしい。^→\A、$→\z
  validates :name, presence: true, format: {with: /\A[a-zA-Z\d]{2,20}\z/}, uniqueness: true
  # validates :name, presence: true, format: {with: /\A[a-zA-Z\d]{2,20}\z/}, uniqueness: true
  
  validates :email, presence: true, format: {with: /\A[a-zA-Z\d]{1,50}@[a-zA-Z\d\.]{1,30}\z/}
  validates :introduction, length: {maximum:50}
end

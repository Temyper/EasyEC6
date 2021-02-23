class Good < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, format: {with: /\A[a-zA-Z\d]{1,20}\z/} , uniqueness: false
  validates :introduction, presence: true, length: {maximum: 200}, uniqueness: false
  has_many :good_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  attachment :image
  
  def favorited_by?(user)
    
    favorites.where(user_id: user.id).exists?
  end
end

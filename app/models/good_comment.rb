class GoodComment < ApplicationRecord
   belongs_to :user
   belongs_to :good
   
   validates :content, presence: true, length: {minimum: 1,maximum: 200}, uniqueness: false
end

class Comment < ActiveRecord::Base
  has_many  :replies, class_name: Comment, foreign_key: :parent_id

  belongs_to :parent, class_name: Comment
  belongs_to :user
  
  validates :message, presence: true
end
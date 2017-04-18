class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent_comment, :class_name => "Comment", :foreign_key => "parent_comment_id", optional: true
  has_many :child_comments, :class_name => "Comment", :foreign_key => "parent_comment_id"
  
  validates :content, presence: true, length: {minimum: 1, maximum: 40000}
  validates :user_id, presence: true
  validates :post_id, presence: true
end
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :comments

  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true, length: { maximum: 40_000 }
  validates :user_id, presence: true
  validates :topic_id, presence: true

  def direct_replies
    comments.select { |comment| comment.parent_comment.nil? }
  end
end

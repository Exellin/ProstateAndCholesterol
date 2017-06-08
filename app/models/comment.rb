class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent_comment, :class_name => "Comment", :foreign_key => "parent_comment_id", optional: true
  has_many :child_comments, :class_name => "Comment", :foreign_key => "parent_comment_id"
  
  validates :content, presence: true, length: {minimum: 1, maximum: 40000}
  validates :user_id, presence: true
  validates :post_id, presence: true
  
  def get_ancestors(comment)
    @ancestors ||= 0
    
    if comment.parent_comment.nil?
      return @ancestors
    else
      @ancestors += 1
      get_ancestors(comment.parent_comment)
    end
  end
  
  def get_children_tree(comment, depth)
  @children_tree ||= []
  
    comment.child_comments.each do |child_comment|
      if (child_comment.ancestor_count - @root.ancestor_count) > depth
        return @children_tree
      else
        @children_tree << child_comment
        get_children_tree(child_comment, depth)
      end
    end
    return @children_tree
  end
  
  def ancestor_count
    @ancestors = get_ancestors(self)
  end
  
  def children_tree(depth)
    @root = self
    @children_tree = get_children_tree(self, depth)
  end
end
class AddTimestampsToTopicsPostsComments < ActiveRecord::Migration[5.0]
  def self.up
    add_column :topics, :created_at, :datetime
    change_column :topics, :created_at, :datetime, :null => false
    add_column :topics, :updated_at, :datetime
    change_column :topics, :updated_at, :datetime, :null => false
    
    add_column :posts, :created_at, :datetime
    change_column :posts, :created_at, :datetime, :null => false
    add_column :posts, :updated_at, :datetime
    change_column :posts, :updated_at, :datetime, :null => false
    
    add_column :comments, :created_at, :datetime
    change_column :comments, :created_at, :datetime, :null => false
    add_column :comments, :updated_at, :datetime
    change_column :comments, :updated_at, :datetime, :null => false
  end
  
  def self.down
    remove_column :topics, :created_at
    remove_column :topics, :updated_at
    
    remove_column :posts, :created_at
    remove_column :posts, :updated_at
    
    remove_column :comments, :created_at
    remove_column :comments, :updated_at
  end
end

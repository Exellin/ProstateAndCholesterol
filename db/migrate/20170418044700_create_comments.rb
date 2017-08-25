class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :parent_comment_id
    end
  end
end
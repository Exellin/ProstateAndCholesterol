class Profile < ApplicationRecord
  belongs_to :user
  
  def empty?
    ignored_attrs = {'id' => 1 , 'user_id' => 1, 'created_at' => 1, 'updated_at' => 1}
    self.attributes.all?{|key, value| value.blank? || ignored_attrs[key]}
  end
end

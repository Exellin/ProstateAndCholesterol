class RemoveEthnicityFromProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :ethnicity, :string
  end
end

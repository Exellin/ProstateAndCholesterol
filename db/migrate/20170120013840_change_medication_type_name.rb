class ChangeMedicationTypeName < ActiveRecord::Migration[5.0]
  def change
    rename_column :medications, :type, :purpose
  end
end

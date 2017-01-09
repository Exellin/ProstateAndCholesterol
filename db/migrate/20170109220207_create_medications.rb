class CreateMedications < ActiveRecord::Migration[5.0]
  def change
    create_table :medications do |t|
      t.string :type
      t.integer :age_recommended
      t.integer :age_prescribed
      t.string :name
      t.integer :strength
      t.integer :dosage
      t.integer :year_last_used
      t.string :month_last_used
      t.boolean :still_using
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end

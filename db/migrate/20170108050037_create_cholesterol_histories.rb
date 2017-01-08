class CreateCholesterolHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :cholesterol_histories do |t|
      t.integer :year
      t.string :month
      t.integer :total_cholesterol
      t.integer :hdl
      t.integer :ldl
      t.integer :triglyceride
      t.integer :glucose
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end

class CreatePsaHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :psa_histories do |t|
      t.integer :year
      t.string :month
      t.decimal :psa
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end

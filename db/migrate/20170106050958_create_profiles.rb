class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :birth_year
      t.string :city
      t.string :administrative_division
      t.string :country
      t.integer :years_in_current_locale
      t.string :ancestral_descent
      t.string :race
      t.string :ethnicity
      t.text :story
      t.integer :age_noticed_symptoms
      t.integer :age_urinary_malfunction
      t.integer :age_bladder_infection
      t.boolean :anonymous
      t.timestamps
    end
  end
end

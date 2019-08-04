class CreateAnimal < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name, null: false
      t.decimal :monthly_cost, null: false
      t.references :animal_type, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps null: false
    end
  end
end

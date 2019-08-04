class CreateAnimalType < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_types do |t|
      t.string :name, null: false
    end
  end
end

class CreatePerson < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :document, null: false
      t.date :birthday, null: false

      t.timestamps null: false
    end
  end
end

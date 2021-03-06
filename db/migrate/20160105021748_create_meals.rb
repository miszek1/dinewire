class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.string :location
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end

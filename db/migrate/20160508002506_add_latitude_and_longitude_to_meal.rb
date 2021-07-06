class AddLatitudeAndLongitudeToMeal < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :latitude, :float
    add_column :meals, :longitude, :float
  end
end

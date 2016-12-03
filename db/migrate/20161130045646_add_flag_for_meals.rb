class AddFlagForMeals < ActiveRecord::Migration
  def change
    add_column :meals, :flagged_for_review, :boolean
    add_index :meals, :flagged_for_review
  end
end

class AddExpiresAtToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :expires_at, :datetime
  end
end

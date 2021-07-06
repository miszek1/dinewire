class AddExpiresAtToMeal < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :expires_at, :datetime
  end
end

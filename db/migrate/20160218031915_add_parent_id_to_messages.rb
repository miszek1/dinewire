class AddParentIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :parent_id, :integer, index: true, foreign_key: true
  end
end

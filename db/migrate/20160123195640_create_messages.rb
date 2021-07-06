class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.integer :recipient_id

      t.timestamps null: false
    end
  end
end

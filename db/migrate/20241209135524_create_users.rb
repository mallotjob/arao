class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :username
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end

class AddTracableToUser < ActiveRecord::Migration[8.0]
  def self.up
    change_table :users do |t|
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

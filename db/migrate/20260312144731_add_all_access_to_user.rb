class AddAllAccessToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :all_access, :boolean, default: false, null: false
  end
end

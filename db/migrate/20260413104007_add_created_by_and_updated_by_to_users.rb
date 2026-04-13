class AddCreatedByAndUpdatedByToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :created_by, :uuid
    add_column :users, :updated_by, :uuid

    add_foreign_key :users, :users, column: :created_by
    add_foreign_key :users, :users, column: :updated_by
  end
end

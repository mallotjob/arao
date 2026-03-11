class AddStatusToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :status, :string
  end
end

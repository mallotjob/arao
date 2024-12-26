class AddVersionToTypeConfig < ActiveRecord::Migration[8.0]
  def change
    add_column :type_configs, :from_date, :datetime, null: false, default: -> { "CURRENT_DATE" }
    add_column :type_configs, :datetime, :date, null: true
  end
end

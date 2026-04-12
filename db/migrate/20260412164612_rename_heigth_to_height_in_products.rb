class RenameHeigthToHeightInProducts < ActiveRecord::Migration[8.1]
  def change
    rename_column :products, :heigth, :height
  end
end

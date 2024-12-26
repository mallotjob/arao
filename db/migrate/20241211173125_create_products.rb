class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products, id: :uuid do |t|
      t.references :shipping_time, null: false, foreign_key: true, type: :uuid
      t.references :type_config, null: false, foreign_key: true, type: :uuid
      t.references :beneficiary, null: false, foreign_key: true, type: :uuid
      t.integer :quantity
      t.float :length
      t.float :width
      t.float :heigth
      t.float :weight
      t.string :commodity
      t.string :tracking_number

      t.timestamps
    end
  end
end

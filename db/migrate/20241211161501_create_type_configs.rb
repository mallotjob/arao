class CreateTypeConfigs < ActiveRecord::Migration[8.0]
  def change
    create_table :type_configs, id: :uuid do |t|
      t.references :type, null: false, foreign_key: true, type: :uuid
      t.integer :price
      t.references :unit, null: false, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
  end
end

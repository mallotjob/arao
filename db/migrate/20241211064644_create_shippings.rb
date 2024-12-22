class CreateShippings < ActiveRecord::Migration[8.0]
  def change
    create_table :shippings, id: :uuid do |t|
      t.string :mark
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

class CreateTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :types, id: :uuid do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

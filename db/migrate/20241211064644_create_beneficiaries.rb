class CreateBeneficiaries < ActiveRecord::Migration[8.0]
  def change
    create_table :beneficiaries, id: :uuid do |t|
      t.string :shipping_mark
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

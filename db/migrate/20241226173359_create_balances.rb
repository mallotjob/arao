class CreateBalances < ActiveRecord::Migration[8.0]
  def change
    create_table :balances, id: :uuid do |t|
      t.references :companies, null: false, foreign_key: true, type: :uuid
      t.string :currency
      t.string :beneficiary_currency
      t.float :diff
      t.datetime :from_date, null: false, default: -> { "CURRENT_DATE" }
      t.datetime :to_date

      t.timestamps
    end
  end
end

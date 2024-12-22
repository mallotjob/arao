class CreateShippingTimes < ActiveRecord::Migration[8.0]
  def change
    create_table :shipping_times, id: :uuid do |t|
      t.date :given_date
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.references :type, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

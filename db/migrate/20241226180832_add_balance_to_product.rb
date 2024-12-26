class AddBalanceToProduct < ActiveRecord::Migration[8.0]
  def change
    add_reference :products, :balance, foreign_key: true, type: :uuid
  end
end

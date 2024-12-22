class AddAasmStateToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :aasm_state, :string
  end
end

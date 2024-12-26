require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: products
#
#  id               :uuid             not null, primary key
#  aasm_state       :string
#  commodity        :string
#  heigth           :float
#  length           :float
#  quantity         :integer
#  tracking_number  :string
#  weight           :float
#  width            :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  balance_id       :uuid
#  shipping_id      :uuid             not null
#  shipping_time_id :uuid             not null
#  type_config_id   :uuid             not null
#
# Indexes
#
#  index_products_on_balance_id        (balance_id)
#  index_products_on_shipping_id       (shipping_id)
#  index_products_on_shipping_time_id  (shipping_time_id)
#  index_products_on_type_config_id    (type_config_id)
#
# Foreign Keys
#
#  fk_rails_...  (balance_id => balances.id)
#  fk_rails_...  (shipping_id => shippings.id)
#  fk_rails_...  (shipping_time_id => shipping_times.id)
#  fk_rails_...  (type_config_id => type_configs.id)
#

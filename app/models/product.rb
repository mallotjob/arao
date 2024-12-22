class Product < ApplicationRecord
  include AASM

  aasm do
    state :pending, initial: true
    state :confirmed
    state :shipped
    state :completed
    state :delivered

    event :confirm do
      transitions from: :pending, to: :confirmed
    end

    event :ship do
      transitions from: :confirmed, to: :shipped
    end

    event :complete do
      transitions from: :shipped, to: :completed
    end

    event :deliver do
      transitions from: :completed, to: :delivered
    end
  end

  belongs_to :shipping_time
  belongs_to :type_config
  belongs_to :shipping

  def volume
  end

  def weight_per_volume
  end
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
#  shipping_id      :uuid             not null
#  shipping_time_id :uuid             not null
#  type_config_id   :uuid             not null
#
# Indexes
#
#  index_products_on_shipping_id       (shipping_id)
#  index_products_on_shipping_time_id  (shipping_time_id)
#  index_products_on_type_config_id    (type_config_id)
#
# Foreign Keys
#
#  fk_rails_...  (shipping_id => shippings.id)
#  fk_rails_...  (shipping_time_id => shipping_times.id)
#  fk_rails_...  (type_config_id => type_configs.id)
#

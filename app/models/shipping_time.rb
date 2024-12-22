class ShippingTime < ApplicationRecord
  belongs_to :company
  belongs_to :type
end

# == Schema Information
#
# Table name: shipping_times
#
#  id         :uuid             not null, primary key
#  given_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :uuid             not null
#  type_id    :uuid             not null
#
# Indexes
#
#  index_shipping_times_on_company_id  (company_id)
#  index_shipping_times_on_type_id     (type_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (type_id => types.id)
#

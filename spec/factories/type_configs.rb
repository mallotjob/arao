FactoryBot.define do
  factory :type_config do
    type { create(:type) }
    unit { create(:unit) }
    from_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    name { Faker::Commerce.product_name }
    price { Faker::Number.number(digits: 4) }
    datetime { Faker::Date.between(from: 30.days.ago, to: Date.today) }
  end
end

# == Schema Information
#
# Table name: type_configs
#
#  id         :uuid             not null, primary key
#  datetime   :date
#  from_date  :datetime         not null
#  name       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type_id    :uuid             not null
#  unit_id    :uuid             not null
#
# Indexes
#
#  index_type_configs_on_type_id  (type_id)
#  index_type_configs_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (type_id => types.id)
#  fk_rails_...  (unit_id => units.id)
#

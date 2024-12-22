class TypeConfig < ApplicationRecord
  belongs_to :type
  belongs_to :unity
end

# == Schema Information
#
# Table name: type_configs
#
#  id         :uuid             not null, primary key
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

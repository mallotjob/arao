class Type < ApplicationRecord
  belongs_to :company
end

# == Schema Information
#
# Table name: types
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :uuid             not null
#
# Indexes
#
#  index_types_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

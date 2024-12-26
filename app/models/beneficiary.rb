class Beneficiary < ApplicationRecord
  belongs_to :company_id
end

# == Schema Information
#
# Table name: beneficiaries
#
#  id            :uuid             not null, primary key
#  shipping_mark :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :uuid             not null
#
# Indexes
#
#  index_beneficiaries_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

FactoryBot.define do
  factory :balance do
    company { create(:company) }
  end
end

# == Schema Information
#
# Table name: balances
#
#  id                   :uuid             not null, primary key
#  beneficiary_currency :string
#  currency             :string
#  diff                 :float
#  from_date            :datetime         not null
#  to_date              :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  company_id           :uuid             not null
#
# Indexes
#
#  index_balances_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

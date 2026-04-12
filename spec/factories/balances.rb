FactoryBot.define do
  factory :balance do
    company { create(:company) }
    from_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    currency { Faker::Currency.code }
    beneficiary_currency { Faker::Currency.code }
    diff { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
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

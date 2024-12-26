class Balance < ApplicationRecord
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
#  companies_id         :uuid             not null
#
# Indexes
#
#  index_balances_on_companies_id  (companies_id)
#
# Foreign Keys
#
#  fk_rails_...  (companies_id => companies.id)
#

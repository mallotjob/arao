FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
  end
end

# == Schema Information
#
# Table name: companies
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_deleted_at  (deleted_at)
#

FactoryBot.define do
  factory :balance do
    company { create(:company) }
  end
end

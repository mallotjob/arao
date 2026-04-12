FactoryBot.define do
  factory :unit do
    name { Faker::Lorem.word }
    unit { Faker::Lorem.word }
  end
end

# == Schema Information
#
# Table name: units
#
#  id         :uuid             not null, primary key
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

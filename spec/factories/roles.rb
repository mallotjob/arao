FactoryBot.define do
  factory :role do
    description { Faker::Lorem.sentence }
    name { Faker::Lorem.word }
  end
end

# == Schema Information
#
# Table name: roles
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :permission do
    action { 'create' }
    subject { 'User' }
  end
end

# == Schema Information
#
# Table name: permissions
#
#  id         :uuid             not null, primary key
#  action     :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :permission do
    action { 'create' }
    subject { 'User' }
  end
end

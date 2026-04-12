FactoryBot.define do
  factory :role_permission do
    role { create(:role) }
    permission { create(:permission) }
  end
end

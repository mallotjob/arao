FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    password   { Faker::Internet.password }
    all_access { false }
    created_by { nil }
    updated_by { nil }

    after(:build) do |user|
      unless user.all_access?
        user.roles << create(:role) if user.roles.empty?
      end
    end

    trait :admin do
      all_access { true }
      created_by { nil }
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  all_access             :boolean          default(FALSE), not null
#  created_by             :uuid
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  deleted_at             :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_by             :uuid
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :uuid
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (created_by => users.id)
#  fk_rails_...  (updated_by => users.id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  let(:user) { build(:user) }

  it { is_expected.to act_as_paranoid }

  it "has default all_access as false" do
    expect(user.all_access).to eq(false)
  end

  describe '#associations' do
    it { is_expected.to belong_to(:company).optional }
    it { is_expected.to have_many(:user_roles) }
    it { is_expected.to have_many(:roles).through(:user_roles) }
  end

  describe ".for_actor scoped" do
    let(:company1) { create(:company) }
    let(:company2) { create(:company) }

    let(:user1) { create(:user, company: company1) }
    let(:user2) { create(:user, company: company2) }

    context "when user has all_access" do
      let(:user) { create(:user, all_access: true) }

      it "returns all users" do
        expect(User.for_actor(user)).to include(user1, user2)
      end
    end

    context "when user has limited access" do
      let(:user) { create(:user, company: create(:company)) }

      it "returns only company products" do
        expect(User.for_actor(user).count).to eq(1)
        expect(User.for_actor(user).first).to eq(user)
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  all_access             :boolean          default(FALSE), not null
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
#

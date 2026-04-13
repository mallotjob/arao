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
    it { is_expected.to belong_to(:creator).class_name('User').optional }
    it { is_expected.to belong_to(:updater).class_name('User').optional }
    it { is_expected.to have_many(:user_roles) }
    it { is_expected.to have_many(:roles).through(:user_roles) }
  end

  describe '#validations' do
    context 'created_by_required_unless_all_access' do
      let(:creator) { create(:user, :admin) }

      it 'is valid when user has all_access without created_by' do
        user = build(:user, :admin, created_by: nil)
        expect(user).to be_valid
      end

      it 'is valid when user does not have all_access but has created_by' do
        user = build(:user, created_by: creator.id)
        expect(user).to be_valid
      end

      it 'is invalid when user does not have all_access and no created_by' do
        user = build(:user, all_access: false, created_by: nil)
        expect(user).to be_invalid
        expect(user.errors[:created_by]).to include('is required unless user has all access')
      end
    end
  end

  describe ".for_actor scoped" do
    let(:company1) { create(:company) }
    let(:company2) { create(:company) }

    let(:user_admin) { create(:user, :admin) }
    let(:user1) { create(:user, created_by: user_admin.id, company: company1) }
    let(:user2) { create(:user, created_by: user_admin.id, company: company2) }

    context "when user has all_access" do
      it "returns all users" do
        expect(User.for_actor(user_admin)).to include(user1, user2)
      end
    end

    context "when user has limited access" do
      let(:user) { create(:user, created_by: user_admin.id, company: create(:company)) }

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

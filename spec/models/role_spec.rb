require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it { should have_many(:user_roles).dependent(:destroy) }
    it { should have_many(:users).through(:user_roles) }
    it { should have_many(:role_permissions) }
    it { should have_many(:permissions).through(:role_permissions) }
  end

  describe 'validations' do
    subject { build(:role) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
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

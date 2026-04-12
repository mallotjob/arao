require 'rails_helper'

RSpec.describe Permission, type: :model do
  describe 'associations' do
    it { should have_many(:role_permissions) }
    it { should have_many(:roles).through(:role_permissions) }
  end

  describe 'ACTIONS constant' do
    it 'includes expected actions' do
      expect(Permission::ACTIONS).to eq(%w[create read update destroy manage])
    end

    it 'is frozen' do
      expect(Permission::ACTIONS).to be_frozen
    end
  end

  describe '.generate_for_models' do
    let(:existing_permission) { create(:permission, action: 'create', subject: 'User') }

    before do
      existing_permission
    end

    it 'creates permissions for all models' do
      expect { Permission.generate_for_models }.to change(Permission, :count).by_at_least(1)
    end

    it 'does not duplicate existing permissions' do
      initial_count = Permission.count
      Permission.generate_for_models
      expect(Permission.count).to eq(45)
    end

    it 'creates all defined actions for each model' do
      Permission.generate_for_models
      user_permissions = Permission.where(subject: 'User')
      expect(user_permissions.pluck(:action).sort).to eq(Permission::ACTIONS.sort)
    end
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

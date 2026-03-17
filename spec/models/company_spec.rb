require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { company }

  let(:company) { build(:company) }

  it { is_expected.to act_as_paranoid }

  describe '#associations' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:beneficiaries) }
    it { is_expected.to have_many(:balances) }
    it { is_expected.to have_many(:products).through(:balances) }
  end

  describe ".for_actor scoped" do
    let(:company1) { create(:company) }
    let(:company2) { create(:company) }


    context "when user has all_access" do
      let(:user) { create(:user, all_access: true) }

      it "returns all companies" do
        expect(Company.for_actor(user)).to include(company1, company2)
      end
    end

    context "when user has limited access" do
      let(:user) { create(:user, company: company1) }

      it "returns only company of the user" do
        expect(Company.for_actor(user).count).to eq(1)
        expect(Company.for_actor(user).first).to eq(company1)
      end
    end
  end
end

# == Schema Information
#
# Table name: companies
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_deleted_at  (deleted_at)
#

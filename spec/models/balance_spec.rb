require 'rails_helper'

RSpec.describe Balance, type: :model do
  subject { balance }

  let(:balance) { build(:balance) }

  describe '#associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:products) }
  end

  describe ".for_actor scoped" do
    let(:balance1) { create(:balance) }
    let(:balance2) { create(:balance) }

    context "when user has all_access" do
      let(:user) { create(:user, all_access: true) }

      it "returns all balances" do
        expect(Balance.for_actor(user)).to include(balance1, balance2)
      end
    end

    context "when user has limited access" do
      let(:user) { create(:user, company: balance1.company) }

      it "returns only balance with same company" do
        expect(Balance.for_actor(user).count).to eq(1)
        expect(Balance.for_actor(user).first).to eq(balance1)
      end
    end
  end
end

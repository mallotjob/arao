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
end

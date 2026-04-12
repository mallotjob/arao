require 'rails_helper'

RSpec.describe UserQuery, type: :query do
  describe '#search' do
    let(:company1) { create(:company) }
    let(:company2) { create(:company) }
    let(:role1) { create(:role, name: 'admin') }
    let(:role2) { create(:role, name: 'manager') }

    let(:user1) { create(:user, first_name: 'John', last_name: 'Doe', email: 'john@example.com', username: 'johndoe', company: company1) }
    let(:user2) { create(:user, first_name: 'Jane', last_name: 'Smith', email: 'jane@example.com', username: 'janesmith', company: company2) }
    let(:user3) { create(:user, first_name: 'Bob', last_name: 'Johnson', email: 'bob@example.com', username: 'bobjohnson', company: company1) }

    before do
      user1.roles << role1
      user2.roles << role2
      user3.roles << role1
    end

    context 'with no filters' do
      it 'returns all users' do
        query = UserQuery.new.search({})
        expect(query.count).to eq(3)
      end
    end

    context 'with search filter' do
      it 'searches by first_name' do
        query = UserQuery.new.search(search: 'John')
        expect(query).to include(user1, user3)
        expect(query).not_to include(user2)
      end

      it 'searches by last_name' do
        query = UserQuery.new.search(search: 'Smith')
        expect(query).to include(user2)
        expect(query).not_to include(user1, user3)
      end

      it 'searches by email' do
        query = UserQuery.new.search(search: 'jane@example.com')
        expect(query).to include(user2)
        expect(query).not_to include(user1, user3)
      end

      it 'searches by username' do
        query = UserQuery.new.search(search: 'johndoe')
        expect(query).to include(user1)
        expect(query).not_to include(user2, user3)
      end

      it 'is case insensitive' do
        query = UserQuery.new.search(search: 'JOHN')
        expect(query).to include(user1, user3)
      end

      it 'handles partial matches' do
        query = UserQuery.new.search(search: 'john')
        expect(query).to include(user1, user3)
      end
    end

    context 'with role filter' do
      it 'filters by role' do
        query = UserQuery.new.search(role: 'admin')
        expect(query).to include(user1, user3)
        expect(query).not_to include(user2)
      end
    end

    context 'with company filter' do
      it 'filters by company_id' do
        query = UserQuery.new.search(company_id: company1.id)
        expect(query).to include(user1, user3)
        expect(query).not_to include(user2)
      end
    end

    context 'with multiple filters' do
      it 'applies search and role filter together' do
        query = UserQuery.new.search(search: 'John', role: 'admin')
        expect(query).to include(user1, user3)
        expect(query).not_to include(user2)
      end

      it 'applies search and company filter together' do
        query = UserQuery.new.search(search: 'John', company_id: company1.id)
        expect(query).to include(user1, user3)
        expect(query).not_to include(user2)
      end

      it 'applies all filters together' do
        query = UserQuery.new.search(search: 'John', role: 'admin', company_id: company1.id)
        expect(query).to include(user1, user3)
        expect(query).not_to include(user2)
      end
    end

    context 'with pagination' do
      it 'paginates results' do
        query = UserQuery.new.search(page: 1, per_page: 2)
        expect(query.count).to eq(2)
      end
    end

    context 'with custom relation' do
      it 'uses custom relation as base' do
        custom_relation = User.where(company_id: company1.id)
        query = UserQuery.new(custom_relation).search({})
        expect(query.count).to eq(2)
      end
    end
  end
end

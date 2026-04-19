require 'rails_helper'

RSpec.describe Admin::Api::V1::UsersController, type: :request do
  let(:admin_user) { create(:user, all_access: true) }
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company, created_by: admin_user) }
  let(:role) { create(:role) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    let!(:users) { create_list(:user, 3, created_by: admin_user) }

    context 'without filters' do
      it 'returns all users' do
        get admin_api_v1_users_url
        expect(response).to have_http_status(:success)
      end
    end

    context 'with search filter' do
      it 'filters users by search term' do
        get admin_api_v1_users_url, params: { search: user.first_name }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with role filter' do
      it 'filters users by role' do
        get admin_api_v1_users_url, params: { role: 'admin' }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with company filter' do
      it 'filters users by company' do
        get admin_api_v1_users_url, params: { company_id: company.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with pagination' do
      it 'paginates results' do
        get admin_api_v1_users_url, params: { page: 1, per_page: 2 }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    it 'returns the user' do
      get admin_api_v1_user_url(user.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        user: {
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@example.com',
          username: 'johndoe',
          password: 'Password123',
          password_confirmation: 'Password123',
          company_id: company.id,
          phone_number: '0373839232',
          role_ids: [role.id]
        }
      }
    end

    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post admin_api_v1_users_url, params: valid_params
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'creates user with phone number' do
        post admin_api_v1_users_url, params: valid_params

        expect(User.find_by(phone_number: '0373839232').present?).to be true
      end

      it 'creates user with phone number starting with 0' do
        params_with_zero_phone = valid_params.deep_dup
        params_with_zero_phone[:user][:phone_number] = '0340441586'
        post admin_api_v1_users_url, params: params_with_zero_phone

        expect(User.find_by(phone_number: '0340441586').present?).to be true
      end

      it 'creates user with phone number with country code' do
        params_with_country_phone = valid_params.deep_dup
        params_with_country_phone[:user][:phone_number] = '+261340441586'
        post admin_api_v1_users_url, params: params_with_country_phone

        expect(User.find_by(phone_number: '+261340441586').present?).to be true
      end

      it 'creates user with China phone number' do
        params_with_china_phone = valid_params.deep_dup
        params_with_china_phone[:user][:phone_number] = '13812345678'
        post admin_api_v1_users_url, params: params_with_china_phone

        expect(User.find_by(phone_number: '13812345678').present?).to be true
      end

      it 'creates user with China phone number with country code' do
        params_with_china_country_phone = valid_params.deep_dup
        params_with_china_country_phone[:user][:phone_number] = '+8613812345678'
        post admin_api_v1_users_url, params: params_with_china_country_phone

        expect(User.find_by(phone_number: '+8613812345678').present?).to be true
      end

      it 'rejects phone number with invalid prefix' do
        params_with_invalid_prefix = valid_params.deep_dup
        params_with_invalid_prefix[:user][:phone_number] = '0550441586'
        post admin_api_v1_users_url, params: params_with_invalid_prefix
        expect(response).to have_http_status(:unprocessable_content)
      end

      it 'rejects invalid phone number format' do
        params_with_invalid_phone = valid_params.deep_dup
        params_with_invalid_phone[:user][:phone_number] = 'abc123'
        post admin_api_v1_users_url, params: params_with_invalid_phone
        expect(response).to have_http_status(:unprocessable_content)
      end

      it 'rejects phone number that is too short' do
        params_with_short_phone = valid_params.deep_dup
        params_with_short_phone[:user][:phone_number] = '123'
        post admin_api_v1_users_url, params: params_with_short_phone
        expect(response).to have_http_status(:unprocessable_content)
      end

      it 'creates user with all access' do
        params_with_access = valid_params.deep_dup
        params_with_access[:user][:all_access] = true
        post admin_api_v1_users_url, params: params_with_access
        expect(User.last.all_access).to be true
      end
    end

    context 'with roles' do
      let(:role1) { create(:role, name: 'admin') }
      let(:role2) { create(:role, name: 'manager') }

      it 'creates user with roles' do
        params_with_roles = valid_params.deep_dup
        params_with_roles[:user][:role_ids] = [role1.id, role2.id]
        post admin_api_v1_users_url, params: params_with_roles
        user = User.find_by(email: 'john@example.com')

        expect(user.roles.count).to eq(2)
        expect(user.roles).to include(role1, role2)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          user: {
            first_name: '',
            email: 'invalid'
          }
        }
      end

      it 'does not create a user' do
        expect {
          post admin_api_v1_users_url, params: invalid_params
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end

      it 'does not create user without roles' do
        params_without_roles = valid_params.deep_dup
        params_without_roles[:user][:role_ids] = []
        post admin_api_v1_users_url, params: params_without_roles
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:update_params) do
      {
        id: user.id,
        user: {
          first_name: 'Updated'
        }
      }
    end

    it 'updates the user' do
      patch admin_api_v1_user_url(user.id), params: update_params
      user.reload
      expect(user.first_name).to eq('Updated')
      expect(response).to have_http_status(:success)
    end

    it 'updates user phone number' do
      params_with_phone = update_params.deep_dup
      params_with_phone[:user][:phone_number] = '0380000000'
      patch admin_api_v1_user_url(user.id), params: params_with_phone
      user.reload
      expect(user.phone_number).to eq('0380000000')
    end

    it 'rejects invalid phone number format on update' do
      params_with_invalid_phone = update_params.deep_dup
      params_with_invalid_phone[:user][:phone_number] = 'abc123'
      patch admin_api_v1_user_url(user.id), params: params_with_invalid_phone
      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'updates user all access' do
      params_with_access = update_params.deep_dup
      params_with_access[:user][:all_access] = true
      patch admin_api_v1_user_url(user.id), params: params_with_access
      user.reload
      expect(user.all_access).to be true
    end

    context 'with roles' do
      let(:role1) { create(:role, name: 'admin') }
      let(:role2) { create(:role, name: 'manager') }

      it 'updates user roles' do
        params_with_roles = update_params.deep_dup
        params_with_roles[:user][:role_ids] = [role1.id, role2.id]
        patch admin_api_v1_user_url(user.id), params: params_with_roles
        user.reload
        expect(user.roles.count).to eq(2)
        expect(user.roles).to include(role1, role2)
      end

      it 'replaces existing roles with new ones' do
        user.roles << create(:role, name: 'user')
        params_with_roles = update_params.deep_dup
        params_with_roles[:user][:role_ids] = [role1.id, role2.id]
        patch admin_api_v1_user_url(user.id), params: params_with_roles
        user.reload

        expect(user.roles.count).to eq(2)
        expect(user.roles).to include(role1, role2)
        expect(user.roles.map(&:name)).not_to include('user')
      end

      it 'removes all roles when empty array provided' do
        params_without_roles = update_params.deep_dup
        params_without_roles[:user][:role_ids] = []
        patch admin_api_v1_user_url(user.id), params: params_without_roles
        user.reload
        expect(user.roles.count).to eq(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect {
        delete admin_api_v1_user_url(user.id)
      }.to change(User, :count).by(0)
      expect(response).to have_http_status(:no_content)
      expect(user.reload.deleted_at).to be_present
    end
  end

  describe 'GET #me' do
    it 'returns current user' do
      get me_admin_api_v1_users_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #user_stats' do
    it 'returns user stats for current user' do
      get stats_admin_api_v1_user_url(admin_user.id)
      expect(response).to have_http_status(:success)
    end

    it 'returns user stats for other user when admin' do
      get stats_admin_api_v1_user_url(user.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update_me' do
    let(:update_params) do
      {
        user: {
          first_name: 'Updated'
        }
      }
    end

    it 'updates current user' do
      patch me_admin_api_v1_users_url, params: update_params
      admin_user.reload
      expect(admin_user.first_name).to eq('Updated')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update_password' do
    let(:password_params) do
      {
        user: {
          current_password: admin_user.password,
          password: 'newpassword123',
          password_confirmation: 'newpassword123'
        }
      }
    end

    context 'with correct current password' do
      it 'updates the password' do
        patch password_admin_api_v1_user_url(user.id), params: password_params
        expect(response).to have_http_status(:success)
      end
    end

    context 'with incorrect current password' do
      let(:invalid_password_params) do
        {
          user: {
            current_password: 'wrongpassword',
            password: 'newpassword123',
            password_confirmation: 'newpassword123'
          }
        }
      end

      it 'does not update the password' do
        patch password_admin_api_v1_user_url(user.id), params: invalid_password_params
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end

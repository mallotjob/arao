require 'rails_helper'

RSpec.describe "Admin::Api::Users", type: :request do
  let(:admin_user) { create(:user, all_access: true) }
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/api/v1/users" do
    let!(:users) { create_list(:user, 3) }

    it "returns http success" do
      get admin_api_v1_users_url
      expect(response).to have_http_status(:success)
    end

    it "returns users in JSON format" do
      get admin_api_v1_users_url
      expect(response.content_type).to include('application/json')
    end

    context "with search parameter" do
      it "filters users by search term" do
        get admin_api_v1_users_url, params: { search: user.first_name }
        expect(response).to have_http_status(:success)
      end
    end

    context "with role parameter" do
      let(:role) { create(:role, name: 'admin') }
      let(:user_with_role) { create(:user) }

      before do
        user_with_role.roles << role
      end

      it "filters users by role" do
        get admin_api_v1_users_url, params: { role: 'admin' }
        expect(response).to have_http_status(:success)
      end
    end

    context "with company parameter" do
      it "filters users by company" do
        get admin_api_v1_users_url, params: { company_id: company.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "with pagination" do
      it "paginates results" do
        get admin_api_v1_users_url, params: { page: 1, per_page: 2 }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /admin/api/v1/users/:id" do
    it "returns http success" do
      get admin_api_v1_user_url(user.id)
      expect(response).to have_http_status(:success)
    end

    it "returns user in JSON format" do
      get admin_api_v1_user_url(user.id)
      expect(response.content_type).to include('application/json')
    end
  end

  describe "POST /admin/api/v1/users" do
    let(:valid_params) do
      {
        user: {
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@example.com',
          username: 'johndoe',
          password: 'password123',
          company_id: company.id
        }
      }
    end

    context "with valid params" do
      it "creates a new user" do
        expect {
          post admin_api_v1_users_url, params: valid_params
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it "returns user in JSON format" do
        post admin_api_v1_users_url, params: valid_params
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          user: {
            first_name: '',
            email: 'invalid'
          }
        }
      end

      it "does not create a user" do
        expect {
          post admin_api_v1_users_url, params: invalid_params
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /admin/api/v1/users/:id" do
    let(:update_params) do
      {
        user: {
          first_name: 'Updated'
        }
      }
    end

    it "updates the user" do
      patch admin_api_v1_user_url(user.id), params: update_params
      user.reload
      expect(user.first_name).to eq('Updated')
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /admin/api/v1/users/:id" do
    it "deletes the user" do
      expect {
        delete admin_api_v1_user_url(user.id)
      }.to change(User, :count).by(0)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "GET /admin/api/v1/users/me" do
    it "returns current user" do
      get me_admin_api_v1_users_url
      expect(response).to have_http_status(:success)
    end

    it "returns user in JSON format" do
      get me_admin_api_v1_users_url
      expect(response.content_type).to include('application/json')
    end
  end

  describe "GET /admin/api/v1/users/me/stats" do
    it "returns user stats" do
      get stats_admin_api_v1_users_url
      expect(response).to have_http_status(:success)
    end

    it "returns stats in JSON format" do
      get stats_admin_api_v1_users_url
      expect(response.content_type).to include('application/json')
    end
  end

  describe "PATCH /admin/api/v1/users/me" do
    let(:update_params) do
      {
        user: {
          first_name: 'Updated'
        }
      }
    end

    it "updates current user" do
      patch me_admin_api_v1_users_url, params: update_params
      admin_user.reload
      expect(admin_user.first_name).to eq('Updated')
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /admin/api/v1/users/me/password" do
    let(:password_params) do
      {
        user: {
          current_password: 'password',
          password: 'newpassword123',
          password_confirmation: 'newpassword123'
        }
      }
    end

    before do
      admin_user.password = 'password'
      admin_user.save
    end

    context "with correct current password" do
      it "updates the password" do
        patch password_admin_api_v1_user_url(admin_user.id), params: password_params
        expect(response).to have_http_status(:success)
      end
    end

    context "with incorrect current password" do
      let(:invalid_password_params) do
        {
          user: {
            current_password: 'wrongpassword',
            password: 'newpassword123',
            password_confirmation: 'newpassword123'
          }
        }
      end

      it "does not update the password" do
        patch password_admin_api_v1_user_url(admin_user.id), params: invalid_password_params
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end

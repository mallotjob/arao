require 'rails_helper'

RSpec.describe "Admin::Api::Roles", type: :request do
  let(:admin_user) { create(:user, all_access: true) }
  let(:role) { create(:role) }

  before do
    sign_in admin_user
  end

  describe "GET /api/v1/roles" do
    it "returns http success" do
      get admin_api_v1_roles_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /api/v1/roles" do
    it "returns http success" do
      post admin_api_v1_roles_url, params: { role: { name: 'Test Role' } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /api/v1/roles/:id" do
    it "returns http success" do
      get admin_api_v1_role_url(role.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/v1/roles/:id" do
    it "returns http success" do
      patch admin_api_v1_role_url(role.id), params: { role: { name: 'Updated Role' } }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /api/v1/roles/:id" do
    it "returns http success" do
      delete admin_api_v1_role_url(role.id)
      expect(response).to have_http_status(:no_content)
    end
  end
end

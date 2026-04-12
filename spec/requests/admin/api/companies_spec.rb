require 'rails_helper'

RSpec.describe "Admin::Api::Companies", type: :request do
  let(:admin_user) { create(:user, all_access: true) }
  let(:company) { create(:company) }

  before do
    sign_in admin_user
  end

  describe "GET /api/v1/companies" do
    it "returns http success" do
      get admin_api_v1_companies_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /api/v1/companies" do
    it "returns http success" do
      post admin_api_v1_companies_url, params: { company: { name: 'Test Company' } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /api/v1/companies/:id" do
    it "returns http success" do
      get admin_api_v1_company_url(company.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/v1/companies/:id" do
    it "returns http success" do
      patch admin_api_v1_company_url(company.id), params: { company: { name: 'Updated Company' } }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /api/v1/companies/:id" do
    it "returns http success" do
      delete admin_api_v1_company_url(company.id)
      expect(response).to have_http_status(:no_content)
    end
  end
end

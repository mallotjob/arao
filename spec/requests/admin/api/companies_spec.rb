require 'rails_helper'

RSpec.describe "Admin::Api::Companies", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/api/companies/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admin/api/companies/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/admin/api/companies/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/admin/api/companies/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end

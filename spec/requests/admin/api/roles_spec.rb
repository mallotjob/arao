require 'rails_helper'

RSpec.describe "Admin::Api::Roles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/api/roles/index"
      expect(response).to have_http_status(:success)
    end
  end
end

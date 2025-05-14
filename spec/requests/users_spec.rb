require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let(:token) do
    post "/login", params: { email: user.email, password: "password" }
    JSON.parse(response.body)["token"]
  end

  before do
    user
  end

  describe "GET /api/users" do
    it "returns all users" do
      get "/api/users", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
    end
  end

  describe "GET /api/users/me" do
    it "returns the current authenticated user with tasks" do
      task = create(:task, user: user)
      get "/api/users/me", headers: headers

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body["id"]).to eq(user.id)
      expect(body["tasks"]).to be_an(Array)
      expect(body["tasks"].first["id"]).to eq(task.id)
    end
  end
end

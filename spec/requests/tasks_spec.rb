require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let(:token) do
    post "/login", params: { email: user.email, password: "password" }
    JSON.parse(response.body)["token"]
  end

  describe "GET /api/tasks" do
    it "returns all tasks for the authenticated user" do
      create_list(:task, 3, user: user)

      get "/api/tasks", headers: headers

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["tasks"].size).to eq(3)
      expect(body["tasks"][0]["title"]).to eq("Tarea de prueba")
    end
  end

  describe "GET /api/tasks/:id" do
    it "returns a specific task" do
      task = create(:task, user: user)

      get "/api/tasks/#{task.id}", headers: headers

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["task"]["id"]).to eq(task.id)
    end
  end

  describe "POST /api/tasks" do
    it "creates a task" do
      post "/api/tasks", params: {
        task: {
          title: "Test Task",
          description: "Test description",
          due_date: Date.today,
          status: "pending",
          user_id: user.id
        }
      }, headers: headers

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["task"]["title"]).to eq("Test Task")
      expect(Task.last.title).to eq("Test Task")
    end
  end

  describe "PUT /api/tasks/:id" do
    it "updates a task" do
      task = create(:task, user: user, title: "Tarea vieja")

      put "/api/tasks/#{task.id}", params: { task: { title: "Tarea nueva" } }, headers: headers

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["task"]["title"]).to eq("Tarea nueva")
      expect(task.reload.title).to eq("Tarea nueva")
    end
  end

  describe "DELETE /api/tasks/:id" do
    it "deletes a task" do
      task = create(:task, user: user)

      delete "/api/tasks/#{task.id}", headers: headers

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["tasks"]).to be_an(Array)
      expect(body["tasks"].none? { |t| t["id"] == task.id }).to be_truthy
    end
  end

  describe "authorization checks" do
    it "prevents a user from updating a task they don't own" do
      other_user = create(:user)
      task = create(:task, user: other_user)

      put "/api/tasks/#{task.id}", params: { task: { title: "Hacked" } }, headers: headers

      expect(response).to have_http_status(:not_found)
    end

    it "prevents a user from deleting a task they don't own" do
      other_user = create(:user)
      task = create(:task, user: other_user)

      delete "/api/tasks/#{task.id}", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end

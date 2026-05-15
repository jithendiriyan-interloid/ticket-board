require 'rails_helper'
RSpec.describe "User Registration", type: :request do
  describe "POST /users" do
    it "registers with valid credentials" do
      expect {
        post user_registration_path, params: {
          user: {
            email: "new@example.com",
            password: "Test@123",
            password_confirmation: "Test@123"
          }
        }
      }.to change(User, :count).by(1)
      expect(response).to have_http_status(:see_other)
    end
    it "fails without email" do
      post user_registration_path, params: {
        user: {
          email: "",
          password: "Test@123",
          password_confirmation: "Test@123"
        }
      }
      expect(response.body).to include("Email")
    end
    it "fails without special character password" do
      post user_registration_path, params: {
        user: {
          email: "test@example.com",
          password: "Test123",
          password_confirmation: "Test123"
        }
      }
      expect(response.body)
        .to include("must include at least one special character")
    end
  end
end

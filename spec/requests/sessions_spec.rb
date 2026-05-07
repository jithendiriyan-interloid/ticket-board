require 'rails_helper'
RSpec.describe "User Sessions", type: :request do
  let!(:user) { create(:user) }
  describe "Login" do
    it "logs in with valid credentials" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: "Test@123"
        }
      }
      expect(response).to have_http_status(:see_other)
      user.reload
      expect(user.sign_in_count).to eq(1)
    end
    it "fails with invalid password" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: "Wrong@123"
        }
      }
      expect(response.body).to include("Invalid")
    end
  end
  describe "Logout" do
    it "logs out successfully" do
      sign_in user
      delete destroy_user_session_path
      expect(response).to have_http_status(:see_other)
    end
  end
end
